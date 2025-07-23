import React, { useEffect, useState } from 'react';
import useAuthStore from '../stores/authStore';
import authService from '../services/auth.service';
import { getToken } from '../services/api';

const AuthDebug = () => {
  const { isAuthenticated, user, token, initializeAuth } = useAuthStore();
  const [debugInfo, setDebugInfo] = useState({});
  
  useEffect(() => {
    const updateDebugInfo = () => {
      setDebugInfo({
        // Zustand store state
        storeIsAuthenticated: isAuthenticated,
        storeUser: user,
        storeToken: token,
        
        // Auth service state
        serviceIsAuthenticated: authService.isAuthenticated,
        serviceUser: authService.user,
        serviceToken: authService.token,
        
        // Storage state
        localStorageToken: getToken(),
        localStorageUser: localStorage.getItem('user'),
        
        // Service methods
        isLoggedIn: authService.isLoggedIn(),
        getAuthToken: authService.getAuthToken(),
        getUser: authService.getUser(),
        
        timestamp: new Date().toLocaleTimeString()
      });
    };
    
    updateDebugInfo();
    const interval = setInterval(updateDebugInfo, 1000);
    
    return () => clearInterval(interval);
  }, [isAuthenticated, user, token]);

  const handleCheckAuth = async () => {
    console.log('🔍 Manual auth check triggered');
    const result = await initializeAuth();
    console.log('🔍 Manual auth check result:', result);
  };

  const handleClearAuth = () => {
    authService.clearAuthState();
    console.log('🗑️ Auth state cleared manually');
  };

  return (
    <div className="fixed bottom-4 right-4 w-96 bg-white border border-gray-300 rounded-lg shadow-lg p-4 text-xs max-h-96 overflow-y-auto z-50">
      <div className="flex justify-between items-center mb-2">
        <h3 className="font-bold">Auth Debug Panel</h3>
        <span className="text-gray-500">{debugInfo.timestamp}</span>
      </div>
      
      <div className="space-y-2">
        <div className="grid grid-cols-2 gap-2">
          <button 
            onClick={handleCheckAuth}
            className="px-2 py-1 bg-blue-500 text-white rounded text-xs"
          >
            Check Auth
          </button>
          <button 
            onClick={handleClearAuth}
            className="px-2 py-1 bg-red-500 text-white rounded text-xs"
          >
            Clear Auth
          </button>
        </div>
        
        <div className="border-t pt-2">
          <h4 className="font-semibold text-green-600">Zustand Store:</h4>
          <div>isAuthenticated: <span className={debugInfo.storeIsAuthenticated ? 'text-green-600' : 'text-red-600'}>{String(debugInfo.storeIsAuthenticated)}</span></div>
          <div>user: {debugInfo.storeUser?.email || 'null'}</div>
          <div>token: {debugInfo.storeToken ? 'exists' : 'null'}</div>
        </div>
        
        <div className="border-t pt-2">
          <h4 className="font-semibold text-blue-600">Auth Service:</h4>
          <div>isAuthenticated: <span className={debugInfo.serviceIsAuthenticated ? 'text-green-600' : 'text-red-600'}>{String(debugInfo.serviceIsAuthenticated)}</span></div>
          <div>user: {debugInfo.serviceUser?.email || 'null'}</div>
          <div>token: {debugInfo.serviceToken ? 'exists' : 'null'}</div>
          <div>isLoggedIn(): <span className={debugInfo.isLoggedIn ? 'text-green-600' : 'text-red-600'}>{String(debugInfo.isLoggedIn)}</span></div>
        </div>
        
        <div className="border-t pt-2">
          <h4 className="font-semibold text-purple-600">Storage:</h4>
          <div>localStorage token: {debugInfo.localStorageToken ? 'exists' : 'null'}</div>
          <div>localStorage user: {debugInfo.localStorageUser ? 'exists' : 'null'}</div>
        </div>
      </div>
    </div>
  );
};

export default AuthDebug;