import { supabase } from '@/lib/supabase';

export const supabaseDashboard = {
  // Get dashboard summary metrics
  async getSummaryMetrics(filters = {}) {
    try {
      const { branchId, startDate, endDate } = filters;
      
      // Get total outstanding amount
      let outstandingQuery = supabase
        .from('accounts')
        .select('outstandingAmount');
      
      if (branchId) {
        outstandingQuery = outstandingQuery.eq('branchId', branchId);
      }
      
      const { data: accounts, error: accountsError } = await outstandingQuery;
      if (accountsError) throw accountsError;
      
      const totalOutstanding = accounts.reduce((sum, acc) => sum + (acc.outstandingAmount || 0), 0);
      
      // Get collections data
      let collectionsQuery = supabase
        .from('collections')
        .select('amount, collectionDate');
      
      if (branchId) {
        collectionsQuery = collectionsQuery.eq('branchId', branchId);
      }
      
      if (startDate) {
        collectionsQuery = collectionsQuery.gte('collectionDate', startDate);
      }
      
      if (endDate) {
        collectionsQuery = collectionsQuery.lte('collectionDate', endDate);
      }
      
      const { data: collections, error: collectionsError } = await collectionsQuery;
      if (collectionsError) throw collectionsError;
      
      const totalCollected = collections.reduce((sum, col) => sum + (col.amount || 0), 0);
      const collectionRate = totalOutstanding > 0 ? (totalCollected / totalOutstanding) * 100 : 0;
      
      // Get active accounts count
      const { count: activeAccounts, error: activeError } = await supabase
        .from('accounts')
        .select('*', { count: 'exact', head: true })
        .eq('status', 'active');
      
      if (activeError) throw activeError;
      
      // Get PTP data
      let ptpQuery = supabase
        .from('promises_to_pay')
        .select('*');
      
      if (branchId) {
        ptpQuery = ptpQuery.eq('branchId', branchId);
      }
      
      const { data: ptps, error: ptpError } = await ptpQuery;
      if (ptpError) throw ptpError;
      
      const promisesToPay = ptps.length;
      const keptPTPs = ptps.filter(ptp => ptp.status === 'kept').length;
      const ptpKeptRate = promisesToPay > 0 ? (keptPTPs / promisesToPay) * 100 : 0;
      
      // Calculate average DPD
      const { data: dpdData, error: dpdError } = await supabase
        .from('accounts')
        .select('daysPastDue');
      
      if (dpdError) throw dpdError;
      
      const avgDPD = dpdData.length > 0 
        ? dpdData.reduce((sum, acc) => sum + (acc.daysPastDue || 0), 0) / dpdData.length 
        : 0;
      
      // Calculate NPL ratio
      const { count: nplCount, error: nplError } = await supabase
        .from('accounts')
        .select('*', { count: 'exact', head: true })
        .gte('daysPastDue', 90);
      
      if (nplError) throw nplError;
      
      const totalAccounts = accounts.length;
      const nplRatio = totalAccounts > 0 ? (nplCount / totalAccounts) * 100 : 0;
      
      return {
        totalOutstanding,
        totalCollected,
        collectionRate: collectionRate.toFixed(1),
        activeAccounts: activeAccounts || 0,
        promisesToPay,
        ptpKeptRate: ptpKeptRate.toFixed(1),
        avgDPD: Math.round(avgDPD),
        nplRatio: nplRatio.toFixed(1)
      };
    } catch (error) {
      console.error('Error fetching summary metrics:', error);
      throw error;
    }
  },

  // Get collection trend data
  async getCollectionTrend(filters = {}) {
    try {
      const { branchId, startDate, endDate } = filters;
      
      let query = supabase
        .from('collections')
        .select('amount, collectionDate, target')
        .order('collectionDate', { ascending: true });
      
      if (branchId) {
        query = query.eq('branchId', branchId);
      }
      
      if (startDate) {
        query = query.gte('collectionDate', startDate);
      }
      
      if (endDate) {
        query = query.lte('collectionDate', endDate);
      }
      
      const { data, error } = await query;
      if (error) throw error;
      
      // Group by date
      const groupedData = data.reduce((acc, item) => {
        const date = item.collectionDate;
        if (!acc[date]) {
          acc[date] = { date, collected: 0, target: 0, ptp: 0 };
        }
        acc[date].collected += item.amount || 0;
        acc[date].target += item.target || 0;
        return acc;
      }, {});
      
      return Object.values(groupedData);
    } catch (error) {
      console.error('Error fetching collection trend:', error);
      throw error;
    }
  },

  // Get aging buckets data
  async getAgingBuckets(filters = {}) {
    try {
      const { branchId } = filters;
      
      let query = supabase
        .from('accounts')
        .select('daysPastDue, outstandingAmount');
      
      if (branchId) {
        query = query.eq('branchId', branchId);
      }
      
      const { data, error } = await query;
      if (error) throw error;
      
      // Define aging buckets
      const buckets = [
        { bucket: 'Current', min: 0, max: 0, count: 0, amount: 0 },
        { bucket: '1-30', min: 1, max: 30, count: 0, amount: 0 },
        { bucket: '31-60', min: 31, max: 60, count: 0, amount: 0 },
        { bucket: '61-90', min: 61, max: 90, count: 0, amount: 0 },
        { bucket: '91-180', min: 91, max: 180, count: 0, amount: 0 },
        { bucket: '180+', min: 181, max: Infinity, count: 0, amount: 0 }
      ];
      
      // Categorize accounts into buckets
      data.forEach(account => {
        const dpd = account.daysPastDue || 0;
        const amount = account.outstandingAmount || 0;
        
        const bucket = buckets.find(b => dpd >= b.min && dpd <= b.max);
        if (bucket) {
          bucket.count++;
          bucket.amount += amount;
        }
      });
      
      // Calculate percentages
      const totalAmount = buckets.reduce((sum, b) => sum + b.amount, 0);
      
      return buckets.map(bucket => ({
        ...bucket,
        percentage: totalAmount > 0 ? (bucket.amount / totalAmount) * 100 : 0
      }));
    } catch (error) {
      console.error('Error fetching aging buckets:', error);
      throw error;
    }
  },

  // Get collector performance data
  async getCollectorPerformance(filters = {}) {
    try {
      const { branchId, startDate, endDate } = filters;
      
      // Get collectors
      const { data: collectors, error: collectorsError } = await supabase
        .from('users')
        .select('id, firstName, lastName')
        .eq('role', 'collector');
      
      if (collectorsError) throw collectorsError;
      
      // Get performance data for each collector
      const performanceData = await Promise.all(collectors.map(async (collector) => {
        let collectionsQuery = supabase
          .from('collections')
          .select('amount')
          .eq('collectorId', collector.id);
        
        if (branchId) {
          collectionsQuery = collectionsQuery.eq('branchId', branchId);
        }
        
        if (startDate) {
          collectionsQuery = collectionsQuery.gte('collectionDate', startDate);
        }
        
        if (endDate) {
          collectionsQuery = collectionsQuery.lte('collectionDate', endDate);
        }
        
        const { data: collections, error: colError } = await collectionsQuery;
        if (colError) throw colError;
        
        const collected = collections.reduce((sum, col) => sum + (col.amount || 0), 0);
        
        // Get cases count
        const { count: cases, error: casesError } = await supabase
          .from('accounts')
          .select('*', { count: 'exact', head: true })
          .eq('assignedTo', collector.id);
        
        if (casesError) throw casesError;
        
        // Get PTP rate
        const { data: ptps, error: ptpError } = await supabase
          .from('promises_to_pay')
          .select('status')
          .eq('collectorId', collector.id);
        
        if (ptpError) throw ptpError;
        
        const keptPTPs = ptps.filter(ptp => ptp.status === 'kept').length;
        const ptpRate = ptps.length > 0 ? (keptPTPs / ptps.length) * 100 : 0;
        
        return {
          name: `${collector.firstName} ${collector.lastName}`,
          collected,
          target: collected * 1.2, // Mock target
          cases: cases || 0,
          ptpRate: Math.round(ptpRate)
        };
      }));
      
      return performanceData;
    } catch (error) {
      console.error('Error fetching collector performance:', error);
      throw error;
    }
  },

  // Get product-wise NPF data
  async getProductWiseNPF(filters = {}) {
    try {
      const { branchId } = filters;
      
      // Get unique products
      const { data: products, error: productsError } = await supabase
        .from('accounts')
        .select('productType')
        .neq('productType', null);
      
      if (productsError) throw productsError;
      
      const uniqueProducts = [...new Set(products.map(p => p.productType))];
      
      // Calculate NPF for each product
      const npfData = await Promise.all(uniqueProducts.map(async (product) => {
        let query = supabase
          .from('accounts')
          .select('outstandingAmount, daysPastDue')
          .eq('productType', product);
        
        if (branchId) {
          query = query.eq('branchId', branchId);
        }
        
        const { data, error } = await query;
        if (error) throw error;
        
        const totalAmount = data.reduce((sum, acc) => sum + (acc.outstandingAmount || 0), 0);
        const npfAmount = data
          .filter(acc => acc.daysPastDue >= 90)
          .reduce((sum, acc) => sum + (acc.outstandingAmount || 0), 0);
        
        const npf = totalAmount > 0 ? (npfAmount / totalAmount) * 100 : 0;
        
        return {
          product,
          npf: npf.toFixed(1),
          amount: totalAmount
        };
      }));
      
      return npfData;
    } catch (error) {
      console.error('Error fetching product-wise NPF:', error);
      throw error;
    }
  },
};

export default supabaseDashboard;