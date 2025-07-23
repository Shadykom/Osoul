import React, { useState, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';
import { toast } from 'sonner';
import { Loader2, LogIn } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { useAuthStore } from '@/stores/authStore';
import osoulLogo from '@/assets/osoul-logo.png';

// Import Supabase authentication service
import { supabaseAuth } from '@/services/supabaseAuth';

// Validation schema
const loginSchema = z.object({
  email: z.string().min(1, 'Email is required').email('Invalid email address'),
  password: z.string().min(1, 'Password is required').min(6, 'Password must be at least 6 characters'),
});

export default function Login() {
  const navigate = useNavigate();
  const [isLoading, setIsLoading] = useState(false);
  const login = useAuthStore((state) => state.login);

  const {
    register,
    handleSubmit,
    setValue,
    clearErrors,
    formState: { errors },
  } = useForm({
    resolver: zodResolver(loginSchema),
    mode: 'onBlur',
    reValidateMode: 'onChange',
  });

  const onSubmit = useCallback(async (data) => {
    console.log('🔐 Login form submitted with:', { email: data.email });
    setIsLoading(true);

    try {
      console.log('🔍 Calling Supabase authentication...');
      
      // Use Supabase authentication directly
      const result = await supabaseAuth.login(data.email, data.password);
      
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
  }, [login, navigate]);

  // Demo credentials for easy testing
  const demoCredentials = [
    { role: 'Admin', email: 'admin@osoul.com', password: 'password123' },
    { role: 'Manager', email: 'manager@osoul.com', password: 'password123' },
    { role: 'Collector', email: 'collector1@osoul.com', password: 'password123' },
    { role: 'Viewer', email: 'viewer@osoul.com', password: 'password123' },
  ];

  // Helper function to fill demo credentials
  const fillDemoCredentials = (email, password) => {
    setValue('email', email);
    setValue('password', password);
    clearErrors();
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
    <div className="login-container">
      <div className="login-card animate-fade-in">
        {/* Header */}
        <div className="login-header">
          <img
            src={osoulLogo}
            alt="Osoul Logo"
            className="login-logo"
          />
          <h1 className="login-title">الأصول</h1>
          <h2 className="login-subtitle">الحديثة للتمويل</h2>
          <p className="login-description">
            Sign in to your account<br />
            Enter your email and password to access the collection reporting system
          </p>
        </div>

        {/* Login Form */}
        <form onSubmit={handleSubmit(onSubmit)} className="login-form">
          <div className="form-group">
            <Label htmlFor="email">Email</Label>
            <Input
              id="email"
              type="email"
              placeholder="admin@osoul.com"
              {...register('email')}
              className={errors.email ? 'error' : ''}
            />
            {errors.email && (
              <span className="error-message">{errors.email.message}</span>
            )}
          </div>

          <div className="form-group">
            <Label htmlFor="password">Password</Label>
            <Input
              id="password"
              type="password"
              placeholder="••••••••"
              {...register('password')}
              className={errors.password ? 'error' : ''}
            />
            {errors.password && (
              <span className="error-message">{errors.password.message}</span>
            )}
          </div>

          <Button
            type="submit"
            className="login-button"
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
        <div className="demo-credentials">
          <h3>DEMO CREDENTIALS</h3>
          <div className="credentials-grid">
            {demoCredentials.map((cred, index) => (
              <div key={index} className="credential-item">
                <strong>{cred.role}:</strong> {cred.email} / {cred.password}
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => fillDemoCredentials(cred.email, cred.password)}
                  className="fill-button"
                >
                  Fill
                </Button>
              </div>
            ))}
          </div>
        </div>

        {/* Test Button for Debugging */}
        <div className="test-section">
          <Button
            type="button"
            variant="secondary"
            onClick={testLogin}
            disabled={isLoading}
            className="test-button"
          >
            🧪 Test Supabase Login
          </Button>
        </div>
      </div>
    </div>
  );
}

