import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Button } from '@/components/ui/button';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Calendar } from '@/components/ui/calendar';
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover';
import { Badge } from '@/components/ui/badge';
import { Progress } from '@/components/ui/progress';
import { 
  BarChart, Bar, LineChart, Line, PieChart, Pie, Cell, 
  XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer,
  Area, AreaChart, RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, Radar
} from 'recharts';
import { 
  TrendingUp, TrendingDown, Users, DollarSign, Phone, 
  Calendar as CalendarIcon, Target, AlertCircle, CheckCircle,
  FileText, Briefcase, Clock, Activity
} from 'lucide-react';
import { format } from 'date-fns';
import { cn } from '@/lib/utils';
import { toast } from 'sonner';
import supabaseDashboard from '@/services/supabaseDashboard';

const CollectionDashboard = () => {
  const [selectedBranch, setSelectedBranch] = useState('all');
  const [selectedPeriod, setSelectedPeriod] = useState('month');
  const [dateRange, setDateRange] = useState({
    from: new Date(new Date().getFullYear(), new Date().getMonth(), 1),
    to: new Date()
  });
  const [isLoading, setIsLoading] = useState(true);
  
  // State for dashboard data
  const [summaryMetrics, setSummaryMetrics] = useState({
    totalOutstanding: 0,
    totalCollected: 0,
    collectionRate: 0,
    activeAccounts: 0,
    promisesToPay: 0,
    ptpKeptRate: 0,
    avgDPD: 0,
    nplRatio: 0
  });
  
  const [collectionTrend, setCollectionTrend] = useState([]);
  const [agingBuckets, setAgingBuckets] = useState([]);
  const [collectorPerformance, setCollectorPerformance] = useState([]);
  const [productWiseNPF, setProductWiseNPF] = useState([]);

  // Fetch dashboard data
  useEffect(() => {
    fetchDashboardData();
  }, [selectedBranch, dateRange]);

  const fetchDashboardData = async () => {
    setIsLoading(true);
    try {
      const filters = {
        branchId: selectedBranch !== 'all' ? selectedBranch : null,
        startDate: dateRange.from?.toISOString(),
        endDate: dateRange.to?.toISOString()
      };

      // Fetch all dashboard data in parallel
      const [metrics, trend, aging, collectors, npf] = await Promise.all([
        supabaseDashboard.getSummaryMetrics(filters),
        supabaseDashboard.getCollectionTrend(filters),
        supabaseDashboard.getAgingBuckets(filters),
        supabaseDashboard.getCollectorPerformance(filters),
        supabaseDashboard.getProductWiseNPF(filters)
      ]);

      setSummaryMetrics(metrics);
      setCollectionTrend(trend);
      setAgingBuckets(aging);
      setCollectorPerformance(collectors);
      setProductWiseNPF(npf);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
      toast.error('Failed to load dashboard data');
    } finally {
      setIsLoading(false);
    }
  };

  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884D8'];

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold">Collection Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor and analyze collection performance</p>
        </div>
        <div className="flex gap-4">
          <Select value={selectedBranch} onValueChange={setSelectedBranch}>
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Select Branch" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Branches</SelectItem>
              <SelectItem value="riyadh">Riyadh</SelectItem>
              <SelectItem value="jeddah">Jeddah</SelectItem>
              <SelectItem value="dammam">Dammam</SelectItem>
            </SelectContent>
          </Select>
          <Popover>
            <PopoverTrigger asChild>
              <Button variant="outline" className="w-[240px] justify-start text-left font-normal">
                <CalendarIcon className="mr-2 h-4 w-4" />
                {dateRange?.from ? (
                  dateRange.to ? (
                    <>
                      {format(dateRange.from, "LLL dd, y")} -{" "}
                      {format(dateRange.to, "LLL dd, y")}
                    </>
                  ) : (
                    format(dateRange.from, "LLL dd, y")
                  )
                ) : (
                  <span>Pick a date range</span>
                )}
              </Button>
            </PopoverTrigger>
            <PopoverContent className="w-auto p-0" align="start">
              <Calendar
                initialFocus
                mode="range"
                defaultMonth={dateRange?.from}
                selected={dateRange}
                onSelect={setDateRange}
                numberOfMonths={2}
              />
            </PopoverContent>
          </Popover>
        </div>
      </div>

      {/* Summary Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Outstanding</CardTitle>
            <DollarSign className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">SAR {(summaryMetrics.totalOutstanding / 1000000).toFixed(2)}M</div>
            <p className="text-xs text-muted-foreground">
              <span className="text-red-500">↑ 5.2%</span> from last month
            </p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Collected Amount</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">SAR {(summaryMetrics.totalCollected / 1000).toFixed(0)}K</div>
            <Progress value={summaryMetrics.collectionRate} className="mt-2" />
            <p className="text-xs text-muted-foreground mt-1">{summaryMetrics.collectionRate}% collection rate</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Active Accounts</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{summaryMetrics.activeAccounts}</div>
            <p className="text-xs text-muted-foreground">
              Avg DPD: {summaryMetrics.avgDPD} days
            </p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">PTP Performance</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{summaryMetrics.promisesToPay}</div>
            <div className="flex items-center gap-2 mt-2">
              <Badge variant="success">{summaryMetrics.ptpKeptRate}% Kept</Badge>
              <Badge variant="secondary">{summaryMetrics.nplRatio}% NPL</Badge>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Main Content Tabs */}
      <Tabs defaultValue="overview" className="space-y-4">
        <TabsList>
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="aging">Aging Analysis</TabsTrigger>
          <TabsTrigger value="performance">Collector Performance</TabsTrigger>
          <TabsTrigger value="products">Product Analysis</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
            {/* Collection Trend */}
            <Card>
              <CardHeader>
                <CardTitle>Collection Trend</CardTitle>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={collectionTrend}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="date" tickFormatter={(date) => format(new Date(date), 'MMM dd')} />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Line type="monotone" dataKey="collected" stroke="#8884d8" name="Collected" />
                    <Line type="monotone" dataKey="target" stroke="#82ca9d" name="Target" strokeDasharray="5 5" />
                  </LineChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>

            {/* PTP Analysis */}
            <Card>
              <CardHeader>
                <CardTitle>Promise to Pay Analysis</CardTitle>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <AreaChart data={collectionTrend}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="date" tickFormatter={(date) => format(new Date(date), 'MMM dd')} />
                    <YAxis />
                    <Tooltip />
                    <Area type="monotone" dataKey="ptp" stroke="#8884d8" fill="#8884d8" />
                  </AreaChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="aging" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Portfolio Aging Analysis</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={agingBuckets}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="bucket" />
                    <YAxis />
                    <Tooltip />
                    <Bar dataKey="amount" fill="#8884d8" />
                  </BarChart>
                </ResponsiveContainer>
                <ResponsiveContainer width="100%" height={300}>
                  <PieChart>
                    <Pie
                      data={agingBuckets}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      label={({ bucket, percentage }) => `${bucket}: ${percentage}%`}
                      outerRadius={80}
                      fill="#8884d8"
                      dataKey="percentage"
                    >
                      {agingBuckets.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip />
                  </PieChart>
                </ResponsiveContainer>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="performance" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Collector Performance Matrix</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {collectorPerformance.map((collector, index) => (
                  <div key={index} className="border rounded-lg p-4">
                    <div className="flex justify-between items-center mb-2">
                      <h4 className="font-medium">{collector.name}</h4>
                      <Badge variant={collector.collected >= collector.target * 0.9 ? "success" : "warning"}>
                        {((collector.collected / collector.target) * 100).toFixed(0)}% Achievement
                      </Badge>
                    </div>
                    <div className="grid grid-cols-4 gap-4 text-sm">
                      <div>
                        <p className="text-gray-600">Collected</p>
                        <p className="font-semibold">SAR {(collector.collected / 1000).toFixed(0)}K</p>
                      </div>
                      <div>
                        <p className="text-gray-600">Target</p>
                        <p className="font-semibold">SAR {(collector.target / 1000).toFixed(0)}K</p>
                      </div>
                      <div>
                        <p className="text-gray-600">Cases</p>
                        <p className="font-semibold">{collector.cases}</p>
                      </div>
                      <div>
                        <p className="text-gray-600">PTP Rate</p>
                        <p className="font-semibold">{collector.ptpRate}%</p>
                      </div>
                    </div>
                    <Progress value={(collector.collected / collector.target) * 100} className="mt-2" />
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="products" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Product-wise NPF Analysis</CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={400}>
                <RadarChart data={productWiseNPF}>
                  <PolarGrid />
                  <PolarAngleAxis dataKey="product" />
                  <PolarRadiusAxis />
                  <Radar name="NPF %" dataKey="npf" stroke="#8884d8" fill="#8884d8" fillOpacity={0.6} />
                </RadarChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default CollectionDashboard;