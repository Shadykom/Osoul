// src/App.jsx - FIXED VERSION
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { LineChart, Line, BarChart, Bar, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, AreaChart, Area } from 'recharts';
import { Calendar, TrendingUp, Users, DollarSign, FileText, Building, Activity, Download, Filter, Globe, Target, Award, Clock, ChevronRight, ChevronLeft, Menu, X, Bell, AlertCircle, Shield, BarChart2, Percent, ArrowUpRight, ArrowDownRight } from 'lucide-react';
import AuthDebug from './components/AuthDebug';

const OsoulReportingSystem = () => {
  console.log('OsoulReportingSystem component is rendering');
  
  const navigate = useNavigate();
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
      targetAchieved: 'Target Achieved',
      samaReports: 'SAMA Reports',
      samaReportsDesc: 'Saudi Central Bank regulatory and prudential supervision reports',
      prudentialReports: 'Prudential Reports',
      prudentialReportsDesc: 'Regulatory and risk management reports for prudential supervision',
      regulatoryCompliance: 'Regulatory Compliance Reports',
      standardReports: 'Standard Reports',
      standardReportsDesc: 'Regular operational and business reports',
      preview: 'Preview',
      generate: 'Generate',
      schedule: 'Schedule',
      example: 'Example',
      description: 'Description',
      frequency: 'Frequency',
      lastGenerated: 'Last Generated',
      daily: 'Daily',
      weekly: 'Weekly',
      semiAnnual: 'Semi-Annual',
      annual: 'Annual',
      heatMapAnalytics: 'Heat Map Analytics',
      heatMapAnalyticsDesc: 'Visual representation of report generation patterns and system usage',
      customerBehaviorHeatMap: 'Customer Behavior Heat Map',
      customerBehaviorDesc: 'Analysis of customer activity patterns across different channels and time periods',
      transactionVolume: 'Transaction Volume',
      channelUsage: 'Channel Usage',
      peakActivity: 'Peak Activity',
      reportGenerationHeatMap: 'Report Generation Heat Map',
      systemUsageHeatMap: 'System Usage Heat Map',
      peakHours: 'Peak Hours',
      lowActivity: 'Low Activity',
      mediumActivity: 'Medium Activity',
      highActivity: 'High Activity',
      hourlyActivity: 'Hourly Activity Pattern',
      weeklyPattern: 'Weekly Pattern',
      collection: 'Collection'
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
      targetAchieved: 'الهدف المحقق',
      samaReports: 'تقارير ساما',
      samaReportsDesc: 'تقارير البنك المركزي السعودي التنظيمية والرقابة الاحترازية',
      prudentialReports: 'التقارير الاحترازية',
      prudentialReportsDesc: 'تقارير تنظيمية وإدارة المخاطر للرقابة الاحترازية',
      regulatoryCompliance: 'تقارير الامتثال التنظيمي',
      standardReports: 'التقارير القياسية',
      standardReportsDesc: 'تقارير تشغيلية وأعمال منتظمة',
      preview: 'معاينة',
      generate: 'إنشاء',
      schedule: 'جدولة',
      example: 'مثال',
      description: 'الوصف',
      frequency: 'التكرار',
      lastGenerated: 'آخر إنشاء',
      daily: 'يومي',
      weekly: 'أسبوعي',
      semiAnnual: 'نصف سنوي',
      annual: 'سنوي',
      heatMapAnalytics: 'تحليلات الخريطة الحرارية',
      heatMapAnalyticsDesc: 'تمثيل مرئي لأنماط إنشاء التقارير واستخدام النظام',
      customerBehaviorHeatMap: 'خريطة حرارية لسلوك العملاء',
      customerBehaviorDesc: 'تحليل أنماط نشاط العملاء عبر القنوات المختلفة والفترات الزمنية',
      transactionVolume: 'حجم المعاملات',
      channelUsage: 'استخدام القنوات',
      peakActivity: 'ذروة النشاط',
      reportGenerationHeatMap: 'خريطة حرارية لإنشاء التقارير',
      systemUsageHeatMap: 'خريطة حرارية لاستخدام النظام',
      peakHours: 'ساعات الذروة',
      lowActivity: 'نشاط منخفض',
      mediumActivity: 'نشاط متوسط',
      highActivity: 'نشاط مرتفع',
      hourlyActivity: 'نمط النشاط بالساعة',
      weeklyPattern: 'النمط الأسبوعي',
      collection: 'التحصيل'
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

  const heatMapData = {
    reportGeneration: [
      { day: 'Mon', hour: '6AM', value: 20 },
      { day: 'Mon', hour: '7AM', value: 35 },
      { day: 'Mon', hour: '8AM', value: 65 },
      { day: 'Mon', hour: '9AM', value: 85 },
      { day: 'Mon', hour: '10AM', value: 95 },
      { day: 'Mon', hour: '11AM', value: 88 },
      { day: 'Mon', hour: '12PM', value: 45 },
      { day: 'Mon', hour: '1PM', value: 40 },
      { day: 'Mon', hour: '2PM', value: 75 },
      { day: 'Mon', hour: '3PM', value: 82 },
      { day: 'Mon', hour: '4PM', value: 78 },
      { day: 'Mon', hour: '5PM', value: 65 },
      { day: 'Mon', hour: '6PM', value: 35 }
    ],
    systemUsage: {
      weekly: [
        { day: 'Mon', reports: 145, analytics: 320, dataEntry: 280, exports: 95 },
        { day: 'Tue', reports: 152, analytics: 335, dataEntry: 295, exports: 102 },
        { day: 'Wed', reports: 168, analytics: 350, dataEntry: 310, exports: 115 },
        { day: 'Thu', reports: 175, analytics: 365, dataEntry: 325, exports: 122 },
        { day: 'Fri', reports: 125, analytics: 280, dataEntry: 240, exports: 85 },
        { day: 'Sat', reports: 45, analytics: 120, dataEntry: 80, exports: 25 },
        { day: 'Sun', reports: 65, analytics: 180, dataEntry: 120, exports: 38 }
      ]
    },
    customerBehavior: {
      hourly: [
        { hour: '12AM', mobile: 45, web: 12, branch: 0, atm: 25 },
        { hour: '6AM', mobile: 85, web: 25, branch: 0, atm: 45 },
        { hour: '12PM', mobile: 295, web: 165, branch: 165, atm: 175 },
        { hour: '6PM', mobile: 285, web: 185, branch: 45, atm: 105 },
        { hour: '11PM', mobile: 65, web: 35, branch: 0, atm: 45 }
      ],
      transactionTypes: [
        { type: 'Transfer', morning: 1250, afternoon: 1850, evening: 950, night: 350 },
        { type: 'Payment', morning: 850, afternoon: 1250, evening: 1450, night: 450 },
        { type: 'Withdrawal', morning: 650, afternoon: 950, evening: 750, night: 250 },
        { type: 'Deposit', morning: 450, afternoon: 650, evening: 350, night: 150 }
      ]
    }
  };

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

  // Logo component fallback
  const OsoulLogo = () => (
    <div className="w-12 h-12 bg-yellow-500 rounded-lg flex items-center justify-center text-white font-bold text-xl">
      O
    </div>
  );

  const navigateToCollection = () => {
    console.log('🔄 Navigating to collection section');
    navigate('/collection');
  };

  const Sidebar = () => (
    <div className={`fixed ${language === 'ar' ? 'right-0' : 'left-0'} top-0 h-full bg-gradient-to-b from-gray-800 to-gray-700 text-white transition-all duration-300 z-40 ${
      sidebarOpen ? 'w-64' : 'w-20'
    }`}>
      <div className="p-6">
        <div className="flex items-center justify-between mb-8">
          <div className={`flex items-center ${sidebarOpen ? '' : 'justify-center'}`}>
            <OsoulLogo />
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
            { id: 'portfolio', icon: DollarSign, label: t.portfolio },
            { id: 'compliance', icon: Award, label: t.compliance },
            { id: 'customers', icon: Users, label: t.customers },
            { id: 'operations', icon: Clock, label: t.operations },
            { id: 'reports', icon: FileText, label: t.reports },
            { id: 'collection', icon: DollarSign, label: t.collection || 'Collection', onClick: navigateToCollection }
          ].map(item => (
            <button
              key={item.id}
              onClick={() => item.onClick ? item.onClick() : setActiveTab(item.id)}
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
                <OsoulLogo />
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

          {/* Other tabs content remains the same */}
        </main>
      </div>
      
      {/* Debug Panel */}
      <AuthDebug />
    </div>
  );
};

const App = () => {
  return <OsoulReportingSystem />;
};

export default App;