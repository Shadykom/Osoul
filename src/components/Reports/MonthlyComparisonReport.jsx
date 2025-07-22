import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import { Download, TrendingUp, TrendingDown } from 'lucide-react';
import {
  BarChart, Bar, LineChart, Line, XAxis, YAxis, CartesianGrid,
  Tooltip, Legend, ResponsiveContainer, Cell
} from 'recharts';
import reportService from '../../services/report.service';
import { toast } from 'sonner';

const MONTHS = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];

const COLORS = ['#D69E2E', '#4A5568', '#3182CE', '#38A169', '#E53E3E', '#805AD5'];

export default function MonthlyComparisonReport() {
  const [data, setData] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [selectedYear, setSelectedYear] = useState(new Date().getFullYear());
  const [selectedBranch, setSelectedBranch] = useState('all');
  const [viewMode, setViewMode] = useState('chart'); // 'chart' or 'table'

  useEffect(() => {
    loadReport();
  }, [selectedYear, selectedBranch]);

  const loadReport = async () => {
    try {
      setIsLoading(true);
      const branchId = selectedBranch === 'all' ? null : selectedBranch;
      const reportData = await reportService.getMonthlyComparison(selectedYear, branchId);
      setData(reportData);
    } catch (error) {
      toast.error('Failed to load monthly comparison report');
      console.error(error);
    } finally {
      setIsLoading(false);
    }
  };

  const exportReport = async () => {
    try {
      const branchId = selectedBranch === 'all' ? null : selectedBranch;
      const blob = await reportService.exportReport('monthly-comparison', 'csv', {
        year: selectedYear,
        branchId
      });
      
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `monthly-comparison-${selectedYear}.csv`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
      
      toast.success('Report exported successfully');
    } catch (error) {
      toast.error('Failed to export report');
    }
  };

  const processChartData = () => {
    if (!data) return [];
    
    const chartData = [];
    
    for (let month = 1; month <= 12; month++) {
      const monthData = data[month] || [];
      const monthTotal = monthData.reduce((sum, branch) => sum + parseFloat(branch.total_collected || 0), 0);
      const monthTarget = monthData.reduce((sum, branch) => sum + parseFloat(branch.target_amount || 0), 0);
      
      chartData.push({
        month: MONTHS[month - 1],
        collected: monthTotal,
        target: monthTarget,
        achievement: monthTarget > 0 ? (monthTotal / monthTarget * 100).toFixed(1) : 0
      });
    }
    
    return chartData;
  };

  const calculateYearSummary = () => {
    if (!data) return { total: 0, target: 0, achievement: 0 };
    
    let totalCollected = 0;
    let totalTarget = 0;
    
    Object.values(data).forEach(monthData => {
      monthData.forEach(branch => {
        totalCollected += parseFloat(branch.total_collected || 0);
        totalTarget += parseFloat(branch.target_amount || 0);
      });
    });
    
    return {
      total: totalCollected,
      target: totalTarget,
      achievement: totalTarget > 0 ? (totalCollected / totalTarget * 100).toFixed(1) : 0
    };
  };

  if (isLoading) {
    return (
      <div className="space-y-4">
        <Skeleton className="h-32 w-full" />
        <Skeleton className="h-96 w-full" />
      </div>
    );
  }

  const chartData = processChartData();
  const yearSummary = calculateYearSummary();

  return (
    <div className="space-y-6">
      {/* Header and Controls */}
      <Card>
        <CardHeader>
          <div className="flex justify-between items-start">
            <div>
              <CardTitle>Monthly Collection Comparison</CardTitle>
              <CardDescription>
                Compare collection performance month by month
              </CardDescription>
            </div>
            <div className="flex gap-2">
              <Select value={selectedYear.toString()} onValueChange={(v) => setSelectedYear(parseInt(v))}>
                <SelectTrigger className="w-32">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  {[2023, 2024, 2025].map(year => (
                    <SelectItem key={year} value={year.toString()}>
                      {year}
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

      {/* Year Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium">Total Collected</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              SAR {yearSummary.total.toLocaleString('en-US', { minimumFractionDigits: 2 })}
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium">Year Target</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              SAR {yearSummary.target.toLocaleString('en-US', { minimumFractionDigits: 2 })}
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium">Achievement Rate</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center gap-2">
              <div className="text-2xl font-bold">{yearSummary.achievement}%</div>
              {yearSummary.achievement >= 100 ? (
                <TrendingUp className="h-5 w-5 text-green-600" />
              ) : (
                <TrendingDown className="h-5 w-5 text-red-600" />
              )}
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Monthly Chart */}
      <Card>
        <CardHeader>
          <CardTitle>Monthly Performance</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="h-96">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={chartData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="month" />
                <YAxis />
                <Tooltip formatter={(value) => `SAR ${value.toLocaleString()}`} />
                <Legend />
                <Bar dataKey="collected" fill="#D69E2E" name="Collected" />
                <Bar dataKey="target" fill="#4A5568" name="Target" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </CardContent>
      </Card>

      {/* Achievement Rate Chart */}
      <Card>
        <CardHeader>
          <CardTitle>Achievement Rate by Month</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="h-64">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={chartData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="month" />
                <YAxis />
                <Tooltip formatter={(value) => `${value}%`} />
                <Line 
                  type="monotone" 
                  dataKey="achievement" 
                  stroke="#3182CE" 
                  strokeWidth={2}
                  dot={{ fill: '#3182CE' }}
                />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </CardContent>
      </Card>

      {/* Monthly Details Table */}
      <Card>
        <CardHeader>
          <CardTitle>Monthly Details</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b">
                  <th className="text-left p-2">Month</th>
                  <th className="text-right p-2">Collected</th>
                  <th className="text-right p-2">Target</th>
                  <th className="text-right p-2">Achievement</th>
                  <th className="text-right p-2">Variance</th>
                </tr>
              </thead>
              <tbody>
                {chartData.map((month, index) => {
                  const variance = month.collected - month.target;
                  return (
                    <tr key={index} className="border-b">
                      <td className="p-2">{month.month}</td>
                      <td className="text-right p-2">
                        SAR {month.collected.toLocaleString('en-US', { minimumFractionDigits: 2 })}
                      </td>
                      <td className="text-right p-2">
                        SAR {month.target.toLocaleString('en-US', { minimumFractionDigits: 2 })}
                      </td>
                      <td className="text-right p-2">
                        <span className={month.achievement >= 100 ? 'text-green-600' : 'text-red-600'}>
                          {month.achievement}%
                        </span>
                      </td>
                      <td className={`text-right p-2 ${variance >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                        SAR {Math.abs(variance).toLocaleString('en-US', { minimumFractionDigits: 2 })}
                        {variance >= 0 ? ' ↑' : ' ↓'}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}