import React, { useState } from 'react';
import { Outlet, useNavigate, useLocation } from 'react-router-dom';
import { 
  LayoutDashboard, FileText, BarChart3, Settings, 
  Users, LogOut, Menu, X, ChevronDown, Briefcase
} from 'lucide-react';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import osoulLogo from '@/assets/osoul-logo.png';
import useAuthStore from '@/stores/authStore';

const MainLayout = () => {
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const navigate = useNavigate();
  const { logout } = useAuthStore();
  const location = useLocation();

  const menuItems = [
    { 
      id: 'dashboard', 
      label: 'Dashboard', 
      icon: LayoutDashboard, 
      path: '/dashboard' 
    },
    { 
      id: 'collection', 
      label: 'Collection', 
      icon: Briefcase, 
      path: '/collection',
      subItems: [
        { label: 'Dashboard', path: '/collection/dashboard' },
        { label: 'Reports', path: '/collection/reports' },
        { label: 'Analytics', path: '/collection/analytics' },
        { label: 'Accounts', path: '/collection/accounts' },
        { label: 'Activities', path: '/collection/activities' },
        { label: 'Legal Cases', path: '/collection/legal' }
      ]
    },
    { 
      id: 'reports', 
      label: 'Reports', 
      icon: FileText, 
      path: '/reports' 
    },
    { 
      id: 'analytics', 
      label: 'Analytics', 
      icon: BarChart3, 
      path: '/analytics' 
    },
    { 
      id: 'settings', 
      label: 'Settings', 
      icon: Settings, 
      path: '/settings' 
    }
  ];

  const handleLogout = async () => {
    await logout();
    navigate('/login');
  };

  const isActive = (path) => {
    return location.pathname.startsWith(path);
  };

  const user = JSON.parse(localStorage.getItem('user') || '{}');

  return (
    <div className="flex h-screen bg-gray-50">
      {/* Sidebar */}
      <div className={`${sidebarOpen ? 'w-64' : 'w-16'} bg-white shadow-lg transition-all duration-300 flex flex-col`}>
        {/* Logo */}
        <div className="p-4 border-b">
          <div className="flex items-center justify-between">
            <div className={`flex items-center ${sidebarOpen ? '' : 'justify-center'}`}>
              <img src={osoulLogo} alt="Osoul" className="h-8 w-8" />
              {sidebarOpen && (
                <span className="ml-2 text-xl font-bold text-gray-800">Osoul</span>
              )}
            </div>
            <Button
              variant="ghost"
              size="icon"
              onClick={() => setSidebarOpen(!sidebarOpen)}
              className="ml-auto"
            >
              {sidebarOpen ? <X className="h-4 w-4" /> : <Menu className="h-4 w-4" />}
            </Button>
          </div>
        </div>

        {/* Navigation */}
        <nav className="flex-1 p-4 space-y-2">
          {menuItems.map((item) => {
            const Icon = item.icon;
            const hasSubItems = item.subItems && item.subItems.length > 0;
            const isItemActive = isActive(item.path);

            if (hasSubItems) {
              return (
                <DropdownMenu key={item.id}>
                  <DropdownMenuTrigger asChild>
                    <Button
                      variant={isItemActive ? "default" : "ghost"}
                      className={`w-full justify-start ${!sidebarOpen && 'justify-center'}`}
                    >
                      <Icon className={`h-5 w-5 ${sidebarOpen && 'mr-3'}`} />
                      {sidebarOpen && (
                        <>
                          <span className="flex-1 text-left">{item.label}</span>
                          <ChevronDown className="h-4 w-4" />
                        </>
                      )}
                    </Button>
                  </DropdownMenuTrigger>
                  {sidebarOpen && (
                    <DropdownMenuContent side="right" className="w-48">
                      {item.subItems.map((subItem, index) => (
                        <DropdownMenuItem
                          key={index}
                          onClick={() => navigate(subItem.path)}
                          className={location.pathname === subItem.path ? 'bg-gray-100' : ''}
                        >
                          {subItem.label}
                        </DropdownMenuItem>
                      ))}
                    </DropdownMenuContent>
                  )}
                </DropdownMenu>
              );
            }

            return (
              <Button
                key={item.id}
                variant={isItemActive ? "default" : "ghost"}
                className={`w-full justify-start ${!sidebarOpen && 'justify-center'}`}
                onClick={() => navigate(item.path)}
              >
                <Icon className={`h-5 w-5 ${sidebarOpen && 'mr-3'}`} />
                {sidebarOpen && <span>{item.label}</span>}
              </Button>
            );
          })}
        </nav>

        {/* User section */}
        <div className="p-4 border-t">
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant="ghost" className={`w-full justify-start ${!sidebarOpen && 'justify-center'}`}>
                <Users className={`h-5 w-5 ${sidebarOpen && 'mr-3'}`} />
                {sidebarOpen && (
                  <div className="flex-1 text-left">
                    <p className="text-sm font-medium">{user.name || 'User'}</p>
                    <p className="text-xs text-gray-500">{user.role || 'Role'}</p>
                  </div>
                )}
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent side="right" align="end" className="w-48">
              <DropdownMenuLabel>My Account</DropdownMenuLabel>
              <DropdownMenuSeparator />
              <DropdownMenuItem onClick={() => navigate('/profile')}>
                Profile
              </DropdownMenuItem>
              <DropdownMenuItem onClick={() => navigate('/settings')}>
                Settings
              </DropdownMenuItem>
              <DropdownMenuSeparator />
              <DropdownMenuItem onClick={handleLogout} className="text-red-600">
                <LogOut className="mr-2 h-4 w-4" />
                Logout
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </div>
      </div>

      {/* Main content */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* Header */}
        <header className="bg-white shadow-sm border-b">
          <div className="px-6 py-4">
            <div className="flex items-center justify-between">
              <h1 className="text-2xl font-semibold text-gray-800">
                {location.pathname.includes('collection') ? 'Collection Management' : 'Osoul Reporting System'}
              </h1>
              <div className="flex items-center gap-4">
                <span className="text-sm text-gray-600">
                  {new Date().toLocaleDateString('en-US', { 
                    weekday: 'long', 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                  })}
                </span>
              </div>
            </div>
          </div>
        </header>

        {/* Page content */}
        <main className="flex-1 overflow-auto">
          <Outlet />
        </main>
      </div>
    </div>
  );
};

export default MainLayout;