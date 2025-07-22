import React from 'react';
import { Outlet, useNavigate, useLocation } from 'react-router-dom';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { 
  LayoutDashboard, FileText, BarChart3, Users, 
  Briefcase, Scale, Settings
} from 'lucide-react';

const CollectionLayout = () => {
  const navigate = useNavigate();
  const location = useLocation();
  
  // Extract the current tab from the pathname
  const currentPath = location.pathname.split('/').pop();
  const currentTab = currentPath === 'collection' ? 'dashboard' : currentPath;

  const tabs = [
    { id: 'dashboard', label: 'Dashboard', icon: LayoutDashboard, path: '/collection/dashboard' },
    { id: 'reports', label: 'Reports', icon: FileText, path: '/collection/reports' },
    { id: 'analytics', label: 'Analytics', icon: BarChart3, path: '/collection/analytics' },
    { id: 'accounts', label: 'Accounts', icon: Users, path: '/collection/accounts' },
    { id: 'activities', label: 'Activities', icon: Briefcase, path: '/collection/activities' },
    { id: 'legal', label: 'Legal Cases', icon: Scale, path: '/collection/legal' },
    { id: 'settings', label: 'Settings', icon: Settings, path: '/collection/settings' }
  ];

  const handleTabChange = (value) => {
    const tab = tabs.find(t => t.id === value);
    if (tab) {
      navigate(tab.path);
    }
  };

  return (
    <div className="h-full flex flex-col">
      {/* Header */}
      <div className="border-b bg-white">
        <div className="px-6 py-4">
          <h1 className="text-2xl font-bold">Collection Management System</h1>
          <p className="text-gray-600 text-sm mt-1">
            Comprehensive collection tracking and management platform
          </p>
        </div>
        
        {/* Navigation Tabs */}
        <div className="px-6">
          <Tabs value={currentTab} onValueChange={handleTabChange}>
            <TabsList className="grid w-full grid-cols-7 h-auto p-0 bg-transparent">
              {tabs.map((tab) => {
                const Icon = tab.icon;
                return (
                  <TabsTrigger 
                    key={tab.id} 
                    value={tab.id}
                    className="flex flex-col gap-1 h-auto py-3 px-4 rounded-none border-b-2 border-transparent data-[state=active]:border-primary data-[state=active]:bg-transparent"
                  >
                    <Icon className="h-5 w-5" />
                    <span className="text-xs">{tab.label}</span>
                  </TabsTrigger>
                );
              })}
            </TabsList>
          </Tabs>
        </div>
      </div>

      {/* Content */}
      <div className="flex-1 overflow-auto bg-gray-50">
        <Outlet />
      </div>
    </div>
  );
};

export default CollectionLayout;