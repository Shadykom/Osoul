import React, { useEffect } from 'react';
import { Navigate, useLocation, Outlet } from 'react-router-dom';
import useAuthStore from '../../stores/authStore';
import { Loader2 } from 'lucide-react';

export default function ProtectedRoute({ children, roles = [] }) {
  const location = useLocation();
  const { isAuthenticated, user, checkAuth, hasAnyRole } = useAuthStore();
  const [isChecking, setIsChecking] = React.useState(true);
  const [isHydrated, setIsHydrated] = React.useState(false);

  // Check if store is hydrated
  useEffect(() => {
    const timeout = setTimeout(() => {
      setIsHydrated(true);
    }, 100); // Allow time for store hydration
    
    return () => clearTimeout(timeout);
  }, []);

  useEffect(() => {
    if (!isHydrated) return;
    
    const verifyAuth = async () => {
      console.log('ProtectedRoute: Starting auth check');
      const authResult = await checkAuth();
      console.log('ProtectedRoute: Auth check complete, result:', authResult);
      setIsChecking(false);
    };
    verifyAuth();
  }, [checkAuth, isHydrated]);

  console.log('ProtectedRoute render:', { isChecking, isAuthenticated, isHydrated, location: location.pathname });

  if (!isHydrated || isChecking) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!isAuthenticated) {
    console.log('ProtectedRoute: Not authenticated, redirecting to login');
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  if (roles.length > 0 && !hasAnyRole(...roles)) {
    return <Navigate to="/unauthorized" replace />;
  }

  console.log('ProtectedRoute: Rendering outlet');
  return <Outlet />;
}