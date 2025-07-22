import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Button } from '@/components/ui/button';
import { DatePickerWithRange } from '@/components/ui/date-range-picker';
import { Skeleton } from '@/components/ui/skeleton';
import { Download, Building, TrendingUp, Award } from 'lucide-react';
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
  ResponsiveContainer, RadarChart, PolarGrid, PolarAngleAxis,
  PolarRadiusAxis, Radar, Cell
} from 'recharts';
import reportService from '../../services/report.service';
import { toast } from 'sonner';
import { format, subDays } from 'date-fns';

const COLORS = ['#D69E2E', '#4A5568', '#3182CE', '#38A169', '#E53E3E', '#805AD5'];

export default function BranchComparisonReport() {
  const [data, setData] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [dateRange, setDateRange] = useState({
    from: subDays(new Date(), 30),
    to: new Date()
  });
  const [selectedRegion, setSelectedRegion] = useState('all');
  const [sortBy, setSortBy] = useState('total_collected');

  useEffect(() => {
    loadReport();
  }, [dateRange, selectedRegion]);

  const loadReport = async () => {
    try {
      setIsLoading(true);
      const reportData = await reportService.getBranchComparison(
        format(dateRange.from, 'yyyy-MM-dd'),
        format(dateRange.to, 'yyyy-MM-dd'),
        selectedRegion === 'all' ? null : selectedRegion
      );
      setData(reportData);
    } catch (error) {
      toast.error('Failed to load branch comparison report');
      console.error(error);
    } finally {
      setIsLoading(false);
    }
  };

  const exportReport = async () => {
    try {
      const blob = await reportService.exportReport('branch-comparison', 'csv', {
        startDate: format(dateRange.from, 'yyyy-MM-dd'),
        endDate: format(dateRange.to, 'yyyy-MM-dd'),
        region: selectedRegion === 'all' ? null : selectedRegion
      });
      
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `branch-comparison-${format(new Date(), 'yyyy-MM-dd')}.csv`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
      
      toast.success('Report exported successfully');
    } catch (error) {
      toast.error('Failed to export report');
    }
  };

  const getSortedData = () => {
    return [...data].sort((a, b) => {
      const aValue = parseFloat(a[sortBy] || 0);
      const bValue = parseFloat(b[sortBy] || 0);
      return bValue - aValue;
    });
  };

  const getTopPerformers = () => {
    return getSortedData().slice(0, 3);
  };

  const getRegions = () => {
    const regions = new Set(data.map(branch => branch.region).filter(Boolean));
    return Array.from(regions);
  };

  if (isLoading) {
    return (
      <div className="space-y-4">
        <Skeleton className="h-32 w-full" />
        <Skeleton className="h-96 w-full" />
      </div>
    );
  }

  const sortedData = getSortedData();
  const topPerformers = getTopPerformers();
  const regions = getRegions();

  return (
    <div className="space-y-6">
      {/* Header and Controls */}
      <Card>
        <CardHeader>
          <div className="flex justify-between items-start">
            <div>
              <CardTitle>Branch Performance Comparison</CardTitle>
              <CardDescription>
                Compare performance across different branches
              </CardDescription>
            </div>
            <div className="flex gap-2">
              <DatePickerWithRange
                date={dateRange}
                onDateChange={setDateRange}
              />
              <Select value={selectedRegion} onValueChange={setSelectedRegion}>
                <SelectTrigger className="w-40">
                  <SelectValue placeholder="All Regions" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Regions</SelectItem>
                  {regions.map(region => (
                    <SelectItem key={region} value={region}>
                      {region}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <Button variant="outline" onClick={exportReport}>
                <Download className="h-4 w-4 mr-2" />
                Export
              </Button>
            </div>
          </div>
        </CardHeader>
      </Card>

      {/* Top Performers */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {topPerformers.map((branch, index) => (
          <Card key={branch.branch_id} className="relative overflow-hidden">
            <div className={`absolute top-0 right-0 p-2 ${
              index === 0 ? 'text-yellow-600' : index === 1 ? 'text-gray-600' : 'text-orange-600'
            }`}>
              <Award className="h-6 w-6" />
            </div>
            <CardHeader className="pb-2">
              <CardTitle className="text-lg">{branch.branch_name}</CardTitle>
              <CardDescription>{branch.region} - {branch.city}</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-2">
                <div>
                  <p className="text-sm text-gray-500">Total Collected</p>
                  <p className="text-xl font-bold">
                    SAR {parseFloat(branch.total_collected).toLocaleString('en-US', { minimumFractionDigits: 2 })}
                  </p>
                </div>
                <div className="grid grid-cols-2 gap-2 text-sm">
                  <div>
                    <p className="text-gray-500">Transactions</p>
                    <p className="font-medium">{branch.transaction_count}</p>
                  </div>
                  <div>
                    <p className="text-gray-500">Avg Transaction</p>
                    <p className="font-medium">
                      SAR {parseFloat(branch.avg_transaction).toLocaleString('en-US', { minimumFractionDigits: 2 })}
                    </p>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Branch Performance Chart */}
      <Card>
        <CardHeader>
          <div className="flex justify-between items-center">
            <CardTitle>Collection Performance by Branch</CardTitle>
            <Select value={sortBy} onValueChange={setSortBy}>
              <SelectTrigger className="w-48">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="total_collected">Total Collected</SelectItem>
                <SelectItem value="transaction_count">Transaction Count</SelectItem>
                <SelectItem value="avg_transaction">Average Transaction</SelectItem>
                <SelectItem value="unique_customers">Unique Customers</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </CardHeader>
        <CardContent>
          <div className="h-96">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={sortedData.slice(0, 10)} layout="horizontal">
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" />
                <YAxis dataKey="branch_name" type="category" width={150} />
                <Tooltip formatter={(value) => `SAR ${value.toLocaleString()}`} />
                <Bar dataKey={sortBy} fill="#D69E2E">
                  {sortedData.slice(0, 10).map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </div>
        </CardContent>
      </Card>

      {/* Detailed Branch Table */}
      <Card>
        <CardHeader>
          <CardTitle>Branch Performance Details</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b">
                  <th className="text-left p-2">Rank</th>
                  <th className="text-left p-2">Branch</th>
                  <th className="text-left p-2">Region</th>
                  <th className="text-right p-2">Total Collected</th>
                  <th className="text-right p-2">Transactions</th>
                  <th className="text-right p-2">Avg Transaction</th>
                  <th className="text-right p-2">Customers</th>
                  <th className="text-right p-2">Daily Avg</th>
                </tr>
              </thead>
              <tbody>
                {sortedData.map((branch, index) => (
                  <tr key={branch.branch_id} className="border-b hover:bg-gray-50">
                    <td className="p-2">
                      <div className="flex items-center gap-2">
                        {index + 1}
                        {index < 3 && (
                          <Award className={`h-4 w-4 ${
                            index === 0 ? 'text-yellow-600' : index === 1 ? 'text-gray-600' : 'text-orange-600'
                          }`} />
                        )}
                      </div>
                    </td>
                    <td className="p-2 font-medium">{branch.branch_name}</td>
                    <td className="p-2">{branch.region}</td>
                    <td className="text-right p-2">
                      SAR {parseFloat(branch.total_collected).toLocaleString('en-US', { minimumFractionDigits: 2 })}
                    </td>
                    <td className="text-right p-2">{branch.transaction_count}</td>
                    <td className="text-right p-2">
                      SAR {parseFloat(branch.avg_transaction).toLocaleString('en-US', { minimumFractionDigits: 2 })}
                    </td>
                    <td className="text-right p-2">{branch.unique_customers}</td>
                    <td className="text-right p-2">
                      SAR {parseFloat(branch.daily_average).toLocaleString('en-US', { minimumFractionDigits: 2 })}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </CardContent>
      </Card>

      {/* Regional Summary */}
      {regions.length > 1 && (
        <Card>
          <CardHeader>
            <CardTitle>Regional Summary</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {regions.map(region => {
                const regionBranches = data.filter(b => b.region === region);
                const regionTotal = regionBranches.reduce((sum, b) => sum + parseFloat(b.total_collected || 0), 0);
                const regionTransactions = regionBranches.reduce((sum, b) => sum + parseInt(b.transaction_count || 0), 0);
                
                return (
                  <Card key={region}>
                    <CardHeader className="pb-2">
                      <CardTitle className="text-base flex items-center gap-2">
                        <Building className="h-4 w-4" />
                        {region}
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-2">
                        <div>
                          <p className="text-sm text-gray-500">Total Collected</p>
                          <p className="text-lg font-bold">
                            SAR {regionTotal.toLocaleString('en-US', { minimumFractionDigits: 2 })}
                          </p>
                        </div>
                        <div className="grid grid-cols-2 gap-2 text-sm">
                          <div>
                            <p className="text-gray-500">Branches</p>
                            <p className="font-medium">{regionBranches.length}</p>
                          </div>
                          <div>
                            <p className="text-gray-500">Transactions</p>
                            <p className="font-medium">{regionTransactions}</p>
                          </div>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                );
              })}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}