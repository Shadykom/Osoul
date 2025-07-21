import React, { useState, useEffect } from 'react';
import { LineChart, Line, BarChart, Bar, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, AreaChart, Area } from 'recharts';
import { Calendar, TrendingUp, Users, DollarSign, FileText, Building, Activity, Download, Filter, Globe, CreditCard, Target, Award, Clock, ChevronRight, Menu, X } from 'lucide-react';
import osoulLogo from './assets/osoul-logo.png';
import './App.css'

const OsoulReportingSystem = () => {
  const [activeTab, setActiveTab] = useState('dashboard');
  const [language, setLanguage] = useState('en');
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [selectedPeriod, setSelectedPeriod] = useState('Q4-2024');
  const [selectedBranch, setSelectedBranch] = useState('all');

  const translations = {
    en: {
      title: 'Osoul Modern Reporting System',
      subtitle: 'Islamic Finance Analytics Dashboard',
      dashboard: 'Executive Dashboard',
      portfolio: 'Portfolio Analytics',
      compliance: 'Sharia Compliance',
      customers: 'Customer Analytics',
      operations: 'Operations',
      reports: 'Reports',
      totalFinancing: 'Total Financing',
      activeClients: 'Active Clients',
      avgProcessingTime: 'Avg Processing Time',
      complianceRate: 'Sharia Compliance Rate',
      financingTrend: 'Financing Trend Analysis',
      portfolioDistribution: 'Portfolio Distribution',
      branchPerformance: 'Branch Performance',
      customerSegments: 'Customer Segments',
      days: 'Days',
      personal: 'Personal Finance',
      business: 'Business Finance',
      retirement: 'Retirement Finance',
      monthly: 'Monthly',
      quarterly: 'Quarterly',
      annually: 'Annually',
      jeddah: 'Jeddah',
      riyadh: 'Riyadh',
      khobar: 'Khobar',
      allBranches: 'All Branches',
      exportPdf: 'Export PDF',
      government: 'Government',
      military: 'Military',
      private: 'Private Sector',
      newApplications: 'New Applications',
      approved: 'Approved',
      pending: 'Pending',
      profitRate: 'Profit Rate',
      avgFinancingAmount: 'Avg Financing Amount',
      customerSatisfaction: 'Customer Satisfaction',
      processingEfficiency: 'Processing Efficiency'
    },
    ar: {
      title: 'نظام تقارير أصول الحديثة',
      subtitle: 'لوحة تحليلات التمويل الإسلامي',
      dashboard: 'لوحة المعلومات',
      portfolio: 'تحليلات المحفظة',
      compliance: 'الامتثال الشرعي',
      customers: 'تحليلات العملاء',
      operations: 'العمليات',
      reports: 'التقارير',
      totalFinancing: 'إجمالي التمويل',
      activeClients: 'العملاء النشطون',
      avgProcessingTime: 'متوسط وقت المعالجة',
      complianceRate: 'معدل الامتثال الشرعي',
      financingTrend: 'تحليل اتجاه التمويل',
      portfolioDistribution: 'توزيع المحفظة',
      branchPerformance: 'أداء الفروع',
      customerSegments: 'شرائح العملاء',
      days: 'أيام',
      personal: 'تمويل شخصي',
      business: 'تمويل الأعمال',
      retirement: 'تمويل التقاعد',
      monthly: 'شهري',
      quarterly: 'ربع سنوي',
      annually: 'سنوي',
      jeddah: 'جدة',
      riyadh: 'الرياض',
      khobar: 'الخبر',
      allBranches: 'جميع الفروع',
      exportPdf: 'تصدير PDF',
      government: 'حكومي',
      military: 'عسكري',
      private: 'قطاع خاص',
      newApplications: 'طلبات جديدة',
      approved: 'معتمد',
      pending: 'قيد الانتظار',
      profitRate: 'معدل الربح',
      avgFinancingAmount: 'متوسط مبلغ التمويل',
      customerSatisfaction: 'رضا العملاء',
      processingEfficiency: 'كفاءة المعالجة'
    }
  };

  const t = translations[language];

  const monthlyData = [
    { month: 'Jan', financing: 12.5, applications: 145, approved: 128 },
    { month: 'Feb', financing: 14.2, applications: 162, approved: 142 },
    { month: 'Mar', financing: 15.8, applications: 178, approved: 156 },
    { month: 'Apr', financing: 16.3, applications: 185, approved: 165 },
    { month: 'May', financing: 17.9, applications: 198, approved: 175 },
    { month: 'Jun', financing: 18.6, applications: 210, approved: 188 },
    { month: 'Jul', financing: 19.2, applications: 225, approved: 198 },
    { month: 'Aug', financing: 20.1, applications: 238, approved: 210 },
    { month: 'Sep', financing: 21.5, applications: 248, approved: 220 },
    { month: 'Oct', financing: 22.8, applications: 265, approved: 235 },
    { month: 'Nov', financing: 23.9, applications: 278, approved: 248 },
    { month: 'Dec', financing: 25.2, applications: 292, approved: 262 }
  ];

  const portfolioData = [
    { name: t.personal, value: 55, amount: 138.6 },
    { name: t.business, value: 30, amount: 75.6 },
    { name: t.retirement, value: 15, amount: 37.8 }
  ];

  const branchData = [
    { branch: t.jeddah, financing: 98.5, clients: 1250, satisfaction: 94 },
    { branch: t.riyadh, financing: 87.3, clients: 1100, satisfaction: 92 },
    { branch: t.khobar, financing: 66.4, clients: 850, satisfaction: 93 }
  ];

  const customerSegmentData = [
    { segment: t.government, value: 40, growth: 12 },
    { segment: t.military, value: 25, growth: 15 },
    { segment: t.private, value: 35, growth: 18 }
  ];

  const COLORS = ['#D69E2E', '#4A5568', '#2D3748', '#F6AD55', '#718096'];

  const MetricCard = ({ icon: Icon, label, value, change, color = "text-gray-600" }) => (
    <div className="bg-white rounded-xl p-6 shadow-sm hover:shadow-lg transition-all duration-300 border border-gray-100">
      <div className="flex items-center justify-between mb-4">
        <div className={`p-3 rounded-lg ${color === 'primary' ? 'bg-yellow-50' : 'bg-gray-50'}`}>
          <Icon className={`w-6 h-6 ${color === 'primary' ? 'text-yellow-600' : 'text-gray-600'}`} />
        </div>
        {change && (
          <span className={`text-sm font-medium ${change > 0 ? 'text-green-600' : 'text-red-600'}`}>
            {change > 0 ? '+' : ''}{change}%
          </span>
        )}
      </div>
      <p className="text-gray-500 text-sm mb-1">{label}</p>
      <p className="text-2xl font-bold text-gray-800">{value}</p>
    </div>
  );

  const Sidebar = () => (
    <div className={`fixed left-0 top-0 h-full bg-gradient-to-b from-gray-800 to-gray-700 text-white transition-all duration-300 z-40 ${
      sidebarOpen ? 'w-64' : 'w-20'
    }`}>
      <div className="p-6">
        <div className="flex items-center justify-between mb-8">
          <div className={`flex items-center ${sidebarOpen ? '' : 'justify-center'}`}>
            <div className="w-12 h-12 bg-white rounded-lg flex items-center justify-center p-1">
              <img src={osoulLogo} alt="Osoul Modern" className="w-full h-full object-contain" />
            </div>
            {sidebarOpen && (
              <div className="ml-3">
                <h1 className="text-xl font-bold">Osoul Modern</h1>
                <p className="text-yellow-200 text-xs">أصول الحديثة</p>
              </div>
            )}
          </div>
          <button
            onClick={() => setSidebarOpen(!sidebarOpen)}
            className="text-white hover:bg-gray-600 p-2 rounded-lg transition-colors"
          >
            {sidebarOpen ? <X size={20} /> : <Menu size={20} />}
          </button>
        </div>

        <nav className="space-y-2">
          {[
            { id: 'dashboard', icon: Activity, label: t.dashboard },
            { id: 'portfolio', icon: CreditCard, label: t.portfolio },
            { id: 'compliance', icon: Award, label: t.compliance },
            { id: 'customers', icon: Users, label: t.customers },
            { id: 'operations', icon: Clock, label: t.operations },
            { id: 'reports', icon: FileText, label: t.reports }
          ].map(item => (
            <button
              key={item.id}
              onClick={() => setActiveTab(item.id)}
              className={`w-full flex items-center ${sidebarOpen ? 'px-4' : 'px-2 justify-center'} py-3 rounded-lg transition-all duration-200 ${
                activeTab === item.id
                  ? 'bg-yellow-500 text-gray-800 font-semibold'
                  : 'text-gray-200 hover:bg-gray-600'
              }`}
            >
              <item.icon size={20} />
              {sidebarOpen && <span className="ml-3">{item.label}</span>}
            </button>
          ))}
        </nav>
      </div>
    </div>
  );

  return (
    <div className="min-h-screen bg-gray-50" dir={language === 'ar' ? 'rtl' : 'ltr'}>
      <Sidebar />
      
      <div className={`${sidebarOpen ? 'ml-64' : 'ml-20'} transition-all duration-300`}>
        {/* Header */}
        <header className="bg-white shadow-sm border-b border-gray-200">
          <div className="px-6 py-4">
            <div className="flex items-center justify-between">
              <div>
                <h1 className="text-2xl font-bold text-gray-800">{t.title}</h1>
                <p className="text-gray-500 text-sm">{t.subtitle}</p>
              </div>
              <div className="flex items-center gap-4">
                <select
                  value={selectedPeriod}
                  onChange={(e) => setSelectedPeriod(e.target.value)}
                  className="px-4 py-2 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
                >
                  <option value="Q4-2024">Q4 2024</option>
                  <option value="Q3-2024">Q3 2024</option>
                  <option value="Q2-2024">Q2 2024</option>
                  <option value="Q1-2024">Q1 2024</option>
                </select>
                <select
                  value={selectedBranch}
                  onChange={(e) => setSelectedBranch(e.target.value)}
                  className="px-4 py-2 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
                >
                  <option value="all">{t.allBranches}</option>
                  <option value="jeddah">{t.jeddah}</option>
                  <option value="riyadh">{t.riyadh}</option>
                  <option value="khobar">{t.khobar}</option>
                </select>
                <button
                  onClick={() => setLanguage(language === 'en' ? 'ar' : 'en')}
                  className="p-2 hover:bg-gray-100 rounded-lg transition-colors"
                >
                  <Globe size={20} />
                </button>
                <button className="px-4 py-2 bg-yellow-500 text-gray-800 rounded-lg hover:bg-yellow-600 transition-colors flex items-center gap-2 font-semibold">
                  <Download size={18} />
                  {t.exportPdf}
                </button>
              </div>
            </div>
          </div>
        </header>

        {/* Main Content */}
        <main className="p-6">
          {activeTab === 'dashboard' && (
            <div className="space-y-6">
              {/* KPI Cards */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <MetricCard
                  icon={DollarSign}
                  label={t.totalFinancing}
                  value="252M SAR"
                  change={12.5}
                  color="primary"
                />
                <MetricCard
                  icon={Users}
                  label={t.activeClients}
                  value="3,200"
                  change={8.3}
                  color="primary"
                />
                <MetricCard
                  icon={Clock}
                  label={t.avgProcessingTime}
                  value={`7.2 ${t.days}`}
                  change={-15.2}
                />
                <MetricCard
                  icon={Award}
                  label={t.complianceRate}
                  value="99.8%"
                  change={0.3}
                />
              </div>

              {/* Charts */}
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="bg-white p-6 rounded-xl shadow-sm">
                  <h3 className="text-lg font-semibold mb-4">{t.financingTrend}</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <AreaChart data={monthlyData}>
                      <defs>
                        <linearGradient id="colorFinancing" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="5%" stopColor="#D69E2E" stopOpacity={0.8}/>
                          <stop offset="95%" stopColor="#D69E2E" stopOpacity={0.1}/>
                        </linearGradient>
                      </defs>
                      <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                      <XAxis dataKey="month" />
                      <YAxis />
                      <Tooltip />
                      <Area 
                        type="monotone" 
                        dataKey="financing" 
                        stroke="#D69E2E" 
                        fillOpacity={1} 
                        fill="url(#colorFinancing)" 
                      />
                    </AreaChart>
                  </ResponsiveContainer>
                </div>

                <div className="bg-white p-6 rounded-xl shadow-sm">
                  <h3 className="text-lg font-semibold mb-4">{t.portfolioDistribution}</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={portfolioData}
                        cx="50%"
                        cy="50%"
                        labelLine={false}
                        label={({ name, value }) => `${name}: ${value}%`}
                        outerRadius={100}
                        fill="#8884d8"
                        dataKey="value"
                      >
                        {portfolioData.map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                      </Pie>
                      <Tooltip />
                    </PieChart>
                  </ResponsiveContainer>
                </div>
              </div>

              {/* Branch Performance */}
              <div className="bg-white p-6 rounded-xl shadow-sm">
                <h3 className="text-lg font-semibold mb-4">{t.branchPerformance}</h3>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={branchData}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                    <XAxis dataKey="branch" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Bar dataKey="financing" fill="#D69E2E" name={t.totalFinancing} />
                    <Bar dataKey="satisfaction" fill="#4A5568" name={t.customerSatisfaction} />
                  </BarChart>
                </ResponsiveContainer>
              </div>
            </div>
          )}

          {activeTab === 'portfolio' && (
            <div className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {portfolioData.map((item, index) => (
                  <div key={index} className="bg-white p-6 rounded-xl shadow-sm">
                    <div className="flex items-center justify-between mb-4">
                      <h4 className="text-lg font-semibold">{item.name}</h4>
                      <span className="text-2xl font-bold text-yellow-600">{item.value}%</span>
                    </div>
                    <div className="space-y-2">
                      <div className="flex justify-between text-sm">
                        <span className="text-gray-500">Total Amount</span>
                        <span className="font-medium">{item.amount}M SAR</span>
                      </div>
                      <div className="flex justify-between text-sm">
                        <span className="text-gray-500">Active Contracts</span>
                        <span className="font-medium">{Math.floor(item.amount * 10)}</span>
                      </div>
                      <div className="flex justify-between text-sm">
                        <span className="text-gray-500">{t.profitRate}</span>
                        <span className="font-medium">4.2%</span>
                      </div>
                    </div>
                    <div className="mt-4 h-2 bg-gray-200 rounded-full overflow-hidden">
                      <div 
                        className="h-full bg-yellow-500 rounded-full"
                        style={{ width: `${item.value}%` }}
                      />
                    </div>
                  </div>
                ))}
              </div>

              <div className="bg-white p-6 rounded-xl shadow-sm">
                <h3 className="text-lg font-semibold mb-4">{t.customerSegments}</h3>
                <ResponsiveContainer width="100%" height={400}>
                  <BarChart data={customerSegmentData} layout="vertical">
                    <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                    <XAxis type="number" />
                    <YAxis dataKey="segment" type="category" />
                    <Tooltip />
                    <Bar dataKey="value" fill="#D69E2E" />
                    <Bar dataKey="growth" fill="#4A5568" />
                  </BarChart>
                </ResponsiveContainer>
              </div>
            </div>
          )}

          {activeTab === 'compliance' && (
            <div className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <MetricCard
                  icon={Award}
                  label="Sharia Board Approvals"
                  value="100%"
                  change={0}
                  color="primary"
                />
                <MetricCard
                  icon={FileText}
                  label="Compliant Contracts"
                  value="3,198"
                  change={0}
                />
                <MetricCard
                  icon={Clock}
                  label="Audit Frequency"
                  value="Monthly"
                />
                <MetricCard
                  icon={Target}
                  label="Risk Rating"
                  value="Low"
                  color="primary"
                />
              </div>

              <div className="bg-white p-6 rounded-xl shadow-sm">
                <h3 className="text-lg font-semibold mb-4">Compliance Metrics Over Time</h3>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={monthlyData}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                    <XAxis dataKey="month" />
                    <YAxis domain={[95, 100]} />
                    <Tooltip />
                    <Line 
                      type="monotone" 
                      dataKey="approved" 
                      stroke="#D69E2E" 
                      strokeWidth={2}
                      dot={{ fill: '#D69E2E' }}
                    />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </div>
          )}

          {activeTab === 'customers' && (
            <div className="space-y-6">
              <div className="bg-white rounded-xl shadow-sm overflow-hidden">
                <div className="p-6 border-b border-gray-200">
                  <h3 className="text-lg font-semibold">Customer Analytics Overview</h3>
                </div>
                <div className="p-6">
                  <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                    <div className="text-center">
                      <p className="text-3xl font-bold text-yellow-600">3,200</p>
                      <p className="text-gray-500">Total Active Customers</p>
                    </div>
                    <div className="text-center">
                      <p className="text-3xl font-bold text-yellow-600">94%</p>
                      <p className="text-gray-500">Customer Satisfaction Rate</p>
                    </div>
                    <div className="text-center">
                      <p className="text-3xl font-bold text-yellow-600">85%</p>
                      <p className="text-gray-500">Customer Retention Rate</p>
                    </div>
                  </div>

                  <ResponsiveContainer width="100%" height={300}>
                    <AreaChart data={monthlyData}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                      <XAxis dataKey="month" />
                      <YAxis />
                      <Tooltip />
                      <Area type="monotone" dataKey="applications" fill="#D69E2E" stroke="#D69E2E" />
                      <Area type="monotone" dataKey="approved" fill="#4A5568" stroke="#4A5568" />
                    </AreaChart>
                  </ResponsiveContainer>
                </div>
              </div>
            </div>
          )}

          {activeTab === 'operations' && (
            <div className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <MetricCard
                  icon={Activity}
                  label={t.processingEfficiency}
                  value="92%"
                  change={5.2}
                  color="primary"
                />
                <MetricCard
                  icon={Clock}
                  label="Average TAT"
                  value="7.2 days"
                  change={-12.5}
                />
                <MetricCard
                  icon={FileText}
                  label={t.newApplications}
                  value="292"
                  change={15.3}
                />
                <MetricCard
                  icon={Target}
                  label="First Time Approval"
                  value="78%"
                  change={3.8}
                />
              </div>

              <div className="bg-white p-6 rounded-xl shadow-sm">
                <h3 className="text-lg font-semibold mb-4">Application Processing Pipeline</h3>
                <div className="space-y-4">
                  {[
                    { stage: 'Application Received', count: 292, percentage: 100 },
                    { stage: 'Document Verification', count: 278, percentage: 95 },
                    { stage: 'Credit Assessment', count: 265, percentage: 91 },
                    { stage: 'Sharia Review', count: 262, percentage: 90 },
                    { stage: 'Final Approval', count: 262, percentage: 90 },
                    { stage: 'Disbursement', count: 255, percentage: 87 }
                  ].map((item, index) => (
                    <div key={index} className="flex items-center gap-4">
                      <div className="w-32 text-sm font-medium">{item.stage}</div>
                      <div className="flex-1">
                        <div className="h-8 bg-gray-200 rounded-full overflow-hidden">
                          <div 
                            className="h-full bg-gradient-to-r from-yellow-500 to-yellow-400 rounded-full flex items-center justify-end pr-2"
                            style={{ width: `${item.percentage}%` }}
                          >
                            <span className="text-white text-xs font-medium">{item.count}</span>
                          </div>
                        </div>
                      </div>
                      <div className="w-12 text-right text-sm text-gray-500">{item.percentage}%</div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          )}

          {activeTab === 'reports' && (
            <div className="space-y-6">
              <div className="bg-white rounded-xl shadow-sm overflow-hidden">
                <div className="p-6 border-b border-gray-200">
                  <h3 className="text-lg font-semibold">Available Reports</h3>
                </div>
                <div className="divide-y divide-gray-200">
                  {[
                    { name: 'Monthly Financial Summary', type: 'Financial', frequency: 'Monthly', lastGenerated: '31 Dec 2024' },
                    { name: 'Sharia Compliance Report', type: 'Compliance', frequency: 'Monthly', lastGenerated: '31 Dec 2024' },
                    { name: 'Customer Portfolio Analysis', type: 'Analytics', frequency: 'Quarterly', lastGenerated: '31 Dec 2024' },
                    { name: 'Branch Performance Report', type: 'Operations', frequency: 'Weekly', lastGenerated: '7 Jan 2025' },
                    { name: 'Risk Assessment Report', type: 'Risk', frequency: 'Monthly', lastGenerated: '31 Dec 2024' },
                    { name: 'Profit Distribution Report', type: 'Financial', frequency: 'Quarterly', lastGenerated: '31 Dec 2024' }
                  ].map((report, index) => (
                    <div key={index} className="p-6 flex items-center justify-between hover:bg-gray-50 transition-colors">
                      <div className="flex-1">
                        <h4 className="font-medium text-gray-800">{report.name}</h4>
                        <div className="flex items-center gap-4 mt-1 text-sm text-gray-500">
                          <span>{report.type}</span>
                          <span>•</span>
                          <span>{report.frequency}</span>
                          <span>•</span>
                          <span>Last: {report.lastGenerated}</span>
                        </div>
                      </div>
                      <button className="px-4 py-2 bg-yellow-500 text-gray-800 rounded-lg hover:bg-yellow-600 transition-colors flex items-center gap-2 font-semibold">
                        Generate
                        <ChevronRight size={16} />
                      </button>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          )}
        </main>
      </div>
    </div>
  );
};

function App() {
  return <OsoulReportingSystem />;
}

export default App;

