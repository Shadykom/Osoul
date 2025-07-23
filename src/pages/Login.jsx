import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { createClient } from '@supabase/supabase-js';

// Direct Supabase configuration
const supabaseUrl = 'https://mrecphuxcweignmdytal.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yZWNwaHV4Y3dlaWdubWR5dGFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxNjY2MjMsImV4cCI6MjA2ODc0MjYyM30.4I-S7pvJT4py5Ui5cJL08euMdoTWd3YxDF_-IJYqHeY';

// Create Supabase client
const supabase = createClient(supabaseUrl, supabaseAnonKey);

export default function FreshLogin() {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [message, setMessage] = useState('');
  const [messageType, setMessageType] = useState(''); // 'success' or 'error'

  // Show message to user
  const showMessage = (text, type = 'error') => {
    setMessage(text);
    setMessageType(type);
    setTimeout(() => {
      setMessage('');
      setMessageType('');
    }, 5000);
  };

  // Create user in Supabase Auth
  const createUser = async (email, password, userData) => {
    try {
      console.log('📝 Creating user in Supabase Auth:', email);
      
      // Sign up user in Supabase Auth
      const { data: authData, error: authError } = await supabase.auth.signUp({
        email: email,
        password: password,
        options: {
          data: userData
        }
      });

      if (authError) {
        console.error('❌ Auth signup error:', authError);
        return { success: false, error: authError.message };
      }

      console.log('✅ User created in Auth:', authData);

      // Create user profile in users table
      if (authData.user) {
        const { data: profileData, error: profileError } = await supabase
          .from('users')
          .insert([
            {
              id: authData.user.id,
              email: email,
              role: userData.role || 'viewer',
              first_name: userData.first_name || email.split('@')[0],
              last_name: userData.last_name || '',
              created_at: new Date().toISOString(),
              updated_at: new Date().toISOString(),
            }
          ])
          .select()
          .single();

        if (profileError) {
          console.error('❌ Profile creation error:', profileError);
          // Auth user created but profile failed - that's ok, we can handle this
        } else {
          console.log('✅ User profile created:', profileData);
        }
      }

      return { success: true, user: authData.user };
    } catch (error) {
      console.error('❌ Create user error:', error);
      return { success: false, error: error.message };
    }
  };

  // Create all demo users
  const createDemoUsers = async () => {
    setIsLoading(true);
    showMessage('Creating demo users...', 'success');

    const demoUsers = [
      {
        email: 'admin@osoul.com',
        password: 'password123',
        role: 'admin',
        first_name: 'Admin',
        last_name: 'User'
      },
      {
        email: 'manager@osoul.com',
        password: 'password123',
        role: 'manager',
        first_name: 'Manager',
        last_name: 'User'
      },
      {
        email: 'collector1@osoul.com',
        password: 'password123',
        role: 'collector',
        first_name: 'Collector',
        last_name: 'One'
      },
      {
        email: 'viewer@osoul.com',
        password: 'password123',
        role: 'viewer',
        first_name: 'Viewer',
        last_name: 'User'
      }
    ];

    let successCount = 0;
    let errors = [];

    for (const user of demoUsers) {
      const result = await createUser(user.email, user.password, {
        role: user.role,
        first_name: user.first_name,
        last_name: user.last_name
      });

      if (result.success) {
        successCount++;
        console.log(`✅ Created user: ${user.email}`);
      } else {
        errors.push(`${user.email}: ${result.error}`);
        console.log(`❌ Failed to create user: ${user.email} - ${result.error}`);
      }
    }

    setIsLoading(false);
    
    if (successCount > 0) {
      showMessage(`✅ Created ${successCount} demo users successfully! You can now login.`, 'success');
    } else {
      showMessage(`❌ Failed to create users: ${errors.join(', ')}`, 'error');
    }
  };

  // Login user
  const handleLogin = async (e) => {
    e.preventDefault();
    
    if (!email || !password) {
      showMessage('Please enter both email and password');
      return;
    }

    setIsLoading(true);
    console.log('🔐 Attempting login:', email);

    try {
      // Sign in with Supabase
      const { data, error } = await supabase.auth.signInWithPassword({
        email: email,
        password: password,
      });

      if (error) {
        console.error('❌ Login error:', error);
        
        if (error.message.includes('Invalid login credentials')) {
          showMessage('❌ User not found. Please create demo users first or check your credentials.');
        } else {
          showMessage(`❌ Login failed: ${error.message}`);
        }
        return;
      }

      console.log('✅ Login successful:', data);
      showMessage('✅ Login successful! Redirecting...', 'success');
      
      // Redirect to dashboard after short delay
      setTimeout(() => {
        navigate('/dashboard');
      }, 1000);

    } catch (error) {
      console.error('❌ Login error:', error);
      showMessage(`❌ Login error: ${error.message}`);
    } finally {
      setIsLoading(false);
    }
  };

  // Test Supabase connection
  const testConnection = async () => {
    setIsLoading(true);
    showMessage('Testing Supabase connection...', 'success');

    try {
      // Test basic connection
      const { data, error } = await supabase
        .from('users')
        .select('count(*)')
        .limit(1);

      if (error) {
        console.error('❌ Connection test failed:', error);
        showMessage(`❌ Connection failed: ${error.message}`);
      } else {
        console.log('✅ Connection test successful:', data);
        showMessage('✅ Supabase connection successful!', 'success');
      }
    } catch (error) {
      console.error('❌ Connection test error:', error);
      showMessage(`❌ Connection error: ${error.message}`);
    } finally {
      setIsLoading(false);
    }
  };

  // Fill demo credentials
  const fillDemo = (demoEmail, demoPassword) => {
    setEmail(demoEmail);
    setPassword(demoPassword);
  };

  return (
    <div style={{ 
      minHeight: '100vh', 
      background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      padding: '20px'
    }}>
      <div style={{
        backgroundColor: 'white',
        borderRadius: '20px',
        boxShadow: '0 20px 40px rgba(0,0,0,0.1)',
        padding: '40px',
        width: '100%',
        maxWidth: '500px'
      }}>
        {/* Header */}
        <div style={{ textAlign: 'center', marginBottom: '30px' }}>
          <h1 style={{ 
            fontSize: '32px', 
            fontWeight: 'bold', 
            color: '#333',
            marginBottom: '10px'
          }}>
            الأصول الحديثة للتمويل
          </h1>
          <p style={{ color: '#666', fontSize: '16px' }}>
            Osoul Collection System - Fresh Login
          </p>
        </div>

        {/* Message Display */}
        {message && (
          <div style={{
            padding: '15px',
            borderRadius: '10px',
            marginBottom: '20px',
            backgroundColor: messageType === 'success' ? '#d4edda' : '#f8d7da',
            color: messageType === 'success' ? '#155724' : '#721c24',
            border: `1px solid ${messageType === 'success' ? '#c3e6cb' : '#f5c6cb'}`
          }}>
            {message}
          </div>
        )}

        {/* Login Form */}
        <form onSubmit={handleLogin} style={{ marginBottom: '30px' }}>
          <div style={{ marginBottom: '20px' }}>
            <label style={{ 
              display: 'block', 
              marginBottom: '8px', 
              fontWeight: '500',
              color: '#333'
            }}>
              Email
            </label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="admin@osoul.com"
              disabled={isLoading}
              style={{
                width: '100%',
                padding: '12px 16px',
                border: '2px solid #e1e5e9',
                borderRadius: '10px',
                fontSize: '16px',
                outline: 'none',
                transition: 'border-color 0.3s',
                boxSizing: 'border-box'
              }}
              onFocus={(e) => e.target.style.borderColor = '#667eea'}
              onBlur={(e) => e.target.style.borderColor = '#e1e5e9'}
            />
          </div>

          <div style={{ marginBottom: '20px' }}>
            <label style={{ 
              display: 'block', 
              marginBottom: '8px', 
              fontWeight: '500',
              color: '#333'
            }}>
              Password
            </label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="password123"
              disabled={isLoading}
              style={{
                width: '100%',
                padding: '12px 16px',
                border: '2px solid #e1e5e9',
                borderRadius: '10px',
                fontSize: '16px',
                outline: 'none',
                transition: 'border-color 0.3s',
                boxSizing: 'border-box'
              }}
              onFocus={(e) => e.target.style.borderColor = '#667eea'}
              onBlur={(e) => e.target.style.borderColor = '#e1e5e9'}
            />
          </div>

          <button
            type="submit"
            disabled={isLoading}
            style={{
              width: '100%',
              padding: '14px',
              backgroundColor: isLoading ? '#ccc' : '#667eea',
              color: 'white',
              border: 'none',
              borderRadius: '10px',
              fontSize: '16px',
              fontWeight: '600',
              cursor: isLoading ? 'not-allowed' : 'pointer',
              transition: 'background-color 0.3s'
            }}
            onMouseOver={(e) => {
              if (!isLoading) e.target.style.backgroundColor = '#5a6fd8';
            }}
            onMouseOut={(e) => {
              if (!isLoading) e.target.style.backgroundColor = '#667eea';
            }}
          >
            {isLoading ? '⏳ Loading...' : '🔐 Sign In'}
          </button>
        </form>

        {/* Demo Credentials */}
        <div style={{ 
          borderTop: '1px solid #eee', 
          paddingTop: '20px',
          marginBottom: '20px'
        }}>
          <h3 style={{ 
            fontSize: '16px', 
            fontWeight: '600', 
            marginBottom: '15px',
            color: '#333',
            textAlign: 'center'
          }}>
            Demo Credentials
          </h3>
          <div style={{ display: 'grid', gap: '10px' }}>
            {[
              { role: 'Admin', email: 'admin@osoul.com', password: 'password123' },
              { role: 'Manager', email: 'manager@osoul.com', password: 'password123' },
              { role: 'Collector', email: 'collector1@osoul.com', password: 'password123' },
              { role: 'Viewer', email: 'viewer@osoul.com', password: 'password123' }
            ].map((cred, index) => (
              <div key={index} style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                padding: '10px',
                backgroundColor: '#f8f9fa',
                borderRadius: '8px',
                fontSize: '14px'
              }}>
                <span>
                  <strong>{cred.role}:</strong> {cred.email}
                </span>
                <button
                  type="button"
                  onClick={() => fillDemo(cred.email, cred.password)}
                  disabled={isLoading}
                  style={{
                    padding: '6px 12px',
                    backgroundColor: '#28a745',
                    color: 'white',
                    border: 'none',
                    borderRadius: '6px',
                    fontSize: '12px',
                    cursor: isLoading ? 'not-allowed' : 'pointer'
                  }}
                >
                  Fill
                </button>
              </div>
            ))}
          </div>
        </div>

        {/* Action Buttons */}
        <div style={{ display: 'grid', gap: '10px' }}>
          <button
            type="button"
            onClick={createDemoUsers}
            disabled={isLoading}
            style={{
              width: '100%',
              padding: '12px',
              backgroundColor: isLoading ? '#ccc' : '#28a745',
              color: 'white',
              border: 'none',
              borderRadius: '8px',
              fontSize: '14px',
              fontWeight: '600',
              cursor: isLoading ? 'not-allowed' : 'pointer'
            }}
          >
            {isLoading ? '⏳ Creating...' : '👥 Create Demo Users'}
          </button>

          <button
            type="button"
            onClick={testConnection}
            disabled={isLoading}
            style={{
              width: '100%',
              padding: '12px',
              backgroundColor: isLoading ? '#ccc' : '#17a2b8',
              color: 'white',
              border: 'none',
              borderRadius: '8px',
              fontSize: '14px',
              fontWeight: '600',
              cursor: isLoading ? 'not-allowed' : 'pointer'
            }}
          >
            {isLoading ? '⏳ Testing...' : '🔍 Test Connection'}
          </button>
        </div>

        {/* Instructions */}
        <div style={{
          marginTop: '20px',
          padding: '15px',
          backgroundColor: '#e7f3ff',
          borderRadius: '8px',
          fontSize: '14px',
          color: '#0c5460'
        }}>
          <strong>Instructions:</strong>
          <br />
          1. Click "Create Demo Users" to set up test accounts
          <br />
          2. Use "Fill" buttons to auto-fill credentials
          <br />
          3. Click "Sign In" to login
        </div>
      </div>
    </div>
  );
}

