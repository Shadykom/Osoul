import React, { useState, useEffect } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Skeleton } from '@/components/ui/skeleton';
import {
  LineChart, Line, BarChart, Bar, PieChart, Pie, Cell,
  XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer
} from 'recharts';
import { TrendingUp, TrendingDown, DollarSign, Users, Building, FileText } from 'lucide-react';
import dashboardService from '../../services/dashboard.service';
import { format } from 'date-fns';

const COLORS = ['#D69E2E', '#4A5568', '#3182CE', '#38A169', '#E53E3E', '#805AD5'];

export default function DashboardWidget({ widget }) {
  const [data, setData] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    loadWidgetData();
  }, [widget.id]);

  const loadWidgetData = async () => {
    try {
      setIsLoading(true);
      setError(null);
      
      // Get date range based on widget config
      const endDate = new Date();
      const startDate = new Date();
      
      switch (widget.config?.period) {
        case 'week':
          startDate.setDate(startDate.getDate() - 7);
          break;
        case 'month':
          startDate.setMonth(startDate.getMonth() - 1);
          break;
        case 'quarter':
          startDate.setMonth(startDate.getMonth() - 3);
          break;
        case 'year':
          startDate.setFullYear(startDate.getFullYear() - 1);
          break;
        default:
          startDate.setMonth(startDate.getMonth() - 1);
      }
      
      const params = {
        startDate: format(startDate, 'yyyy-MM-dd'),
        endDate: format(endDate, 'yyyy-MM-dd'),
      };
      
      const widgetData = await dashboardService.getWidgetData(widget.id, params);
      setData(widgetData);
    } catch (err) {
      setError('Failed to load widget data');
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  if (isLoading) {
    return <Skeleton className="h-full w-full" />;
  }

  if (error) {
    return (
      <div className="flex items-center justify-center h-full text-red-500">
        {error}
      </div>
    );
  }

  const renderWidget = () => {
    switch (widget.widget_type) {
      case 'summary_card':
        return <SummaryCard data={data} config={widget.config} />;
      case 'line_chart':
        return <LineChartWidget data={data} config={widget.config} />;
      case 'bar_chart':
        return <BarChartWidget data={data} config={widget.config} />;
      case 'pie_chart':
        return <PieChartWidget data={data} config={widget.config} />;
      default:
        return <div>Unknown widget type</div>;
    }
  };

  return <div className="h-full">{renderWidget()}</div>;
}

// Summary Card Widget
function SummaryCard({ data, config }) {
  const getIcon = () => {
    switch (config.metric) {
      case 'total_collected':
        return <DollarSign className="h-6 w-6" />;
      case 'transaction_count':
        return <FileText className="h-6 w-6" />;
      case 'unique_customers':
        return <Users className="h-6 w-6" />;
      case 'active_branches':
        return <Building className="h-6 w-6" />;
      default:
        return <TrendingUp className="h-6 w-6" />;
    }
  };

  const formatValue = (value) => {
    if (!value) return '0';
    
    switch (config.metric) {
      case 'total_collected':
      case 'avg_transaction':
        return `SAR ${parseFloat(value).toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })}`;
      default:
        return value.toLocaleString('en-US');
    }
  };

  const value = data?.[config.metric] || 0;
  const previousValue = data?.previous?.[config.metric] || 0;
  const change = previousValue ? ((value - previousValue) / previousValue * 100).toFixed(1) : 0;
  const isPositive = change >= 0;

  return (
    <div className="h-full flex flex-col justify-between">
      <div className="flex items-center justify-between mb-4">
        <div className="p-2 bg-gray-100 rounded-lg">{getIcon()}</div>
        <div className={`flex items-center text-sm ${isPositive ? 'text-green-600' : 'text-red-600'}`}>
          {isPositive ? <TrendingUp className="h-4 w-4 mr-1" /> : <TrendingDown className="h-4 w-4 mr-1" />}
          {Math.abs(change)}%
        </div>
      </div>
      <div>
        <p className="text-2xl font-bold">{formatValue(value)}</p>
        <p className="text-sm text-gray-500 mt-1">
          vs {formatValue(previousValue)} last period
        </p>
      </div>
    </div>
  );
}

// Line Chart Widget
function LineChartWidget({ data, config }) {
  if (!Array.isArray(data) || data.length === 0) {
    return <div className="flex items-center justify-center h-full">No data available</div>;
  }

  const chartData = data.map(item => ({
    date: format(new Date(item.period_date), 'MMM dd'),
    value: parseFloat(item[config.metric] || item.total_collected || 0),
  }));

  return (
    <ResponsiveContainer width="100%" height="100%">
      <LineChart data={chartData} margin={{ top: 5, right: 5, left: 5, bottom: 5 }}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="date" />
        <YAxis />
        <Tooltip formatter={(value) => `SAR ${value.toLocaleString()}`} />
        <Line
          type="monotone"
          dataKey="value"
          stroke="#D69E2E"
          strokeWidth={2}
          dot={{ fill: '#D69E2E' }}
        />
      </LineChart>
    </ResponsiveContainer>
  );
}

// Bar Chart Widget
function BarChartWidget({ data, config }) {
  if (!Array.isArray(data) || data.length === 0) {
    return <div className="flex items-center justify-center h-full">No data available</div>;
  }

  const chartData = data.slice(0, config.limit || 10).map(item => ({
    name: item.branch_name || item.branch_code || 'Unknown',
    value: parseFloat(item[config.metric] || item.total_collected || 0),
  }));

  return (
    <ResponsiveContainer width="100%" height="100%">
      <BarChart data={chartData} margin={{ top: 5, right: 5, left: 5, bottom: 5 }}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="name" angle={-45} textAnchor="end" height={80} />
        <YAxis />
        <Tooltip formatter={(value) => `SAR ${value.toLocaleString()}`} />
        <Bar dataKey="value" fill="#4A5568" />
      </BarChart>
    </ResponsiveContainer>
  );
}

// Pie Chart Widget
function PieChartWidget({ data, config }) {
  if (!Array.isArray(data) || data.length === 0) {
    return <div className="flex items-center justify-center h-full">No data available</div>;
  }

  const chartData = data.slice(0, 6).map(item => ({
    name: item.name || item.branch_name || 'Unknown',
    value: parseFloat(item.value || item.total_collected || 0),
  }));

  return (
    <ResponsiveContainer width="100%" height="100%">
      <PieChart>
        <Pie
          data={chartData}
          cx="50%"
          cy="50%"
          labelLine={false}
          label={({ name, percent }) => `${name}: ${(percent * 100).toFixed(0)}%`}
          outerRadius={80}
          fill="#8884d8"
          dataKey="value"
        >
          {chartData.map((entry, index) => (
            <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
          ))}
        </Pie>
        <Tooltip formatter={(value) => `SAR ${value.toLocaleString()}`} />
      </PieChart>
    </ResponsiveContainer>
  );
}