// src/AppRouter.jsx
import React, { useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import ProtectedRoute from './components/Layout/ProtectedRoute';
import MainLayout from './components/Layout/MainLayout';
import App from './App';

// Collection pages
import CollectionLayout from './pages/Collection';
import CollectionDashboard from './pages/Collection/CollectionDashboard';
import CollectionReports from './pages/Collection/CollectionReports';
import CollectionAnalytics from './pages/Collection/CollectionAnalytics';

// Placeholder components
const ComingSoon = ({ title }) => (
  <div className="flex items-center justify-center h-full">
    <div className="text-center">
      <h2 className="text-2xl font-bold text-gray-800 mb-4">{title}</h2>
      <p className="text-gray-600">This feature is coming soon!</p>
    </div>
  </div>
);

// Test component
const TestPage = () => (
  <div className="min-h-screen flex items-center justify-center bg-gray-50">
    <div className="text-center">
      <h1 className="text-4xl font-bold text-gray-800 mb-4">Test Page</h1>
      <p className="text-gray-600">If you can see this, routing is working!</p>
      <button 
        onClick={() => window.location.href = '/dashboard'}
        className="mt-4 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
      >
        Go to Dashboard
      </button>
    </div>
  </div>
);

const AppRouter = () => {
  return (
    <Router>
      <Routes>
        {/* Test route */}
        <Route path="/test" element={<TestPage />} />
        
        {/* Public routes */}
        <Route path="/login" element={<Login />} />
        
        {/* Protected routes */}
        <Route element={<ProtectedRoute />}>
          <Route element={<MainLayout />}>
            {/* Dashboard */}
            <Route path="/dashboard" element={<App />} />
            
            {/* Collection routes */}
            <Route path="/collection" element={<CollectionLayout />}>
              <Route index element={<Navigate to="/collection/dashboard" replace />} />
              <Route path="dashboard" element={<CollectionDashboard />} />
              <Route path="reports" element={<CollectionReports />} />
              <Route path="analytics" element={<CollectionAnalytics />} />
              <Route path="accounts" element={<ComingSoon title="Collection Accounts" />} />
              <Route path="activities" element={<ComingSoon title="Collection Activities" />} />
              <Route path="legal" element={<ComingSoon title="Legal Cases" />} />
              <Route path="settings" element={<ComingSoon title="Collection Settings" />} />
            </Route>
            
            {/* Other routes */}
            <Route path="/reports" element={<ComingSoon title="Reports" />} />
            <Route path="/analytics" element={<ComingSoon title="Analytics" />} />
            <Route path="/settings" element={<ComingSoon title="Settings" />} />
          </Route>
        </Route>
        
        {/* Default redirect */}
        <Route path="/" element={<Navigate to="/dashboard" replace />} />
      </Routes>
    </Router>
  );
};

export default AppRouter;