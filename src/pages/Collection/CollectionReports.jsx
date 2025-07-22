import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Button } from '@/components/ui/button';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Calendar } from '@/components/ui/calendar';
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Badge } from '@/components/ui/badge';
import { 
  BarChart, Bar, LineChart, Line, PieChart, Pie, Cell, 
  XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer,
  ComposedChart, Area
} from 'recharts';
import { 
  Download, FileText, Calendar as CalendarIcon, Filter,
  TrendingUp, Users, DollarSign, AlertCircle, Printer
} from 'lucide-react';
import { format } from 'date-fns';

const CollectionReports = () => {
  const [selectedReport, setSelectedReport] = useState('daily');
  const [dateRange, setDateRange] = useState({
    from: new Date(new Date().getFullYear(), new Date().getMonth(), 1),
    to: new Date()
  });
  const [filters, setFilters] = useState({
    branch: 'all',
    collector: 'all',
    product: 'all',
    bucket: 'all'
  });

  // Mock data for reports
  const dailyCollectionData = [
    { date: '2024-01-15', target: 150000, collected: 142000, accounts: 45, calls: 120, visits: 8 },
    { date: '2024-01-16', target: 150000, collected: 168000, accounts: 52, calls: 135, visits: 10 },
    { date: '2024-01-17', target: 150000, collected: 155000, accounts: 48, calls: 128, visits: 9 },
    { date: '2024-01-18', target: 150000, collected: 172000, accounts: 55, calls: 142, visits: 12 },
    { date: '2024-01-19', target: 150000, collected: 138000, accounts: 42, calls: 115, visits: 7 }
  ];

  const collectorProductivityData = [
    { 
      collector: 'Abdulaziz Al-Rasheed',
      totalCases: 25,
      contacted: 22,
      collected: 125000,
      target: 150000,
      ptpObtained: 8,
      ptpKept: 6,
      avgCallTime: '4:32',
      successRate: 85
    },
    { 
      collector: 'Sara Al-Mutairi',
      totalCases: 20,
      contacted: 18,
      collected: 95000,
      target: 120000,
      ptpObtained: 6,
      ptpKept: 4,
      avgCallTime: '5:15',
      successRate: 75
    },
    { 
      collector: 'Mohammed Al-Qahtani',
      totalCases: 30,
      contacted: 28,
      collected: 180000,
      target: 200000,
      ptpObtained: 12,
      ptpKept: 10,
      avgCallTime: '3:45',
      successRate: 90
    }
  ];

  const agingMovementData = [
    { bucket: 'Current', opening: 125000, inflow: 45000, outflow: 25000, closing: 145000 },
    { bucket: '1-30', opening: 285000, inflow: 25000, outflow: 50000, closing: 260000 },
    { bucket: '31-60', opening: 420000, inflow: 50000, outflow: 85000, closing: 385000 },
    { bucket: '61-90', opening: 580000, inflow: 85000, outflow: 120000, closing: 545000 },
    { bucket: '91-180', opening: 750000, inflow: 120000, outflow: 95000, closing: 775000 },
    { bucket: '180+', opening: 690000, inflow: 95000, outflow: 45000, closing: 740000 }
  ];

  const legalCasesData = [
    { 
      caseId: 'LC001',
      customer: 'Mohammed Al-Otaibi',
      account: 'ACC003',
      amount: 750000,
      filingDate: '2024-10-15',
      status: 'Under Execution',
      lawyer: 'Abdullah Legal Firm',
      nextHearing: '2024-02-15'
    },
    { 
      caseId: 'LC002',
      customer: 'Khalid Al-Maliki',
      account: 'ACC005',
      amount: 28000,
      filingDate: '2024-08-20',
      status: 'Judgment Obtained',
      lawyer: 'Al-Fahad Law Office',
      nextHearing: '-'
    }
  ];

  const settlementData = [
    { month: 'Oct 2023', proposals: 12, approved: 8, rejected: 4, amount: 450000 },
    { month: 'Nov 2023', proposals: 15, approved: 10, rejected: 5, amount: 580000 },
    { month: 'Dec 2023', proposals: 18, approved: 12, rejected: 6, amount: 720000 },
    { month: 'Jan 2024', proposals: 10, approved: 7, rejected: 3, amount: 380000 }
  ];

  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884D8'];

  const exportReport = (format) => {
    // Implement export functionality
    console.log(`Exporting report in ${format} format`);
  };

  const printReport = () => {
    // Implement print functionality
    window.print();
  };

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold">Collection Reports</h1>
          <p className="text-gray-600 mt-1">Generate and analyze collection performance reports</p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" onClick={() => exportReport('pdf')}>
            <Download className="mr-2 h-4 w-4" />
            Export PDF
          </Button>
          <Button variant="outline" onClick={() => exportReport('excel')}>
            <FileText className="mr-2 h-4 w-4" />
            Export Excel
          </Button>
          <Button variant="outline" onClick={printReport}>
            <Printer className="mr-2 h-4 w-4" />
            Print
          </Button>
        </div>
      </div>

      {/* Filters */}
      <Card>
        <CardHeader>
          <CardTitle className="text-lg flex items-center gap-2">
            <Filter className="h-5 w-5" />
            Report Filters
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-4">
            <div>
              <Label>Branch</Label>
              <Select value={filters.branch} onValueChange={(value) => setFilters({...filters, branch: value})}>
                <SelectTrigger>
                  <SelectValue placeholder="Select Branch" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Branches</SelectItem>
                  <SelectItem value="riyadh">Riyadh</SelectItem>
                  <SelectItem value="jeddah">Jeddah</SelectItem>
                  <SelectItem value="dammam">Dammam</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label>Collector</Label>
              <Select value={filters.collector} onValueChange={(value) => setFilters({...filters, collector: value})}>
                <SelectTrigger>
                  <SelectValue placeholder="Select Collector" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Collectors</SelectItem>
                  <SelectItem value="col1">Abdulaziz Al-Rasheed</SelectItem>
                  <SelectItem value="col2">Sara Al-Mutairi</SelectItem>
                  <SelectItem value="col3">Mohammed Al-Qahtani</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label>Product Type</Label>
              <Select value={filters.product} onValueChange={(value) => setFilters({...filters, product: value})}>
                <SelectTrigger>
                  <SelectValue placeholder="Select Product" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Products</SelectItem>
                  <SelectItem value="auto">Auto Finance</SelectItem>
                  <SelectItem value="personal">Personal Finance</SelectItem>
                  <SelectItem value="home">Home Finance</SelectItem>
                  <SelectItem value="sme">SME Finance</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label>Aging Bucket</Label>
              <Select value={filters.bucket} onValueChange={(value) => setFilters({...filters, bucket: value})}>
                <SelectTrigger>
                  <SelectValue placeholder="Select Bucket" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Buckets</SelectItem>
                  <SelectItem value="current">Current</SelectItem>
                  <SelectItem value="1-30">1-30 Days</SelectItem>
                  <SelectItem value="31-60">31-60 Days</SelectItem>
                  <SelectItem value="61-90">61-90 Days</SelectItem>
                  <SelectItem value="91-180">91-180 Days</SelectItem>
                  <SelectItem value="180+">180+ Days</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label>Date Range</Label>
              <Popover>
                <PopoverTrigger asChild>
                  <Button variant="outline" className="w-full justify-start text-left font-normal">
                    <CalendarIcon className="mr-2 h-4 w-4" />
                    {dateRange?.from ? (
                      dateRange.to ? (
                        <>
                          {format(dateRange.from, "MMM dd")} - {format(dateRange.to, "MMM dd")}
                        </>
                      ) : (
                        format(dateRange.from, "MMM dd, yyyy")
                      )
                    ) : (
                      <span>Pick dates</span>
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
        </CardContent>
      </Card>

      {/* Report Tabs */}
      <Tabs defaultValue="daily" className="space-y-4">
        <TabsList className="grid w-full grid-cols-6">
          <TabsTrigger value="daily">Daily Collection</TabsTrigger>
          <TabsTrigger value="productivity">Productivity</TabsTrigger>
          <TabsTrigger value="aging">Aging Movement</TabsTrigger>
          <TabsTrigger value="ptp">PTP Analysis</TabsTrigger>
          <TabsTrigger value="legal">Legal Cases</TabsTrigger>
          <TabsTrigger value="settlement">Settlements</TabsTrigger>
        </TabsList>

        {/* Daily Collection Report */}
        <TabsContent value="daily" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Daily Collection Report</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-6">
                {/* Chart */}
                <ResponsiveContainer width="100%" height={300}>
                  <ComposedChart data={dailyCollectionData}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="date" tickFormatter={(date) => format(new Date(date), 'MMM dd')} />
                    <YAxis yAxisId="left" />
                    <YAxis yAxisId="right" orientation="right" />
                    <Tooltip />
                    <Legend />
                    <Bar yAxisId="left" dataKey="collected" fill="#8884d8" name="Collected Amount" />
                    <Line yAxisId="left" type="monotone" dataKey="target" stroke="#ff7300" name="Target" strokeDasharray="5 5" />
                    <Line yAxisId="right" type="monotone" dataKey="accounts" stroke="#82ca9d" name="Accounts" />
                  </ComposedChart>
                </ResponsiveContainer>

                {/* Table */}
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Date</TableHead>
                      <TableHead>Target</TableHead>
                      <TableHead>Collected</TableHead>
                      <TableHead>Achievement %</TableHead>
                      <TableHead>Accounts</TableHead>
                      <TableHead>Calls</TableHead>
                      <TableHead>Visits</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {dailyCollectionData.map((row, index) => (
                      <TableRow key={index}>
                        <TableCell>{format(new Date(row.date), 'MMM dd, yyyy')}</TableCell>
                        <TableCell>SAR {row.target.toLocaleString()}</TableCell>
                        <TableCell>SAR {row.collected.toLocaleString()}</TableCell>
                        <TableCell>
                          <Badge variant={row.collected >= row.target ? "success" : "warning"}>
                            {((row.collected / row.target) * 100).toFixed(1)}%
                          </Badge>
                        </TableCell>
                        <TableCell>{row.accounts}</TableCell>
                        <TableCell>{row.calls}</TableCell>
                        <TableCell>{row.visits}</TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Collector Productivity Report */}
        <TabsContent value="productivity" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Collector Productivity Report</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Collector Name</TableHead>
                    <TableHead>Total Cases</TableHead>
                    <TableHead>Contacted</TableHead>
                    <TableHead>Contact Rate</TableHead>
                    <TableHead>Collected</TableHead>
                    <TableHead>Target</TableHead>
                    <TableHead>Achievement</TableHead>
                    <TableHead>PTP Obtained</TableHead>
                    <TableHead>PTP Kept</TableHead>
                    <TableHead>Success Rate</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {collectorProductivityData.map((collector, index) => (
                    <TableRow key={index}>
                      <TableCell className="font-medium">{collector.collector}</TableCell>
                      <TableCell>{collector.totalCases}</TableCell>
                      <TableCell>{collector.contacted}</TableCell>
                      <TableCell>
                        <Badge variant="outline">
                          {((collector.contacted / collector.totalCases) * 100).toFixed(0)}%
                        </Badge>
                      </TableCell>
                      <TableCell>SAR {collector.collected.toLocaleString()}</TableCell>
                      <TableCell>SAR {collector.target.toLocaleString()}</TableCell>
                      <TableCell>
                        <Badge variant={collector.collected >= collector.target * 0.9 ? "success" : "warning"}>
                          {((collector.collected / collector.target) * 100).toFixed(0)}%
                        </Badge>
                      </TableCell>
                      <TableCell>{collector.ptpObtained}</TableCell>
                      <TableCell>{collector.ptpKept}</TableCell>
                      <TableCell>
                        <Badge variant={collector.successRate >= 80 ? "success" : "default"}>
                          {collector.successRate}%
                        </Badge>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Aging Movement Report */}
        <TabsContent value="aging" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Aging Movement Report</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-6">
                {/* Chart */}
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={agingMovementData}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="bucket" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Bar dataKey="opening" fill="#8884d8" name="Opening Balance" />
                    <Bar dataKey="inflow" fill="#82ca9d" name="Inflow" />
                    <Bar dataKey="outflow" fill="#ffc658" name="Outflow" />
                    <Bar dataKey="closing" fill="#ff7c7c" name="Closing Balance" />
                  </BarChart>
                </ResponsiveContainer>

                {/* Table */}
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Aging Bucket</TableHead>
                      <TableHead className="text-right">Opening Balance</TableHead>
                      <TableHead className="text-right">Inflow</TableHead>
                      <TableHead className="text-right">Outflow</TableHead>
                      <TableHead className="text-right">Closing Balance</TableHead>
                      <TableHead className="text-right">Movement %</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {agingMovementData.map((row, index) => (
                      <TableRow key={index}>
                        <TableCell className="font-medium">{row.bucket}</TableCell>
                        <TableCell className="text-right">SAR {row.opening.toLocaleString()}</TableCell>
                        <TableCell className="text-right text-green-600">+{row.inflow.toLocaleString()}</TableCell>
                        <TableCell className="text-right text-red-600">-{row.outflow.toLocaleString()}</TableCell>
                        <TableCell className="text-right font-semibold">SAR {row.closing.toLocaleString()}</TableCell>
                        <TableCell className="text-right">
                          <Badge variant={row.closing > row.opening ? "destructive" : "success"}>
                            {((row.closing - row.opening) / row.opening * 100).toFixed(1)}%
                          </Badge>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* PTP Analysis Report */}
        <TabsContent value="ptp" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Promise to Pay Analysis</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                {/* PTP Status Distribution */}
                <div>
                  <h3 className="text-lg font-semibold mb-4">PTP Status Distribution</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={[
                          { name: 'Kept', value: 65, color: '#10b981' },
                          { name: 'Broken', value: 20, color: '#ef4444' },
                          { name: 'Partial', value: 10, color: '#f59e0b' },
                          { name: 'Pending', value: 5, color: '#6b7280' }
                        ]}
                        cx="50%"
                        cy="50%"
                        labelLine={false}
                        label={({ name, value }) => `${name}: ${value}%`}
                        outerRadius={80}
                        fill="#8884d8"
                        dataKey="value"
                      >
                        {[
                          { name: 'Kept', value: 65, color: '#10b981' },
                          { name: 'Broken', value: 20, color: '#ef4444' },
                          { name: 'Partial', value: 10, color: '#f59e0b' },
                          { name: 'Pending', value: 5, color: '#6b7280' }
                        ].map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={entry.color} />
                        ))}
                      </Pie>
                      <Tooltip />
                    </PieChart>
                  </ResponsiveContainer>
                </div>

                {/* PTP Trend */}
                <div>
                  <h3 className="text-lg font-semibold mb-4">PTP Success Rate Trend</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <LineChart data={[
                      { month: 'Oct', rate: 68 },
                      { month: 'Nov', rate: 72 },
                      { month: 'Dec', rate: 70 },
                      { month: 'Jan', rate: 73 }
                    ]}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="month" />
                      <YAxis />
                      <Tooltip />
                      <Line type="monotone" dataKey="rate" stroke="#8884d8" name="Success Rate %" />
                    </LineChart>
                  </ResponsiveContainer>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Legal Cases Report */}
        <TabsContent value="legal" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Legal Cases Report</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Case ID</TableHead>
                    <TableHead>Customer</TableHead>
                    <TableHead>Account</TableHead>
                    <TableHead>Amount</TableHead>
                    <TableHead>Filing Date</TableHead>
                    <TableHead>Status</TableHead>
                    <TableHead>Lawyer</TableHead>
                    <TableHead>Next Hearing</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {legalCasesData.map((case_, index) => (
                    <TableRow key={index}>
                      <TableCell className="font-mono">{case_.caseId}</TableCell>
                      <TableCell>{case_.customer}</TableCell>
                      <TableCell>{case_.account}</TableCell>
                      <TableCell>SAR {case_.amount.toLocaleString()}</TableCell>
                      <TableCell>{format(new Date(case_.filingDate), 'MMM dd, yyyy')}</TableCell>
                      <TableCell>
                        <Badge variant={case_.status === 'Judgment Obtained' ? 'success' : 'default'}>
                          {case_.status}
                        </Badge>
                      </TableCell>
                      <TableCell>{case_.lawyer}</TableCell>
                      <TableCell>{case_.nextHearing}</TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Settlement Report */}
        <TabsContent value="settlement" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Settlement Analysis Report</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-6">
                {/* Chart */}
                <ResponsiveContainer width="100%" height={300}>
                  <ComposedChart data={settlementData}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="month" />
                    <YAxis yAxisId="left" />
                    <YAxis yAxisId="right" orientation="right" />
                    <Tooltip />
                    <Legend />
                    <Bar yAxisId="left" dataKey="proposals" fill="#8884d8" name="Total Proposals" />
                    <Bar yAxisId="left" dataKey="approved" fill="#82ca9d" name="Approved" />
                    <Bar yAxisId="left" dataKey="rejected" fill="#ff7c7c" name="Rejected" />
                    <Line yAxisId="right" type="monotone" dataKey="amount" stroke="#ffc658" name="Settlement Amount" />
                  </ComposedChart>
                </ResponsiveContainer>

                {/* Summary Stats */}
                <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                  <Card>
                    <CardHeader className="pb-2">
                      <CardTitle className="text-sm">Total Proposals</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="text-2xl font-bold">55</div>
                      <p className="text-xs text-muted-foreground">Last 4 months</p>
                    </CardContent>
                  </Card>
                  <Card>
                    <CardHeader className="pb-2">
                      <CardTitle className="text-sm">Approval Rate</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="text-2xl font-bold">67.3%</div>
                      <p className="text-xs text-muted-foreground">37 approved</p>
                    </CardContent>
                  </Card>
                  <Card>
                    <CardHeader className="pb-2">
                      <CardTitle className="text-sm">Total Settlement</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="text-2xl font-bold">SAR 2.13M</div>
                      <p className="text-xs text-muted-foreground">From approved cases</p>
                    </CardContent>
                  </Card>
                  <Card>
                    <CardHeader className="pb-2">
                      <CardTitle className="text-sm">Avg Discount</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="text-2xl font-bold">18.5%</div>
                      <p className="text-xs text-muted-foreground">On original amount</p>
                    </CardContent>
                  </Card>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default CollectionReports;