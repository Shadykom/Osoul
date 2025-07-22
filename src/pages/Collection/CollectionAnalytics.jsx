import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Button } from '@/components/ui/button';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Badge } from '@/components/ui/badge';
import { Progress } from '@/components/ui/progress';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
import { 
  BarChart, Bar, LineChart, Line, PieChart, Pie, Cell, 
  XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer,
  ScatterChart, Scatter, RadialBarChart, RadialBar, PolarGrid,
  PolarAngleAxis, PolarRadiusAxis, Treemap, Sankey
} from 'recharts';
import { 
  TrendingUp, TrendingDown, AlertTriangle, CheckCircle,
  Activity, Target, Users, DollarSign, Brain, Zap
} from 'lucide-react';

const CollectionAnalytics = () => {
  const [selectedPeriod, setSelectedPeriod] = useState('quarter');
  const [selectedMetric, setSelectedMetric] = useState('collection_rate');

  // Mock data for analytics
  const performanceTrends = [
    { month: 'Oct', collectionRate: 14.2, ptpRate: 68, contactRate: 85, npl: 11.5 },
    { month: 'Nov', collectionRate: 15.1, ptpRate: 72, contactRate: 87, npl: 12.1 },
    { month: 'Dec', collectionRate: 14.8, ptpRate: 70, contactRate: 86, npl: 12.3 },
    { month: 'Jan', collectionRate: 15.8, ptpRate: 73, contactRate: 88, npl: 12.5 }
  ];

  const riskSegmentation = [
    { segment: 'Low Risk', accounts: 125, amount: 450000, avgDPD: 15 },
    { segment: 'Medium Risk', accounts: 180, amount: 850000, avgDPD: 45 },
    { segment: 'High Risk', accounts: 95, amount: 1250000, avgDPD: 120 },
    { segment: 'Critical', accounts: 42, amount: 300000, avgDPD: 200 }
  ];

  const collectorEfficiency = [
    { name: 'Abdulaziz', efficiency: 92, cases: 25, successRate: 85 },
    { name: 'Sara', efficiency: 78, cases: 20, successRate: 75 },
    { name: 'Mohammed', efficiency: 95, cases: 30, successRate: 90 },
    { name: 'Huda', efficiency: 72, cases: 22, successRate: 70 },
    { name: 'Omar', efficiency: 88, cases: 28, successRate: 88 }
  ];

  const predictiveInsights = [
    {
      type: 'warning',
      title: 'High Risk Alert',
      description: '15 accounts showing signs of potential default in next 30 days',
      impact: 'SAR 280K',
      confidence: 85
    },
    {
      type: 'success',
      title: 'Recovery Opportunity',
      description: '8 dormant accounts show increased payment probability',
      impact: 'SAR 120K',
      confidence: 78
    },
    {
      type: 'info',
      title: 'Optimal Contact Time',
      description: 'Analysis shows 3-5 PM yields 23% higher contact rates',
      impact: '+23%',
      confidence: 92
    }
  ];

  const recoveryProbability = [
    { bucket: 'Current', probability: 95, accounts: 45 },
    { bucket: '1-30', probability: 85, accounts: 78 },
    { bucket: '31-60', probability: 70, accounts: 92 },
    { bucket: '61-90', probability: 55, accounts: 85 },
    { bucket: '91-180', probability: 35, accounts: 65 },
    { bucket: '180+', probability: 15, accounts: 42 }
  ];

  const customerBehaviorPatterns = [
    { pattern: 'Regular Payer', count: 125, avgPayment: 2500 },
    { pattern: 'Seasonal Payer', count: 85, avgPayment: 3500 },
    { pattern: 'Irregular Payer', count: 95, avgPayment: 1800 },
    { pattern: 'First-time Defaulter', count: 45, avgPayment: 1200 },
    { pattern: 'Chronic Defaulter', count: 35, avgPayment: 500 }
  ];

  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884D8', '#FF6B6B'];

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold">Collection Analytics</h1>
          <p className="text-gray-600 mt-1">Advanced insights and predictive analytics</p>
        </div>
        <div className="flex gap-4">
          <Select value={selectedPeriod} onValueChange={setSelectedPeriod}>
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Select Period" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="month">This Month</SelectItem>
              <SelectItem value="quarter">This Quarter</SelectItem>
              <SelectItem value="year">This Year</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>

      {/* Key Performance Indicators */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Collection Efficiency</CardTitle>
            <Activity className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">87.5%</div>
            <Progress value={87.5} className="mt-2" />
            <p className="text-xs text-muted-foreground mt-1">
              <span className="text-green-500">↑ 3.2%</span> vs last period
            </p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Recovery Rate</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">68.3%</div>
            <Progress value={68.3} className="mt-2" />
            <p className="text-xs text-muted-foreground mt-1">
              Above industry average (65%)
            </p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Risk Score</CardTitle>
            <AlertTriangle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">Medium</div>
            <div className="flex gap-1 mt-2">
              <div className="w-full h-2 bg-green-500 rounded-l"></div>
              <div className="w-full h-2 bg-yellow-500"></div>
              <div className="w-full h-2 bg-gray-200 rounded-r"></div>
            </div>
            <p className="text-xs text-muted-foreground mt-1">Score: 6.2/10</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">AI Confidence</CardTitle>
            <Brain className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">82%</div>
            <Progress value={82} className="mt-2" />
            <p className="text-xs text-muted-foreground mt-1">
              Model accuracy this month
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Predictive Insights */}
      <div className="space-y-4">
        <h2 className="text-xl font-semibold flex items-center gap-2">
          <Zap className="h-5 w-5" />
          AI-Powered Insights
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {predictiveInsights.map((insight, index) => (
            <Alert key={index} className={
              insight.type === 'warning' ? 'border-yellow-500' :
              insight.type === 'success' ? 'border-green-500' : 'border-blue-500'
            }>
              <AlertTriangle className="h-4 w-4" />
              <AlertTitle>{insight.title}</AlertTitle>
              <AlertDescription>
                {insight.description}
                <div className="flex justify-between items-center mt-2">
                  <Badge variant="outline">Impact: {insight.impact}</Badge>
                  <span className="text-xs text-muted-foreground">
                    {insight.confidence}% confidence
                  </span>
                </div>
              </AlertDescription>
            </Alert>
          ))}
        </div>
      </div>

      {/* Analytics Tabs */}
      <Tabs defaultValue="trends" className="space-y-4">
        <TabsList>
          <TabsTrigger value="trends">Performance Trends</TabsTrigger>
          <TabsTrigger value="segmentation">Risk Segmentation</TabsTrigger>
          <TabsTrigger value="behavioral">Behavioral Analysis</TabsTrigger>
          <TabsTrigger value="predictive">Predictive Models</TabsTrigger>
        </TabsList>

        {/* Performance Trends */}
        <TabsContent value="trends" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Multi-Metric Performance Analysis</CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={400}>
                <LineChart data={performanceTrends}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="month" />
                  <YAxis />
                  <Tooltip />
                  <Legend />
                  <Line type="monotone" dataKey="collectionRate" stroke="#8884d8" name="Collection Rate %" strokeWidth={2} />
                  <Line type="monotone" dataKey="ptpRate" stroke="#82ca9d" name="PTP Success %" strokeWidth={2} />
                  <Line type="monotone" dataKey="contactRate" stroke="#ffc658" name="Contact Rate %" strokeWidth={2} />
                  <Line type="monotone" dataKey="npl" stroke="#ff7c7c" name="NPL %" strokeWidth={2} strokeDasharray="5 5" />
                </LineChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Risk Segmentation */}
        <TabsContent value="segmentation" className="space-y-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
            <Card>
              <CardHeader>
                <CardTitle>Risk Segment Distribution</CardTitle>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <PieChart>
                    <Pie
                      data={riskSegmentation}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      label={({ segment, accounts }) => `${segment}: ${accounts}`}
                      outerRadius={80}
                      fill="#8884d8"
                      dataKey="accounts"
                    >
                      {riskSegmentation.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip />
                  </PieChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>
            <Card>
              <CardHeader>
                <CardTitle>Risk vs Amount Scatter</CardTitle>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <ScatterChart>
                    <CartesianGrid />
                    <XAxis dataKey="avgDPD" name="Avg DPD" unit=" days" />
                    <YAxis dataKey="amount" name="Amount" />
                    <Tooltip cursor={{ strokeDasharray: '3 3' }} />
                    <Scatter name="Risk Segments" data={riskSegmentation} fill="#8884d8">
                      {riskSegmentation.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Scatter>
                  </ScatterChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        {/* Behavioral Analysis */}
        <TabsContent value="behavioral" className="space-y-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
            <Card>
              <CardHeader>
                <CardTitle>Customer Payment Patterns</CardTitle>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <Treemap
                    data={customerBehaviorPatterns}
                    dataKey="count"
                    aspectRatio={4/3}
                    stroke="#fff"
                    fill="#8884d8"
                  >
                    <Tooltip />
                  </Treemap>
                </ResponsiveContainer>
              </CardContent>
            </Card>
            <Card>
              <CardHeader>
                <CardTitle>Collector Efficiency Matrix</CardTitle>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <RadialBarChart cx="50%" cy="50%" innerRadius="10%" outerRadius="90%" data={collectorEfficiency}>
                    <RadialBar dataKey="efficiency" cornerRadius={10} fill="#8884d8" />
                    <PolarAngleAxis type="number" domain={[0, 100]} />
                    <Tooltip />
                  </RadialBarChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        {/* Predictive Models */}
        <TabsContent value="predictive" className="space-y-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
            <Card>
              <CardHeader>
                <CardTitle>Recovery Probability by Aging</CardTitle>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={recoveryProbability}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="bucket" />
                    <YAxis />
                    <Tooltip />
                    <Bar dataKey="probability" fill="#8884d8">
                      {recoveryProbability.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={
                          entry.probability > 70 ? '#10b981' :
                          entry.probability > 40 ? '#f59e0b' : '#ef4444'
                        } />
                      ))}
                    </Bar>
                  </BarChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>
            <Card>
              <CardHeader>
                <CardTitle>Predictive Model Performance</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  <div>
                    <div className="flex justify-between mb-1">
                      <span className="text-sm font-medium">Default Prediction</span>
                      <span className="text-sm">85% accuracy</span>
                    </div>
                    <Progress value={85} />
                  </div>
                  <div>
                    <div className="flex justify-between mb-1">
                      <span className="text-sm font-medium">Payment Probability</span>
                      <span className="text-sm">78% accuracy</span>
                    </div>
                    <Progress value={78} />
                  </div>
                  <div>
                    <div className="flex justify-between mb-1">
                      <span className="text-sm font-medium">Contact Success</span>
                      <span className="text-sm">92% accuracy</span>
                    </div>
                    <Progress value={92} />
                  </div>
                  <div>
                    <div className="flex justify-between mb-1">
                      <span className="text-sm font-medium">Recovery Amount</span>
                      <span className="text-sm">71% accuracy</span>
                    </div>
                    <Progress value={71} />
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default CollectionAnalytics;