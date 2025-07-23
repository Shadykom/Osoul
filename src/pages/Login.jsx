import React, { useState, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { toast } from 'sonner';
import { Loader2, LogIn } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { useAuthStore } from '@/stores/authStore';
import osoulLogo from '@/assets/osoul-logo.png';

// Import Supabase authentication service
import { supabaseAuth } from '@/services/supabaseAuth';

export default function Login() {
  const navigate = useNavigate();
  const [isLoading, setIsLoading] = useState(false);
  const [formData, setFormData] = useState({
    email: '',
    password: ''
  });
  const [errors, setErrors] = useState({});
  
  const login = useAuthStore((state) => state.login);

  // Simple validation function
  const validateForm = () => {
    const newErrors = {};
    
    // Email validation
    if (!formData.email.trim()) {
      newErrors.email = 'Email is required';
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email)) {
      newErrors.email = 'Please enter a valid email address';
    }
    
    // Password validation
    if (!formData.password.trim()) {
      newErrors.password = 'Password is required';
    } else if (formData.password.length < 6) {
      newErrors.password = 'Password must be at least 6 characters';
    }
    
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  // Handle input changes
  const handleInputChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
    
    // Clear error when user starts typing
    if (errors[field]) {
      setErrors(prev => ({
        ...prev,
        [field]: ''
      }));
    }
  };

  // Handle form submission
  const handleSubmit = useCallback(async (e) => {
    e.preventDefault();
    
    console.log('🔐 Login form submitted with:', { email: formData.email });
    
    // Validate form
    if (!validateForm()) {
      console.log('❌ Form validation failed:', errors);
      return;
    }
    
    setIsLoading(true);

    try {
      console.log('🔍 Calling Supabase authentication...');
      
      // Use Supabase authentication directly
      const result = await supabaseAuth.login(formData.email, formData.password);
      
      console.log('✅ Supabase login result:', result);

      if (result.success) {
        console.log('✅ Login successful, showing toast...');
        toast.success('تم تسجيل الدخول بنجاح', {
          description: 'مرحباً بك',
        });
        
        console.log('🔄 Navigating to dashboard...');
        navigate('/dashboard');
      } else {
        throw new Error(result.error || 'Login failed');
      }
    } catch (error) {
      console.error('❌ Login error:', error);
      toast.error('خطأ في تسجيل الدخول', {
        description: error.message || 'يرجى التحقق من البيانات والمحاولة مرة أخرى',
      });
    } finally {
      setIsLoading(false);
    }
  }, [formData, login, navigate]);

  // Demo credentials for easy testing
  const demoCredentials = [
    { role: 'Admin', email: 'admin@osoul.com', password: 'password123' },
    { role: 'Manager', email: 'manager@osoul.com', password: 'password123' },
    { role: 'Collector', email: 'collector1@osoul.com', password: 'password123' },
    { role: 'Viewer', email: 'viewer@osoul.com', password: 'password123' },
  ];

  // Helper function to fill demo credentials
  const fillDemoCredentials = (email, password) => {
    setFormData({ email, password });
    setErrors({});
  };

  // Test function to bypass form validation
  const testLogin = async () => {
    console.log('🧪 Test login clicked');
    setIsLoading(true);
    try {
      console.log('🔍 Testing Supabase connection...');
      const result = await supabaseAuth.login('admin@osoul.com', 'password123');
      console.log('✅ Test login result:', result);
      
      if (result.success) {
        toast.success('Test login successful!');
        navigate('/dashboard');
      } else {
        toast.error('Test login failed: ' + (result.error || 'Unknown error'));
      }
    } catch (error) {
      console.error('❌ Test login error:', error);
      toast.error('Test login error: ' + error.message);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        <div className="bg-white rounded-2xl shadow-xl p-8 space-y-6">
          {/* Header */}
          <div className="text-center space-y-4">
            <div className="flex justify-center">
              <img
                src={osoulLogo}
                alt="Osoul Logo"
                className="h-16 w-auto"
              />
            </div>
            <div>
              <h1 className="text-3xl font-bold text-gray-900">الأصول</h1>
              <h2 className="text-xl text-gray-600">الحديثة للتمويل</h2>
            </div>
            <div className="text-sm text-gray-500">
              <p>Sign in to your account</p>
              <p>Enter your email and password to access the collection reporting system</p>
            </div>
          </div>

          {/* Login Form */}
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <Label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-1">
                Email
              </Label>
              <Input
                id="email"
                type="email"
                placeholder="admin@osoul.com"
                value={formData.email}
                onChange={(e) => handleInputChange('email', e.target.value)}
                className={`w-full ${errors.email ? 'border-red-500 focus:border-red-500' : ''}`}
                disabled={isLoading}
              />
              {errors.email && (
                <p className="mt-1 text-sm text-red-600">{errors.email}</p>
              )}
            </div>

            <div>
              <Label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-1">
                Password
              </Label>
              <Input
                id="password"
                type="password"
                placeholder="••••••••"
                value={formData.password}
                onChange={(e) => handleInputChange('password', e.target.value)}
                className={`w-full ${errors.password ? 'border-red-500 focus:border-red-500' : ''}`}
                disabled={isLoading}
              />
              {errors.password && (
                <p className="mt-1 text-sm text-red-600">{errors.password}</p>
              )}
            </div>

            <Button
              type="submit"
              className="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 rounded-lg font-medium transition-colors"
              disabled={isLoading}
            >
              {isLoading ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Signing in...
                </>
              ) : (
                <>
                  <LogIn className="mr-2 h-4 w-4" />
                  تسجيل الدخول - Sign in
                </>
              )}
            </Button>
          </form>

          {/* Demo Credentials */}
          <div className="border-t pt-6">
            <h3 className="text-sm font-medium text-gray-700 mb-3 text-center">DEMO CREDENTIALS</h3>
            <div className="space-y-2">
              {demoCredentials.map((cred, index) => (
                <div key={index} className="flex items-center justify-between text-xs bg-gray-50 p-2 rounded">
                  <span>
                    <strong>{cred.role}:</strong> {cred.email} / {cred.password}
                  </span>
                  <Button
                    type="button"
                    variant="outline"
                    size="sm"
                    onClick={() => fillDemoCredentials(cred.email, cred.password)}
                    className="text-xs px-2 py-1"
                    disabled={isLoading}
                  >
                    Fill
                  </Button>
                </div>
              ))}
            </div>
          </div>

          {/* Test Button for Debugging */}
          <div className="border-t pt-4">
            <Button
              type="button"
              variant="secondary"
              onClick={testLogin}
              disabled={isLoading}
              className="w-full"
            >
              🧪 Test Supabase Login
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}

