import React, { useState, useEffect } from 'react';
import { LineChart, Line, BarChart, Bar, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, AreaChart, Area } from 'recharts';
import { Calendar, TrendingUp, Users, DollarSign, FileText, Building, Activity, Download, Filter, Globe, CreditCard, Target, Award, Clock, ChevronRight, ChevronLeft, Menu, X, Bell, AlertCircle, Shield, BarChart2, Percent, ArrowUpRight, ArrowDownRight } from 'lucide-react';
import osoulLogo from './assets/osoul-logo.png';

const OsoulReportingSystem = () => {
  const [activeTab, setActiveTab] = useState('dashboard');
  const [language, setLanguage] = useState('en');
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [selectedPeriod, setSelectedPeriod] = useState('Q4-2024');
  const [selectedBranch, setSelectedBranch] = useState('all');
  const [showNotifications, setShowNotifications] = useState(false);
  const [selectedMetric, setSelectedMetric] = useState(null);

  // Add custom styles
  const customStyles = `
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
    
    @keyframes pulse {
      0%, 100% {
        transform: scale(1);
      }
      50% {
        transform: scale(1.05);
      }
    }
    
    .animate-fadeInUp {
      animation: fadeInUp 0.5s ease-out;
    }
    
    .animate-pulse-slow {
      animation: pulse 2s ease-in-out infinite;
    }
    
    .glassmorphism {
      background: rgba(255, 255, 255, 0.7);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.3);
    }
  `;

  // Inject styles
  React.useEffect(() => {
    const styleElement = document.createElement('style');
    styleElement.textContent = customStyles;
    document.head.appendChild(styleElement);
    return () => {
      document.head.removeChild(styleElement);
    };
  }, []);

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
      treasury: 'Treasury & Investment',
      risk: 'Risk Management',
      corporate: 'Corporate Banking',
      retail: 'Retail Banking',
      wealth: 'Wealth Management',
      digital: 'Digital Banking',
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
      processingEfficiency: 'Processing Efficiency',
      liquidityRatio: 'Liquidity Ratio',
      capitalAdequacy: 'Capital Adequacy',
      npfRatio: 'NPF Ratio',
      roi: 'Return on Investment',
      depositGrowth: 'Deposit Growth',
      financingGrowth: 'Financing Growth',
      marketShare: 'Market Share',
      operationalEfficiency: 'Operational Efficiency',
      riskMetrics: 'Risk Metrics',
      investmentPerformance: 'Investment Performance',
      sukukPortfolio: 'Sukuk Portfolio',
      realTimeAnalytics: 'Real-Time Analytics',
      aiInsights: 'AI-Powered Insights',
      notifications: 'Notifications',
      viewDetails: 'View Details',
      lastUpdated: 'Last Updated',
      performance: 'Performance',
      trending: 'Trending',
      alerts: 'Alerts',
      criticalAlerts: 'Critical Alerts',
      newCustomers: 'New Customers Today',
      revenue: 'Revenue',
      expenses: 'Expenses',
      netProfit: 'Net Profit',
      targetAchieved: 'Target Achieved'
    },
    ar: {
      title: 'نظام تقارير أصول الحديثة',
      subtitle: 'لوحة تحليلات التمويل الإسلامي',
      dashboard: 'لوحة المعلومات التنفيذية',
      portfolio: 'تحليلات المحفظة',
      compliance: 'الامتثال الشرعي',
      customers: 'تحليلات العملاء',
      operations: 'العمليات',
      reports: 'التقارير',
      treasury: 'الخزينة والاستثمار',
      risk: 'إدارة المخاطر',
      corporate: 'الخدمات المصرفية للشركات',
      retail: 'الخدمات المصرفية للأفراد',
      wealth: 'إدارة الثروات',
      digital: 'الخدمات المصرفية الرقمية',
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
      processingEfficiency: 'كفاءة المعالجة',
      liquidityRatio: 'نسبة السيولة',
      capitalAdequacy: 'كفاية رأس المال',
      npfRatio: 'نسبة التمويل غير العامل',
      roi: 'العائد على الاستثمار',
      depositGrowth: 'نمو الودائع',
      financingGrowth: 'نمو التمويل',
      marketShare: 'الحصة السوقية',
      operationalEfficiency: 'الكفاءة التشغيلية',
      riskMetrics: 'مؤشرات المخاطر',
      investmentPerformance: 'أداء الاستثمار',
      sukukPortfolio: 'محفظة الصكوك',
      realTimeAnalytics: 'التحليلات الآنية',
      aiInsights: 'رؤى الذكاء الاصطناعي',
      notifications: 'الإشعارات',
      viewDetails: 'عرض التفاصيل',
      lastUpdated: 'آخر تحديث',
      performance: 'الأداء',
      trending: 'الاتجاهات',
      alerts: 'التنبيهات',
      criticalAlerts: 'تنبيهات حرجة',
      newCustomers: 'عملاء جدد اليوم',
      revenue: 'الإيرادات',
      expenses: 'المصروفات',
      netProfit: 'صافي الربح',
      targetAchieved: 'الهدف المحقق'
    }
  };

  const t = translations[language];

  const monthlyData = [
    { month: 'Jan', financing: 12.5, applications: 145, approved: 128, deposits: 185, revenue: 8.2 },
    { month: 'Feb', financing: 14.2, applications: 162, approved: 142, deposits: 192, revenue: 9.1 },
    { month: 'Mar', financing: 15.8, applications: 178, approved: 156, deposits: 198, revenue: 10.2 },
    { month: 'Apr', financing: 16.3, applications: 185, approved: 165, deposits: 205, revenue: 10.8 },
    { month: 'May', financing: 17.9, applications: 198, approved: 175, deposits: 212, revenue: 11.9 },
    { month: 'Jun', financing: 18.6, applications: 210, approved: 188, deposits: 220, revenue: 12.4 },
    { month: 'Jul', financing: 19.2, applications: 225, approved: 198, deposits: 228, revenue: 13.1 },
    { month: 'Aug', financing: 20.1, applications: 238, approved: 210, deposits: 235, revenue: 13.8 },
    { month: 'Sep', financing: 21.5, applications: 248, approved: 220, deposits: 242, revenue: 14.7 },
    { month: 'Oct', financing: 22.8, applications: 265, approved: 235, deposits: 250, revenue: 15.5 },
    { month: 'Nov', financing: 23.9, applications: 278, approved: 248, deposits: 258, revenue: 16.2 },
    { month: 'Dec', financing: 25.2, applications: 292, approved: 262, deposits: 268, revenue: 17.1 }
  ];

  const portfolioData = [
    { name: t.personal, value: 55, amount: 138.6, growth: 12.5 },
    { name: t.business, value: 30, amount: 75.6, growth: 15.2 },
    { name: t.retirement, value: 15, amount: 37.8, growth: 8.7 }
  ];

  const branchData = [
    { branch: t.jeddah, financing: 98.5, clients: 1250, satisfaction: 94, growth: 15.2 },
    { branch: t.riyadh, financing: 87.3, clients: 1100, satisfaction: 92, growth: 12.8 },
    { branch: t.khobar, financing: 66.4, clients: 850, satisfaction: 93, growth: 18.5 }
  ];

  const customerSegmentData = [
    { segment: t.government, value: 40, growth: 12, satisfaction: 95 },
    { segment: t.military, value: 25, growth: 15, satisfaction: 93 },
    { segment: t.private, value: 35, growth: 18, satisfaction: 91 }
  ];

  // New data structures for enhanced features
  const riskMetricsData = [
    { metric: 'Credit Risk', value: 2.3, threshold: 5, status: 'low' },
    { metric: 'Market Risk', value: 3.8, threshold: 5, status: 'medium' },
    { metric: 'Operational Risk', value: 1.9, threshold: 5, status: 'low' },
    { metric: 'Liquidity Risk', value: 2.1, threshold: 5, status: 'low' }
  ];

  const sukukData = [
    { name: 'Government Sukuk', value: 45, yield: 3.8, maturity: '5Y' },
    { name: 'Corporate Sukuk', value: 30, yield: 4.5, maturity: '3Y' },
    { name: 'International Sukuk', value: 25, yield: 4.2, maturity: '7Y' }
  ];

  const digitalMetrics = [
    { channel: 'Mobile App', users: 125000, transactions: 892000, growth: 45 },
    { channel: 'Internet Banking', users: 85000, transactions: 456000, growth: 28 },
    { channel: 'ATM', users: 165000, transactions: 1250000, growth: 12 },
    { channel: 'Branch', users: 45000, transactions: 125000, growth: -15 }
  ];

  const aiInsights = [
    { type: 'opportunity', title: 'High-Value Customer Segment', description: 'Identified 250 customers with potential for wealth management services', impact: 'high' },
    { type: 'risk', title: 'Increasing NPF in Auto Finance', description: 'NPF ratio trending upward in auto finance segment, requires attention', impact: 'medium' },
    { type: 'trend', title: 'Digital Adoption Surge', description: 'Mobile banking adoption increased 45% QoQ, highest in industry', impact: 'high' }
  ];

  const notifications = [
    { id: 1, type: 'alert', message: 'Large withdrawal detected: SAR 5.2M from Corporate Account', time: '5 mins ago', priority: 'high' },
    { id: 2, type: 'success', message: 'Q4 targets achieved: 108% of financing goal', time: '1 hour ago', priority: 'medium' },
    { id: 3, type: 'info', message: 'New Sharia board ruling on cryptocurrency trading', time: '2 hours ago', priority: 'low' },
    { id: 4, type: 'warning', message: 'System maintenance scheduled for tonight 2-4 AM', time: '3 hours ago', priority: 'medium' }
  ];

  const COLORS = ['#D69E2E', '#744210', '#2D3748', '#F6AD55', '#718096', '#E53E3E', '#38B2AC', '#805AD5'];

  const MetricCard = ({ icon: Icon, label, value, change, color = "text-gray-600", trend, onClick }) => (
    <div 
      className="bg-white rounded-xl p-6 shadow-sm hover:shadow-lg transition-all duration-300 border border-gray-100 cursor-pointer transform hover:scale-105"
      onClick={onClick}
    >
      <div className="flex items-center justify-between mb-4">
        <div className={`p-3 rounded-lg ${color === 'primary' ? 'bg-yellow-50' : 'bg-gray-50'}`}>
          <Icon className={`w-6 h-6 ${color === 'primary' ? 'text-yellow-600' : 'text-gray-600'}`} />
        </div>
        {change && (
          <span className={`text-sm font-medium ${change > 0 ? 'text-green-600' : 'text-red-600'} flex items-center gap-1`}>
            {change > 0 ? '↑' : '↓'}{Math.abs(change)}%
          </span>
        )}
      </div>
      <p className="text-gray-500 text-sm mb-1">{label}</p>
      <p className="text-2xl font-bold text-gray-800">{value}</p>
      {trend && (
        <div className="mt-3 h-8">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={trend}>
              <Line type="monotone" dataKey="value" stroke="#D69E2E" strokeWidth={2} dot={false} />
            </LineChart>
          </ResponsiveContainer>
        </div>
      )}
    </div>
  );

  const InsightCard = ({ insight }) => {
    const iconMap = {
      opportunity: Target,
      risk: Activity,
      trend: TrendingUp
    };
    const Icon = iconMap[insight.type];
    const colorMap = {
      opportunity: 'bg-green-50 text-green-600 border-green-200',
      risk: 'bg-red-50 text-red-600 border-red-200',
      trend: 'bg-blue-50 text-blue-600 border-blue-200'
    };

    return (
      <div className={`p-4 rounded-lg border ${colorMap[insight.type]} transition-all duration-300 hover:shadow-md`}>
        <div className="flex items-start gap-3">
          <Icon className="w-5 h-5 mt-0.5" />
          <div className="flex-1">
            <h4 className="font-semibold text-gray-800">{insight.title}</h4>
            <p className="text-sm text-gray-600 mt-1">{insight.description}</p>
            <div className="flex items-center justify-between mt-2">
              <span className={`text-xs px-2 py-1 rounded-full ${
                insight.impact === 'high' ? 'bg-red-100 text-red-700' :
                insight.impact === 'medium' ? 'bg-yellow-100 text-yellow-700' :
                'bg-green-100 text-green-700'
              }`}>
                {insight.impact} impact
              </span>
              <button className="text-xs text-blue-600 hover:underline">{t.viewDetails}</button>
            </div>
          </div>
        </div>
      </div>
    );
  };

  const RiskGauge = ({ title, value, max = 5 }) => {
    const percentage = (value / max) * 100;
    const getColor = () => {
      if (percentage < 40) return '#10B981';
      if (percentage < 70) return '#F59E0B';
      return '#EF4444';
    };

    return (
      <div className="text-center">
        <h4 className="text-sm text-gray-600 mb-2">{title}</h4>
        <div className="relative w-32 h-32 mx-auto">
          <svg className="transform -rotate-90 w-32 h-32">
            <circle cx="64" cy="64" r="56" stroke="#E5E7EB" strokeWidth="12" fill="none" />
            <circle
              cx="64"
              cy="64"
              r="56"
              stroke={getColor()}
              strokeWidth="12"
              fill="none"
              strokeDasharray={`${percentage * 3.52} 352`}
              className="transition-all duration-1000"
            />
          </svg>
          <div className="absolute inset-0 flex items-center justify-center">
            <span className="text-2xl font-bold">{value}</span>
          </div>
        </div>
      </div>
    );
  };

  const NotificationPanel = () => (
    <div className={`fixed ${language === 'ar' ? 'left-4' : 'right-4'} top-20 w-96 bg-white rounded-xl shadow-2xl border border-gray-200 z-50 transition-all duration-300 ${
      showNotifications ? 'opacity-100 translate-y-0' : 'opacity-0 -translate-y-4 pointer-events-none'
    }`}>
      <div className="p-4 border-b border-gray-200">
        <div className="flex items-center justify-between">
          <h3 className="font-semibold text-gray-800">{t.notifications}</h3>
          <button
            onClick={() => setShowNotifications(false)}
            className="text-gray-400 hover:text-gray-600"
          >
            <X size={20} />
          </button>
        </div>
      </div>
      <div className="max-h-96 overflow-y-auto">
        {notifications.map(notif => (
          <div key={notif.id} className={`p-4 border-b border-gray-100 hover:bg-gray-50 transition-colors`}>
            <div className="flex items-start gap-3">
              <div className={`w-2 h-2 rounded-full mt-2 ${
                notif.type === 'alert' ? 'bg-red-500' :
                notif.type === 'success' ? 'bg-green-500' :
                notif.type === 'warning' ? 'bg-yellow-500' :
                'bg-blue-500'
              }`} />
              <div className="flex-1">
                <p className="text-sm text-gray-800">{notif.message}</p>
                <p className="text-xs text-gray-500 mt-1">{notif.time}</p>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );

  const Sidebar = () => (
    <div className={`fixed ${language === 'ar' ? 'right-0' : 'left-0'} top-0 h-full bg-gradient-to-b from-gray-800 to-gray-700 text-white transition-all duration-300 z-40 ${
      sidebarOpen ? 'w-64' : 'w-20'
    }`}>
      <div className="p-6">
        <div className="flex items-center justify-between mb-8">
          <div className={`flex items-center ${sidebarOpen ? '' : 'justify-center'}`}>
            <img 
              src={osoulLogo} 
              alt="Osoul Logo" 
              className="w-12 h-12 object-contain bg-white rounded-lg p-1"
            />
            {sidebarOpen && (
              <div className={language === 'ar' ? 'mr-3' : 'ml-3'}>
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
            { id: 'treasury', icon: Building, label: t.treasury },
            { id: 'risk', icon: Target, label: t.risk },
            { id: 'corporate', icon: Building, label: t.corporate },
            { id: 'retail', icon: Users, label: t.retail },
            { id: 'wealth', icon: Award, label: t.wealth },
            { id: 'digital', icon: Globe, label: t.digital },
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
              {sidebarOpen && <span className={language === 'ar' ? 'mr-3' : 'ml-3'}>{item.label}</span>}
            </button>
          ))}
        </nav>
      </div>
    </div>
  );

  return (
    <div className="min-h-screen bg-gray-50" dir={language === 'ar' ? 'rtl' : 'ltr'}>
      <Sidebar />
      
      <div className={`${language === 'ar' ? (sidebarOpen ? 'mr-64' : 'mr-20') : (sidebarOpen ? 'ml-64' : 'ml-20')} transition-all duration-300`}>
        {/* Header */}
        <header className="bg-white shadow-sm border-b border-gray-200">
          <div className="px-6 py-4">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-4">
                <img 
                  src={osoulLogo} 
                  alt="Osoul Logo" 
                  className="h-12 w-auto"
                />
                <div>
                  <h1 className="text-2xl font-bold text-gray-800">{t.title}</h1>
                  <p className="text-gray-500 text-sm">{t.subtitle}</p>
                </div>
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
                  onClick={() => setShowNotifications(!showNotifications)}
                  className="relative p-2 hover:bg-gray-100 rounded-lg transition-colors"
                >
                  <Bell size={20} />
                  <span className={`absolute top-0 ${language === 'ar' ? 'left-0' : 'right-0'} w-3 h-3 bg-red-500 rounded-full animate-pulse`} />
                </button>
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
          {/* Notification Panel */}
          <NotificationPanel />

          {activeTab === 'dashboard' && (
            <div className="space-y-6">
              {/* Welcome Section with Real-time Metrics */}
              <div className="bg-gradient-to-r from-yellow-400 to-yellow-600 rounded-xl p-6 text-white animate-fadeInUp">
                <div className="flex items-center justify-between">
                  <div>
                    <h2 className="text-2xl font-bold mb-2">Good {new Date().getHours() < 12 ? 'Morning' : 'Evening'}, Ahmad</h2>
                    <p className="opacity-90">Here's your executive summary for {new Date().toLocaleDateString()}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm opacity-75">{t.lastUpdated}</p>
                    <p className="text-2xl font-bold">2 minutes ago</p>
                  </div>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mt-6">
                  <div className="bg-white/20 backdrop-blur rounded-lg p-4 hover:bg-white/30 transition-all duration-300 cursor-pointer transform hover:scale-105">
                    <p className="text-sm opacity-90">{t.newCustomers}</p>
                    <p className="text-2xl font-bold">+42</p>
                  </div>
                  <div className="bg-white/20 backdrop-blur rounded-lg p-4 hover:bg-white/30 transition-all duration-300 cursor-pointer transform hover:scale-105">
                    <p className="text-sm opacity-90">{t.revenue}</p>
                    <p className="text-2xl font-bold">SAR 4.2M</p>
                  </div>
                  <div className="bg-white/20 backdrop-blur rounded-lg p-4 hover:bg-white/30 transition-all duration-300 cursor-pointer transform hover:scale-105">
                    <p className="text-sm opacity-90">{t.targetAchieved}</p>
                    <p className="text-2xl font-bold">108%</p>
                  </div>
                  <div className="bg-white/20 backdrop-blur rounded-lg p-4 hover:bg-white/30 transition-all duration-300 cursor-pointer transform hover:scale-105 animate-pulse-slow">
                    <p className="text-sm opacity-90">{t.criticalAlerts}</p>
                    <p className="text-2xl font-bold">2</p>
                  </div>
                </div>
              </div>

              {/* KPI Cards with Sparklines */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <MetricCard
                  icon={DollarSign}
                  label={t.totalFinancing}
                  value="252M SAR"
                  change={12.5}
                  color="primary"
                  trend={[{value: 230}, {value: 235}, {value: 240}, {value: 245}, {value: 252}]}
                />
                <MetricCard
                  icon={Users}
                  label={t.activeClients}
                  value="3,200"
                  change={8.3}
                  color="primary"
                  trend={[{value: 2950}, {value: 3000}, {value: 3050}, {value: 3100}, {value: 3200}]}
                />
                <MetricCard
                  icon={Clock}
                  label={t.avgProcessingTime}
                  value={`7.2 ${t.days}`}
                  change={-15.2}
                  trend={[{value: 8.5}, {value: 8.1}, {value: 7.8}, {value: 7.5}, {value: 7.2}]}
                />
                <MetricCard
                  icon={Award}
                  label={t.complianceRate}
                  value="99.8%"
                  change={0.3}
                  trend={[{value: 99.5}, {value: 99.6}, {value: 99.7}, {value: 99.7}, {value: 99.8}]}
                />
              </div>

              {/* AI Insights Section */}
              <div className="bg-white rounded-xl shadow-sm p-6">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="text-lg font-semibold flex items-center gap-2">
                    <Shield className="w-5 h-5 text-yellow-600" />
                    {t.aiInsights}
                  </h3>
                  <button className="text-sm text-blue-600 hover:underline">View All Insights</button>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  {aiInsights.map((insight, index) => (
                    <InsightCard key={index} insight={insight} />
                  ))}
                </div>
              </div>

              {/* Enhanced Charts with Interactions */}
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="bg-white p-6 rounded-xl shadow-sm">
                  <div className="flex items-center justify-between mb-4">
                    <h3 className="text-lg font-semibold">{t.financingTrend}</h3>
                    <div className="flex gap-2">
                      <button className="px-3 py-1 text-sm bg-yellow-100 text-yellow-700 rounded-lg">Monthly</button>
                      <button className="px-3 py-1 text-sm text-gray-600 hover:bg-gray-100 rounded-lg">Quarterly</button>
                      <button className="px-3 py-1 text-sm text-gray-600 hover:bg-gray-100 rounded-lg">Yearly</button>
                    </div>
                  </div>
                  <ResponsiveContainer width="100%" height={300}>
                    <AreaChart data={monthlyData}>
                      <defs>
                        <linearGradient id="colorFinancing" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="5%" stopColor="#D69E2E" stopOpacity={0.8}/>
                          <stop offset="95%" stopColor="#D69E2E" stopOpacity={0.1}/>
                        </linearGradient>
                        <linearGradient id="colorRevenue" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="5%" stopColor="#3B82F6" stopOpacity={0.8}/>
                          <stop offset="95%" stopColor="#3B82F6" stopOpacity={0.1}/>
                        </linearGradient>
                      </defs>
                      <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                      <XAxis dataKey="month" />
                      <YAxis />
                      <Tooltip 
                        contentStyle={{ backgroundColor: 'rgba(255, 255, 255, 0.95)', borderRadius: '8px', border: '1px solid #e5e7eb' }}
                        labelStyle={{ color: '#111827', fontWeight: 'bold' }}
                      />
                      <Legend />
                      <Area 
                        type="monotone" 
                        dataKey="financing" 
                        stroke="#D69E2E" 
                        fillOpacity={1} 
                        fill="url(#colorFinancing)"
                        name="Financing (M SAR)" 
                      />
                      <Area 
                        type="monotone" 
                        dataKey="revenue" 
                        stroke="#3B82F6" 
                        fillOpacity={1} 
                        fill="url(#colorRevenue)"
                        name="Revenue (M SAR)" 
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
                        label={({ name, value, amount }) => `${name}: SAR ${amount}M`}
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
                  <div className="mt-4 space-y-2">
                    {portfolioData.map((item, index) => (
                      <div key={index} className="flex items-center justify-between text-sm">
                        <div className="flex items-center gap-2">
                          <div className={`w-3 h-3 rounded-full`} style={{ backgroundColor: COLORS[index] }} />
                          <span>{item.name}</span>
                        </div>
                        <span className="font-medium">SAR {item.amount}M ({item.value}%)</span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              {/* Risk Metrics Dashboard */}
              <div className="bg-white p-6 rounded-xl shadow-sm">
                <h3 className="text-lg font-semibold mb-6">{t.riskMetrics}</h3>
                <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
                  {riskMetricsData.map((risk, index) => (
                    <RiskGauge key={index} title={risk.metric} value={risk.value} />
                  ))}
                </div>
              </div>

              {/* Enhanced Branch Performance */}
              <div className="bg-white p-6 rounded-xl shadow-sm">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="text-lg font-semibold">{t.branchPerformance}</h3>
                  <button className="text-sm text-blue-600 hover:underline flex items-center gap-1">
                    Detailed Analysis {language === 'ar' ? <ChevronLeft size={16} /> : <ChevronRight size={16} />}
                  </button>
                </div>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={branchData}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                    <XAxis dataKey="branch" />
                    <YAxis yAxisId="left" />
                    <YAxis yAxisId="right" orientation="right" />
                    <Tooltip />
                    <Legend />
                    <Bar yAxisId="left" dataKey="financing" fill="#D69E2E" name={t.totalFinancing} radius={[8, 8, 0, 0]} />
                    <Bar yAxisId="right" dataKey="satisfaction" fill="#4A5568" name={t.customerSatisfaction} radius={[8, 8, 0, 0]} />
                  </BarChart>
                </ResponsiveContainer>
                <div className="grid grid-cols-3 gap-4 mt-6">
                  {branchData.map((branch, index) => (
                    <div key={index} className="text-center p-4 bg-gray-50 rounded-lg">
                      <h4 className="font-semibold text-gray-800">{branch.branch}</h4>
                      <div className="mt-2 space-y-1">
                        <p className="text-sm text-gray-600">Growth: <span className="font-medium text-green-600">+{branch.growth}%</span></p>
                        <p className="text-sm text-gray-600">Clients: <span className="font-medium">{branch.clients.toLocaleString()}</span></p>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          )}

          {activeTab === 'treasury' && (
            <div className="space-y-6">
              {/* Treasury KPIs */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <MetricCard
                  icon={Building}
                  label={t.liquidityRatio}
                  value="42.5%"
                  change={2.3}
                  color="primary"
                />
                <MetricCard
                  icon={DollarSign}
                  label="Total Investments"
                  value="SAR 1.8B"
                  change={15.7}
                />
                <MetricCard
                  icon={Percent}
                  label="Yield to Maturity"
                  value="4.2%"
                  change={0.5}
                />
                <MetricCard
                  icon={Shield}
                  label="Risk-Adjusted Return"
                  value="12.8%"
                  change={3.2}
                  color="primary"
                />
              </div>

              {/* Sukuk Portfolio */}
              <div className="bg-white rounded-xl shadow-sm p-6">
                <h3 className="text-lg font-semibold mb-4">{t.sukukPortfolio}</h3>
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={sukukData}
                        cx="50%"
                        cy="50%"
                        innerRadius={60}
                        outerRadius={100}
                        fill="#8884d8"
                        paddingAngle={5}
                        dataKey="value"
                      >
                        {sukukData.map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                      </Pie>
                      <Tooltip />
                    </PieChart>
                  </ResponsiveContainer>
                  <div className="space-y-4">
                    {sukukData.map((sukuk, index) => (
                      <div key={index} className="p-4 border border-gray-200 rounded-lg">
                        <div className="flex items-center justify-between mb-2">
                          <h4 className="font-semibold">{sukuk.name}</h4>
                          <span className="text-lg font-bold text-yellow-600">{sukuk.value}%</span>
                        </div>
                        <div className="grid grid-cols-2 gap-4 text-sm">
                          <div>
                            <span className="text-gray-500">Yield</span>
                            <p className="font-medium">{sukuk.yield}%</p>
                          </div>
                          <div>
                            <span className="text-gray-500">Maturity</span>
                            <p className="font-medium">{sukuk.maturity}</p>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              {/* Liquidity Management */}
              <div className="bg-white rounded-xl shadow-sm p-6">
                <h3 className="text-lg font-semibold mb-4">Liquidity Management</h3>
                <ResponsiveContainer width="100%" height={300}>
                  <AreaChart data={monthlyData}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="month" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Area type="monotone" dataKey="deposits" stackId="1" stroke="#8884d8" fill="#8884d8" name="Deposits" />
                    <Area type="monotone" dataKey="financing" stackId="1" stroke="#D69E2E" fill="#D69E2E" name="Financing" />
                  </AreaChart>
                </ResponsiveContainer>
              </div>
            </div>
          )}

          {activeTab === 'risk' && (
            <div className="space-y-6">
              {/* Risk Dashboard */}
              <div className="bg-gradient-to-r from-red-50 to-orange-50 rounded-xl p-6 border border-red-200">
                <h3 className="text-xl font-semibold text-gray-800 mb-4">Risk Alert Summary</h3>
                <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                  <div className="bg-white rounded-lg p-4 border border-red-200">
                    <AlertCircle className="w-8 h-8 text-red-500 mb-2" />
                    <p className="text-sm text-gray-600">High Risk Items</p>
                    <p className="text-2xl font-bold text-red-600">3</p>
                  </div>
                  <div className="bg-white rounded-lg p-4 border border-yellow-200">
                    <Shield className="w-8 h-8 text-yellow-500 mb-2" />
                    <p className="text-sm text-gray-600">Medium Risk Items</p>
                    <p className="text-2xl font-bold text-yellow-600">12</p>
                  </div>
                  <div className="bg-white rounded-lg p-4 border border-green-200">
                    <Target className="w-8 h-8 text-green-500 mb-2" />
                    <p className="text-sm text-gray-600">Low Risk Items</p>
                    <p className="text-2xl font-bold text-green-600">45</p>
                  </div>
                  <div className="bg-white rounded-lg p-4 border border-blue-200">
                    <Activity className="w-8 h-8 text-blue-500 mb-2" />
                    <p className="text-sm text-gray-600">Risk Score</p>
                    <p className="text-2xl font-bold text-blue-600">72/100</p>
                  </div>
                </div>
              </div>

              {/* Risk Metrics Grid */}
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="bg-white rounded-xl shadow-sm p-6">
                  <h3 className="text-lg font-semibold mb-4">Risk Category Analysis</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={riskMetricsData} layout="vertical">
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis type="number" domain={[0, 5]} />
                      <YAxis dataKey="metric" type="category" />
                      <Tooltip />
                      <Bar dataKey="value" fill="#D69E2E">
                        {riskMetricsData.map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={
                            entry.status === 'low' ? '#10B981' :
                            entry.status === 'medium' ? '#F59E0B' :
                            '#EF4444'
                          } />
                        ))}
                      </Bar>
                    </BarChart>
                  </ResponsiveContainer>
                </div>

                <div className="bg-white rounded-xl shadow-sm p-6">
                  <h3 className="text-lg font-semibold mb-4">NPF Trend Analysis</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <LineChart data={monthlyData}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="month" />
                      <YAxis />
                      <Tooltip />
                      <Line type="monotone" dataKey="applications" stroke="#EF4444" strokeWidth={2} name="NPF Count" />
                      <Line type="monotone" dataKey="approved" stroke="#10B981" strokeWidth={2} name="Resolved" />
                    </LineChart>
                  </ResponsiveContainer>
                </div>
              </div>

              {/* Stress Testing Scenarios */}
              <div className="bg-white rounded-xl shadow-sm p-6">
                <h3 className="text-lg font-semibold mb-4">Stress Testing Scenarios</h3>
                <div className="overflow-x-auto">
                  <table className="w-full">
                    <thead>
                      <tr className="border-b border-gray-200">
                        <th className="text-left py-3 px-4">Scenario</th>
                        <th className="text-center py-3 px-4">Impact on Capital</th>
                        <th className="text-center py-3 px-4">Impact on Liquidity</th>
                        <th className="text-center py-3 px-4">Overall Risk</th>
                        <th className="text-center py-3 px-4">Action Required</th>
                      </tr>
                    </thead>
                    <tbody>
                      {[
                        { scenario: 'Oil Price Shock (-30%)', capital: -2.5, liquidity: -1.8, risk: 'High', action: 'Yes' },
                        { scenario: 'Real Estate Downturn', capital: -1.9, liquidity: -1.2, risk: 'Medium', action: 'Monitor' },
                        { scenario: 'Currency Devaluation', capital: -1.2, liquidity: -0.8, risk: 'Low', action: 'No' },
                        { scenario: 'Pandemic Scenario', capital: -3.2, liquidity: -2.5, risk: 'High', action: 'Yes' }
                      ].map((scenario, index) => (
                        <tr key={index} className="border-b border-gray-100 hover:bg-gray-50">
                          <td className="py-3 px-4">{scenario.scenario}</td>
                          <td className="text-center py-3 px-4">
                            <span className={`font-medium ${scenario.capital < -2 ? 'text-red-600' : 'text-yellow-600'}`}>
                              {scenario.capital}%
                            </span>
                          </td>
                          <td className="text-center py-3 px-4">
                            <span className={`font-medium ${scenario.liquidity < -2 ? 'text-red-600' : 'text-yellow-600'}`}>
                              {scenario.liquidity}%
                            </span>
                          </td>
                          <td className="text-center py-3 px-4">
                            <span className={`px-3 py-1 rounded-full text-xs font-medium ${
                              scenario.risk === 'High' ? 'bg-red-100 text-red-700' :
                              scenario.risk === 'Medium' ? 'bg-yellow-100 text-yellow-700' :
                              'bg-green-100 text-green-700'
                            }`}>
                              {scenario.risk}
                            </span>
                          </td>
                          <td className="text-center py-3 px-4">
                            <span className={`font-medium ${
                              scenario.action === 'Yes' ? 'text-red-600' :
                              scenario.action === 'Monitor' ? 'text-yellow-600' :
                              'text-green-600'
                            }`}>
                              {scenario.action}
                            </span>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          )}

          {activeTab === 'corporate' && (
            <div className="space-y-6">
              {/* Corporate Banking KPIs */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <MetricCard
                  icon={Building}
                  label="Corporate Clients"
                  value="482"
                  change={12.5}
                  color="primary"
                />
                <MetricCard
                  icon={DollarSign}
                  label="Corporate Portfolio"
                  value="SAR 1.2B"
                  change={18.3}
                />
                <MetricCard
                  icon={BarChart2}
                  label="Avg Deal Size"
                  value="SAR 2.5M"
                  change={8.7}
                />
                <MetricCard
                  icon={Percent}
                  label="Utilization Rate"
                  value="76%"
                  change={5.2}
                  color="primary"
                />
              </div>

              {/* Industry Sector Analysis */}
              <div className="bg-white rounded-xl shadow-sm p-6">
                <h3 className="text-lg font-semibold mb-4">Industry Sector Distribution</h3>
                <ResponsiveContainer width="100%" height={300}>
                  <PieChart>
                    <Pie
                      data={[
                        { name: 'Manufacturing', value: 25, amount: 300 },
                        { name: 'Real Estate', value: 20, amount: 240 },
                        { name: 'Healthcare', value: 15, amount: 180 },
                        { name: 'Technology', value: 15, amount: 180 },
                        { name: 'Retail', value: 10, amount: 120 },
                        { name: 'Others', value: 15, amount: 180 }
                      ]}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      label={({ name, value }) => `${name}: ${value}%`}
                      outerRadius={100}
                      fill="#8884d8"
                      dataKey="value"
                    >
                      {[
                        { name: 'Manufacturing', value: 25, amount: 300 },
                        { name: 'Real Estate', value: 20, amount: 240 },
                        { name: 'Healthcare', value: 15, amount: 180 },
                        { name: 'Technology', value: 15, amount: 180 },
                        { name: 'Retail', value: 10, amount: 120 },
                        { name: 'Others', value: 15, amount: 180 }
                      ].map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip />
                  </PieChart>
                </ResponsiveContainer>
              </div>

              {/* Top Corporate Relationships */}
              <div className="bg-white rounded-xl shadow-sm p-6">
                <h3 className="text-lg font-semibold mb-4">Top Corporate Relationships</h3>
                <div className="overflow-x-auto">
                  <table className="w-full">
                    <thead>
                      <tr className="border-b border-gray-200">
                        <th className="text-left py-3 px-4">Company</th>
                        <th className="text-center py-3 px-4">Sector</th>
                        <th className="text-center py-3 px-4">Exposure (SAR M)</th>
                        <th className="text-center py-3 px-4">Utilization</th>
                        <th className="text-center py-3 px-4">Risk Rating</th>
                        <th className="text-center py-3 px-4">Relationship Score</th>
                      </tr>
                    </thead>
                    <tbody>
                      {[
                        { company: 'Al Rajhi Industries', sector: 'Manufacturing', exposure: 85, utilization: 78, risk: 'Low', score: 95 },
                        { company: 'Saudi Medical Group', sector: 'Healthcare', exposure: 62, utilization: 82, risk: 'Low', score: 92 },
                        { company: 'Tech Innovations SA', sector: 'Technology', exposure: 45, utilization: 65, risk: 'Medium', score: 88 },
                        { company: 'Desert Construction', sector: 'Real Estate', exposure: 58, utilization: 88, risk: 'Medium', score: 85 },
                        { company: 'Green Energy Solutions', sector: 'Energy', exposure: 72, utilization: 70, risk: 'Low', score: 90 }
                      ].map((client, index) => (
                        <tr key={index} className="border-b border-gray-100 hover:bg-gray-50">
                          <td className="py-3 px-4 font-medium">{client.company}</td>
                          <td className="text-center py-3 px-4">{client.sector}</td>
                          <td className="text-center py-3 px-4">{client.exposure}</td>
                          <td className="text-center py-3 px-4">
                            <div className="flex items-center justify-center gap-2">
                              <span>{client.utilization}%</span>
                              <div className="w-16 bg-gray-200 rounded-full h-2">
                                <div 
                                  className="bg-yellow-500 h-2 rounded-full"
                                  style={{ width: `${client.utilization}%` }}
                                />
                              </div>
                            </div>
                          </td>
                          <td className="text-center py-3 px-4">
                            <span className={`px-3 py-1 rounded-full text-xs font-medium ${
                              client.risk === 'Low' ? 'bg-green-100 text-green-700' :
                              client.risk === 'Medium' ? 'bg-yellow-100 text-yellow-700' :
                              'bg-red-100 text-red-700'
                            }`}>
                              {client.risk}
                            </span>
                          </td>
                          <td className="text-center py-3 px-4">
                            <span className={`font-medium ${
                              client.score >= 90 ? 'text-green-600' :
                              client.score >= 80 ? 'text-yellow-600' :
                              'text-red-600'
                            }`}>
                              {client.score}
                            </span>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          )}

          {activeTab === 'retail' && (
            <div className="space-y-6">
              {/* Retail Banking Metrics */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <MetricCard
                  icon={Users}
                  label="Retail Customers"
                  value="125K"
                  change={22.5}
                  color="primary"
                />
                <MetricCard
                  icon={CreditCard}
                  label="Active Cards"
                  value="85K"
                  change={18.2}
                />
                <MetricCard
                  icon={Building}
                  label="Home Finance"
                  value="SAR 450M"
                  change={25.8}
                />
                <MetricCard
                  icon={DollarSign}
                  label="Personal Finance"
                  value="SAR 280M"
                  change={15.3}
                  color="primary"
                />
              </div>

              {/* Product Performance */}
              <div className="bg-white rounded-xl shadow-sm p-6">
                <h3 className="text-lg font-semibold mb-4">Product Performance Matrix</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                  {[
                    { product: 'Home Finance', volume: 'SAR 450M', count: '2,800', growth: 25.8, nps: 72 },
                    { product: 'Auto Finance', volume: 'SAR 180M', count: '4,200', growth: 18.5, nps: 68 },
                    { product: 'Personal Finance', volume: 'SAR 280M', count: '8,500', growth: 15.3, nps: 70 },
                    { product: 'Credit Cards', volume: 'SAR 120M', count: '85,000', growth: 22.1, nps: 65 }
                  ].map((product, index) => (
                    <div key={index} className="bg-gray-50 rounded-lg p-4">
                      <h4 className="font-semibold text-gray-800 mb-3">{product.product}</h4>
                      <div className="space-y-2 text-sm">
                        <div className="flex justify-between">
                          <span className="text-gray-600">Volume</span>
                          <span className="font-medium">{product.volume}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-gray-600">Accounts</span>
                          <span className="font-medium">{product.count}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-gray-600">Growth</span>
                          <span className="font-medium text-green-600">+{product.growth}%</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-gray-600">NPS Score</span>
                          <span className="font-medium">{product.nps}</span>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Customer Demographics */}
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="bg-white rounded-xl shadow-sm p-6">
                  <h3 className="text-lg font-semibold mb-4">Age Distribution</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={[
                      { age: '18-25', customers: 15000 },
                      { age: '26-35', customers: 45000 },
                      { age: '36-45', customers: 38000 },
                      { age: '46-55', customers: 20000 },
                      { age: '55+', customers: 7000 }
                    ]}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="age" />
                      <YAxis />
                      <Tooltip />
                      <Bar dataKey="customers" fill="#D69E2E" radius={[8, 8, 0, 0]} />
                    </BarChart>
                  </ResponsiveContainer>
                </div>

                <div className="bg-white rounded-xl shadow-sm p-6">
                  <h3 className="text-lg font-semibold mb-4">Income Segments</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={[
                          { name: 'High Income (>20K)', value: 15 },
                          { name: 'Upper Middle (15-20K)', value: 25 },
                          { name: 'Middle (10-15K)', value: 35 },
                          { name: 'Lower Middle (5-10K)', value: 20 },
                          { name: 'Low Income (<5K)', value: 5 }
                        ]}
                        cx="50%"
                        cy="50%"
                        innerRadius={60}
                        outerRadius={100}
                        fill="#8884d8"
                        paddingAngle={5}
                        dataKey="value"
                      >
                        {[
                          { name: 'High Income (>20K)', value: 15 },
                          { name: 'Upper Middle (15-20K)', value: 25 },
                          { name: 'Middle (10-15K)', value: 35 },
                          { name: 'Lower Middle (5-10K)', value: 20 },
                          { name: 'Low Income (<5K)', value: 5 }
                        ].map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                      </Pie>
                      <Tooltip />
                    </PieChart>
                  </ResponsiveContainer>
                </div>
              </div>
            </div>
          )}

          {activeTab === 'wealth' && (
            <div className="space-y-6">
              {/* Wealth Management KPIs */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <MetricCard
                  icon={Award}
                  label="HNW Clients"
                  value="1,250"
                  change={28.5}
                  color="primary"
                />
                <MetricCard
                  icon={DollarSign}
                  label="AUM"
                  value="SAR 3.2B"
                  change={32.1}
                />
                <MetricCard
                  icon={Target}
                  label="Avg Portfolio Size"
                  value="SAR 2.6M"
                  change={15.2}
                />
                <MetricCard
                  icon={BarChart2}
                  label="Revenue per Client"
                  value="SAR 85K"
                  change={18.7}
                  color="primary"
                />
              </div>

              {/* Investment Performance */}
              <div className="bg-white rounded-xl shadow-sm p-6">
                <h3 className="text-lg font-semibold mb-4">Portfolio Performance by Strategy</h3>
                <ResponsiveContainer width="100%" height={400}>
                  <LineChart data={[
                    { month: 'Jan', conservative: 3.2, balanced: 5.8, aggressive: 8.5, shariah: 4.5 },
                    { month: 'Feb', conservative: 3.4, balanced: 6.2, aggressive: 9.1, shariah: 4.8 },
                    { month: 'Mar', conservative: 3.5, balanced: 6.5, aggressive: 8.8, shariah: 5.1 },
                    { month: 'Apr', conservative: 3.6, balanced: 6.8, aggressive: 9.5, shariah: 5.3 },
                    { month: 'May', conservative: 3.8, balanced: 7.2, aggressive: 10.2, shariah: 5.6 },
                    { month: 'Jun', conservative: 3.9, balanced: 7.5, aggressive: 9.8, shariah: 5.8 }
                  ]}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="month" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Line type="monotone" dataKey="conservative" stroke="#10B981" strokeWidth={2} name="Conservative" />
                    <Line type="monotone" dataKey="balanced" stroke="#3B82F6" strokeWidth={2} name="Balanced" />
                    <Line type="monotone" dataKey="aggressive" stroke="#EF4444" strokeWidth={2} name="Aggressive" />
                    <Line type="monotone" dataKey="shariah" stroke="#D69E2E" strokeWidth={2} name="Shariah Compliant" />
                  </LineChart>
                </ResponsiveContainer>
              </div>

              {/* Client Segments */}
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                {[
                  { segment: 'Ultra HNW', clients: 125, aum: 'SAR 1.2B', growth: 35, icon: Award },
                  { segment: 'HNW', clients: 450, aum: 'SAR 1.5B', growth: 28, icon: Target },
                  { segment: 'Affluent', clients: 675, aum: 'SAR 500M', growth: 22, icon: Users }
                ].map((segment, index) => {
                  const Icon = segment.icon;
                  return (
                    <div key={index} className="bg-white rounded-xl shadow-sm p-6">
                      <div className="flex items-center justify-between mb-4">
                        <Icon className="w-8 h-8 text-yellow-600" />
                        <span className="text-sm font-medium text-green-600">+{segment.growth}%</span>
                      </div>
                      <h4 className="text-lg font-semibold mb-2">{segment.segment}</h4>
                      <div className="space-y-2 text-sm">
                        <div className="flex justify-between">
                          <span className="text-gray-600">Clients</span>
                          <span className="font-medium">{segment.clients}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-gray-600">AUM</span>
                          <span className="font-medium">{segment.aum}</span>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          )}

          {activeTab === 'digital' && (
            <div className="space-y-6">
              {/* Digital Banking Metrics */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <MetricCard
                  icon={Globe}
                  label="Digital Users"
                  value="210K"
                  change={45.2}
                  color="primary"
                />
                <MetricCard
                  icon={Activity}
                  label="Mobile Transactions"
                  value="892K"
                  change={38.5}
                />
                <MetricCard
                  icon={Clock}
                  label="Avg Session Time"
                  value="8.5 min"
                  change={12.3}
                />
                <MetricCard
                  icon={Target}
                  label="Digital Adoption"
                  value="68%"
                  change={22.8}
                  color="primary"
                />
              </div>

              {/* Channel Performance */}
              <div className="bg-white rounded-xl shadow-sm p-6">
                <h3 className="text-lg font-semibold mb-4">Channel Performance Analysis</h3>
                <ResponsiveContainer width="100%" height={400}>
                  <BarChart data={digitalMetrics}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="channel" />
                    <YAxis yAxisId="left" orientation="left" />
                    <YAxis yAxisId="right" orientation="right" />
                    <Tooltip />
                    <Legend />
                    <Bar yAxisId="left" dataKey="users" fill="#D69E2E" name="Active Users" />
                    <Bar yAxisId="right" dataKey="growth" fill="#3B82F6" name="Growth %" />
                  </BarChart>
                </ResponsiveContainer>
              </div>

              {/* Digital Features Adoption */}
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="bg-white rounded-xl shadow-sm p-6">
                  <h3 className="text-lg font-semibold mb-4">Feature Adoption Rate</h3>
                  <div className="space-y-4">
                    {[
                      { feature: 'Biometric Login', adoption: 85, trend: 'up' },
                      { feature: 'Bill Payments', adoption: 72, trend: 'up' },
                      { feature: 'P2P Transfers', adoption: 68, trend: 'up' },
                      { feature: 'Investment Services', adoption: 45, trend: 'up' },
                      { feature: 'Virtual Cards', adoption: 38, trend: 'stable' }
                    ].map((item, index) => (
                      <div key={index}>
                        <div className="flex items-center justify-between mb-1">
                          <span className="text-sm font-medium">{item.feature}</span>
                          <span className="text-sm text-gray-600">{item.adoption}%</span>
                        </div>
                        <div className="w-full bg-gray-200 rounded-full h-2">
                          <div 
                            className="bg-yellow-500 h-2 rounded-full transition-all duration-1000"
                            style={{ width: `${item.adoption}%` }}
                          />
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

                <div className="bg-white rounded-xl shadow-sm p-6">
                  <h3 className="text-lg font-semibold mb-4">User Journey Analytics</h3>
                  <div className="space-y-3">
                    {[
                      { stage: 'App Download', users: 250000, conversion: 100 },
                      { stage: 'Registration Started', users: 200000, conversion: 80 },
                      { stage: 'KYC Completed', users: 150000, conversion: 60 },
                      { stage: 'First Transaction', users: 120000, conversion: 48 },
                      { stage: 'Regular User', users: 85000, conversion: 34 }
                    ].map((stage, index) => (
                      <div key={index} className="flex items-center gap-3">
                        <div className="flex-1">
                          <div className="flex justify-between text-sm mb-1">
                            <span>{stage.stage}</span>
                            <span className="text-gray-600">{stage.users.toLocaleString()}</span>
                          </div>
                          <div className="w-full bg-gray-200 rounded-full h-3">
                            <div 
                              className="bg-gradient-to-r from-blue-500 to-blue-400 h-3 rounded-full"
                              style={{ width: `${stage.conversion}%` }}
                            />
                          </div>
                        </div>
                        <span className="text-sm font-medium w-12 text-right">{stage.conversion}%</span>
                      </div>
                    ))}
                  </div>
                </div>
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
                      <div className="flex justify-between text-sm">
                        <span className="text-gray-500">Growth Rate</span>
                        <span className="font-medium text-green-600">+{item.growth}%</span>
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

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="bg-white p-6 rounded-xl shadow-sm">
                  <h3 className="text-lg font-semibold mb-4">Sharia Compliance by Product</h3>
                  <div className="space-y-4">
                    {[
                      { product: 'Murabaha', compliance: 100, contracts: 1250 },
                      { product: 'Ijarah', compliance: 100, contracts: 850 },
                      { product: 'Musharakah', compliance: 100, contracts: 450 },
                      { product: 'Tawarruq', compliance: 100, contracts: 648 }
                    ].map((item, index) => (
                      <div key={index} className="border-b border-gray-100 pb-3">
                        <div className="flex justify-between items-center mb-2">
                          <span className="font-medium">{item.product}</span>
                          <span className="text-sm text-gray-600">{item.contracts} contracts</span>
                        </div>
                        <div className="w-full bg-gray-200 rounded-full h-2">
                          <div 
                            className="bg-green-500 h-2 rounded-full"
                            style={{ width: `${item.compliance}%` }}
                          />
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

                <div className="bg-white p-6 rounded-xl shadow-sm">
                  <h3 className="text-lg font-semibold mb-4">Recent Sharia Board Decisions</h3>
                  <div className="space-y-3">
                    {[
                      { date: '15 Jan 2025', decision: 'Approved new Sukuk structure for corporate financing', status: 'approved' },
                      { date: '08 Jan 2025', decision: 'Guidelines on cryptocurrency trading clarified', status: 'pending' },
                      { date: '28 Dec 2024', decision: 'New fatwa on international trade finance', status: 'approved' },
                      { date: '20 Dec 2024', decision: 'Review of profit distribution methodology', status: 'approved' }
                    ].map((item, index) => (
                      <div key={index} className="flex items-start gap-3 p-3 bg-gray-50 rounded-lg">
                        <div className={`w-2 h-2 rounded-full mt-2 ${
                          item.status === 'approved' ? 'bg-green-500' : 'bg-yellow-500'
                        }`} />
                        <div className="flex-1">
                          <p className="text-sm font-medium text-gray-800">{item.decision}</p>
                          <p className="text-xs text-gray-500 mt-1">{item.date}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
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

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="bg-white p-6 rounded-xl shadow-sm">
                  <h3 className="text-lg font-semibold mb-4">Customer Lifetime Value</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={[
                      { segment: 'Premium', clv: 285000, customers: 320 },
                      { segment: 'Gold', clv: 125000, customers: 850 },
                      { segment: 'Silver', clv: 65000, customers: 1200 },
                      { segment: 'Basic', clv: 25000, customers: 830 }
                    ]}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="segment" />
                      <YAxis />
                      <Tooltip />
                      <Bar dataKey="clv" fill="#D69E2E" name="CLV (SAR)" />
                    </BarChart>
                  </ResponsiveContainer>
                </div>

                <div className="bg-white p-6 rounded-xl shadow-sm">
                  <h3 className="text-lg font-semibold mb-4">NPS by Segment</h3>
                  <div className="space-y-4">
                    {[
                      { segment: 'Premium Banking', nps: 72, trend: 'up' },
                      { segment: 'Business Banking', nps: 68, trend: 'up' },
                      { segment: 'Retail Banking', nps: 65, trend: 'stable' },
                      { segment: 'Digital Only', nps: 70, trend: 'up' }
                    ].map((item, index) => (
                      <div key={index}>
                        <div className="flex justify-between items-center mb-2">
                          <span className="font-medium">{item.segment}</span>
                          <div className="flex items-center gap-2">
                            <span className="text-lg font-bold">{item.nps}</span>
                            {item.trend === 'up' && <ArrowUpRight className="w-4 h-4 text-green-500" />}
                            {item.trend === 'down' && <ArrowDownRight className="w-4 h-4 text-red-500" />}
                          </div>
                        </div>
                        <div className="w-full bg-gray-200 rounded-full h-3">
                          <div 
                            className={`h-3 rounded-full ${
                              item.nps >= 70 ? 'bg-green-500' :
                              item.nps >= 50 ? 'bg-yellow-500' :
                              'bg-red-500'
                            }`}
                            style={{ width: `${item.nps}%` }}
                          />
                        </div>
                      </div>
                    ))}
                  </div>
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

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="bg-white p-6 rounded-xl shadow-sm">
                  <h3 className="text-lg font-semibold mb-4">Process Efficiency by Department</h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={[
                      { department: 'Front Office', efficiency: 94, tat: 2.5 },
                      { department: 'Operations', efficiency: 88, tat: 3.8 },
                      { department: 'Credit', efficiency: 85, tat: 4.2 },
                      { department: 'Compliance', efficiency: 92, tat: 2.1 },
                      { department: 'IT Support', efficiency: 90, tat: 1.5 }
                    ]}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="department" />
                      <YAxis />
                      <Tooltip />
                      <Bar dataKey="efficiency" fill="#D69E2E" name="Efficiency %" />
                    </BarChart>
                  </ResponsiveContainer>
                </div>

                <div className="bg-white p-6 rounded-xl shadow-sm">
                  <h3 className="text-lg font-semibold mb-4">Service Level Agreements</h3>
                  <div className="space-y-3">
                    {[
                      { service: 'Account Opening', sla: '24 hours', achieved: 96, status: 'met' },
                      { service: 'Loan Processing', sla: '7 days', achieved: 88, status: 'warning' },
                      { service: 'Card Issuance', sla: '5 days', achieved: 94, status: 'met' },
                      { service: 'Complaint Resolution', sla: '48 hours', achieved: 82, status: 'critical' },
                      { service: 'Document Verification', sla: '2 hours', achieved: 98, status: 'met' }
                    ].map((item, index) => (
                      <div key={index} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                        <div className="flex-1">
                          <p className="font-medium text-sm">{item.service}</p>
                          <p className="text-xs text-gray-500">SLA: {item.sla}</p>
                        </div>
                        <div className="flex items-center gap-3">
                          <span className="text-sm font-medium">{item.achieved}%</span>
                          <div className={`w-3 h-3 rounded-full ${
                            item.status === 'met' ? 'bg-green-500' :
                            item.status === 'warning' ? 'bg-yellow-500' :
                            'bg-red-500'
                          }`} />
                        </div>
                      </div>
                    ))}
                  </div>
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
                    { name: 'Profit Distribution Report', type: 'Financial', frequency: 'Quarterly', lastGenerated: '31 Dec 2024' },
                    { name: 'Digital Banking Analytics', type: 'Digital', frequency: 'Weekly', lastGenerated: '14 Jan 2025' },
                    { name: 'Treasury Performance Report', type: 'Treasury', frequency: 'Daily', lastGenerated: '20 Jan 2025' },
                    { name: 'Regulatory Submission Report', type: 'Compliance', frequency: 'Monthly', lastGenerated: '31 Dec 2024' },
                    { name: 'Executive Dashboard Summary', type: 'Executive', frequency: 'Daily', lastGenerated: '20 Jan 2025' }
                  ].map((report, index) => (
                    <div key={index} className="p-6 flex items-center justify-between hover:bg-gray-50 transition-colors">
                      <div className="flex-1">
                        <h4 className="font-medium text-gray-800">{report.name}</h4>
                        <div className="flex items-center gap-4 mt-1 text-sm text-gray-500">
                          <span className={`px-2 py-1 rounded-full text-xs ${
                            report.type === 'Financial' ? 'bg-blue-100 text-blue-700' :
                            report.type === 'Compliance' ? 'bg-green-100 text-green-700' :
                            report.type === 'Risk' ? 'bg-red-100 text-red-700' :
                            report.type === 'Digital' ? 'bg-purple-100 text-purple-700' :
                            'bg-gray-100 text-gray-700'
                          }`}>{report.type}</span>
                          <span>•</span>
                          <span>{report.frequency}</span>
                          <span>•</span>
                          <span>Last: {report.lastGenerated}</span>
                        </div>
                      </div>
                      <div className="flex gap-2">
                        <button className="px-3 py-2 text-gray-600 hover:bg-gray-100 rounded-lg transition-colors">
                          Schedule
                        </button>
                        <button className="px-4 py-2 bg-yellow-500 text-gray-800 rounded-lg hover:bg-yellow-600 transition-colors flex items-center gap-2 font-semibold">
                          Generate
                          {language === 'ar' ? <ChevronLeft size={16} /> : <ChevronRight size={16} />}
                        </button>
                      </div>
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