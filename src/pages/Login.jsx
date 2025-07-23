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
import useAuthStore from '@/stores/authStore';
import osoulLogo from '@/assets/osoul-logo.png';

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
    formState: { errors },
    setValue,
    clearErrors,
  } = useForm({
    resolver: zodResolver(loginSchema),
    mode: 'onBlur',
    reValidateMode: 'onChange',
  });

  const onSubmit = useCallback(async (data) => {
    console.log('Login form submitted with:', data);
    setIsLoading(true);
    
    try {
      console.log('Calling login function...');
      const result = await login(data.email, data.password);
      console.log('Login result:', result);
      
      if (result.success) {
        console.log('Login successful, showing toast...');
        toast.success('تم تسجيل الدخول بنجاح', {
          description: `مرحباً بك`,
        });
        console.log('Navigating to dashboard...');
        navigate('/dashboard');
      } else {
        throw new Error(result.error || 'Login failed');
      }
    } catch (error) {
      console.error('Login error:', error);
      toast.error('خطأ في تسجيل الدخول', {
        description: error.message || 'يرجى التحقق من البيانات والمحاولة مرة أخرى',
      });
    } finally {
      setIsLoading(false);
    }
  }, [login, navigate]);

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
    console.log('Test login clicked');
    setIsLoading(true);
    try {
      const result = await login('admin@osoul.com', 'password123');
      console.log('Test login result:', result);
      if (result.success) {
        toast.success('Test login successful!');
        navigate('/dashboard');
      } else {
        toast.error('Test login failed: ' + (result.error || 'Unknown error'));
      }
    } catch (error) {
      console.error('Test login error:', error);
      toast.error('Test login error: ' + error.message);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="login-container">
      <div className="login-card animate-fadeIn">
        {/* Header */}
        <div className="login-header">
          <img 
            src={osoulLogo} 
            alt="Osoul Logo" 
            className="login-logo"
            onError={(e) => {
              e.target.style.display = 'none';
            }}
          />
          <div>
            <h1 className="login-title">الأصول</h1>
            <p className="login-title arabic-text text-osoul-accent">الحديثة للتمويل</p>
          </div>
          <div>
            <h2 className="text-lg font-semibold text-slate-800 dark:text-slate-200">
              Sign in to your account
            </h2>
            <p className="login-subtitle">
              Enter your email and password to access the collection reporting system
            </p>
          </div>
        </div>

        {/* Login Form */}
        <form onSubmit={handleSubmit(onSubmit)} className="login-form" noValidate>
          <div className="form-group">
            <Label htmlFor="email" className="form-label">
              Email
            </Label>
            <Input
              id="email"
              type="email"
              placeholder="admin@osoul.com"
              className="form-input"
              {...register('email')}
              disabled={isLoading}
              autoComplete="email"
              aria-invalid={!!errors.email}
              aria-describedby={errors.email ? "email-error" : undefined}
            />
            {errors.email && (
              <p id="email-error" className="error-message">{errors.email.message}</p>
            )}
          </div>

          <div className="form-group">
            <Label htmlFor="password" className="form-label">
              Password
            </Label>
            <Input
              id="password"
              type="password"
              placeholder="••••••••"
              className="form-input"
              {...register('password')}
              disabled={isLoading}
              autoComplete="current-password"
              aria-invalid={!!errors.password}
              aria-describedby={errors.password ? "password-error" : undefined}
            />
            {errors.password && (
              <p id="password-error" className="error-message">{errors.password.message}</p>
            )}
          </div>

          <Button
            type="submit"
            className="login-button"
            disabled={isLoading}
          >
            {isLoading ? (
              <>
                <Loader2 className="loading-spinner mr-2" />
                Signing in...
              </>
            ) : (
              <>
                <LogIn className="w-4 h-4 mr-2" />
                Sign in
              </>
            )}
          </Button>
          
          {/* Test button to verify click events */}
          <Button
            type="button"
            onClick={testLogin}
            className="mt-2 w-full"
            variant="outline"
            disabled={isLoading}
          >
            Test Direct Login (admin@osoul.com)
          </Button>
        </form>

        {/* Demo Credentials */}
        <div className="demo-credentials">
          <h3 className="demo-title">DEMO CREDENTIALS</h3>
          <div className="demo-list">
            {demoCredentials.map((cred, index) => (
              <div 
                key={index} 
                className="demo-item cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-800 p-1 rounded transition-colors"
                onClick={() => fillDemoCredentials(cred.email, cred.password)}
              >
                <span className="demo-role">{cred.role}:</span>
                <span className="demo-credentials-text">
                  {cred.email} / {cred.password}
                </span>
              </div>
            ))}
          </div>
        </div>

        {/* Footer */}
        <div className="text-center">
          <p className="text-xs text-slate-500 dark:text-slate-400">
            © 2024 Osoul Collection Reporting System. All rights reserved.
          </p>
        </div>
      </div>
    </div>
  );
}

