import React, { useState, useEffect } from 'react';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';

const WIDGET_TYPES = [
  { value: 'summary_card', label: 'Summary Card' },
  { value: 'line_chart', label: 'Line Chart' },
  { value: 'bar_chart', label: 'Bar Chart' },
  { value: 'pie_chart', label: 'Pie Chart' },
];

const DATA_SOURCES = [
  { value: 'summary', label: 'Summary Statistics' },
  { value: 'performance_trends', label: 'Performance Trends' },
  { value: 'branch_comparison', label: 'Branch Comparison' },
  { value: 'collection_by_type', label: 'Collection by Type' },
];

const METRICS = [
  { value: 'total_collected', label: 'Total Collected' },
  { value: 'transaction_count', label: 'Transaction Count' },
  { value: 'avg_transaction', label: 'Average Transaction' },
  { value: 'unique_customers', label: 'Unique Customers' },
  { value: 'active_branches', label: 'Active Branches' },
];

const PERIODS = [
  { value: 'week', label: 'Last Week' },
  { value: 'month', label: 'Last Month' },
  { value: 'quarter', label: 'Last Quarter' },
  { value: 'year', label: 'Last Year' },
];

export default function WidgetConfigDialog({ open, onClose, onSave, widget }) {
  const [formData, setFormData] = useState({
    widgetTitle: '',
    widgetType: 'summary_card',
    config: {
      dataSource: 'summary',
      metric: 'total_collected',
      period: 'month',
      chartType: 'line',
      limit: 10,
    },
  });

  useEffect(() => {
    if (widget) {
      setFormData({
        widgetTitle: widget.widget_title || '',
        widgetType: widget.widget_type || 'summary_card',
        config: widget.config || {
          dataSource: 'summary',
          metric: 'total_collected',
          period: 'month',
          chartType: 'line',
          limit: 10,
        },
      });
    } else {
      setFormData({
        widgetTitle: '',
        widgetType: 'summary_card',
        config: {
          dataSource: 'summary',
          metric: 'total_collected',
          period: 'month',
          chartType: 'line',
          limit: 10,
        },
      });
    }
  }, [widget, open]);

  const handleSubmit = (e) => {
    e.preventDefault();
    onSave(formData);
  };

  const updateConfig = (key, value) => {
    setFormData({
      ...formData,
      config: {
        ...formData.config,
        [key]: value,
      },
    });
  };

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[500px]">
        <form onSubmit={handleSubmit}>
          <DialogHeader>
            <DialogTitle>{widget ? 'Edit Widget' : 'Add Widget'}</DialogTitle>
            <DialogDescription>
              Configure the widget settings below.
            </DialogDescription>
          </DialogHeader>
          
          <div className="grid gap-4 py-4">
            <div className="grid gap-2">
              <Label htmlFor="title">Widget Title</Label>
              <Input
                id="title"
                value={formData.widgetTitle}
                onChange={(e) => setFormData({ ...formData, widgetTitle: e.target.value })}
                placeholder="Enter widget title"
                required
              />
            </div>

            <div className="grid gap-2">
              <Label htmlFor="type">Widget Type</Label>
              <Select
                value={formData.widgetType}
                onValueChange={(value) => setFormData({ ...formData, widgetType: value })}
              >
                <SelectTrigger id="type">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  {WIDGET_TYPES.map(type => (
                    <SelectItem key={type.value} value={type.value}>
                      {type.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            {formData.widgetType !== 'summary_card' && (
              <div className="grid gap-2">
                <Label htmlFor="dataSource">Data Source</Label>
                <Select
                  value={formData.config.dataSource}
                  onValueChange={(value) => updateConfig('dataSource', value)}
                >
                  <SelectTrigger id="dataSource">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {DATA_SOURCES.map(source => (
                      <SelectItem key={source.value} value={source.value}>
                        {source.label}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            )}

            <div className="grid gap-2">
              <Label htmlFor="metric">Metric</Label>
              <Select
                value={formData.config.metric}
                onValueChange={(value) => updateConfig('metric', value)}
              >
                <SelectTrigger id="metric">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  {METRICS.map(metric => (
                    <SelectItem key={metric.value} value={metric.value}>
                      {metric.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="grid gap-2">
              <Label htmlFor="period">Time Period</Label>
              <Select
                value={formData.config.period}
                onValueChange={(value) => updateConfig('period', value)}
              >
                <SelectTrigger id="period">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  {PERIODS.map(period => (
                    <SelectItem key={period.value} value={period.value}>
                      {period.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            {(formData.widgetType === 'bar_chart' || formData.widgetType === 'pie_chart') && (
              <div className="grid gap-2">
                <Label htmlFor="limit">Number of Items</Label>
                <Input
                  id="limit"
                  type="number"
                  min="1"
                  max="20"
                  value={formData.config.limit}
                  onChange={(e) => updateConfig('limit', parseInt(e.target.value))}
                />
              </div>
            )}
          </div>

          <DialogFooter>
            <Button type="button" variant="outline" onClick={onClose}>
              Cancel
            </Button>
            <Button type="submit">
              {widget ? 'Update' : 'Add'} Widget
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}