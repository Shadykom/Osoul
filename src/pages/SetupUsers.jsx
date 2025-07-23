import React, { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
import { Loader2, CheckCircle, XCircle, AlertCircle } from 'lucide-react';
import { setupDemoUsers, testDemoUsersLogin } from '@/utils/setupSupabaseUsers';

const SetupUsers = () => {
  const [isSettingUp, setIsSettingUp] = useState(false);
  const [isTesting, setIsTesting] = useState(false);
  const [setupResults, setSetupResults] = useState(null);
  const [testResults, setTestResults] = useState(null);

  const handleSetupUsers = async () => {
    setIsSettingUp(true);
    setSetupResults(null);
    setTestResults(null);
    
    try {
      const results = await setupDemoUsers();
      setSetupResults(results);
    } catch (error) {
      console.error('Setup error:', error);
      setSetupResults([{ email: 'General', success: false, error: error.message }]);
    } finally {
      setIsSettingUp(false);
    }
  };

  const handleTestLogin = async () => {
    setIsTesting(true);
    setTestResults(null);
    
    try {
      const results = await testDemoUsersLogin();
      setTestResults(results);
    } catch (error) {
      console.error('Test error:', error);
      setTestResults([{ email: 'General', success: false, error: error.message }]);
    } finally {
      setIsTesting(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-4xl mx-auto space-y-6">
        <Card>
          <CardHeader>
            <CardTitle>Setup Demo Users</CardTitle>
            <CardDescription>
              Initialize demo users for the Osoul Collection System
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <Alert>
              <AlertCircle className="h-4 w-4" />
              <AlertTitle>Important</AlertTitle>
              <AlertDescription>
                This will create the following demo users with password "password123":
                <ul className="list-disc list-inside mt-2">
                  <li>admin@osoul.com (Admin)</li>
                  <li>manager@osoul.com (Manager)</li>
                  <li>collector1@osoul.com (Collector)</li>
                  <li>viewer@osoul.com (Viewer)</li>
                </ul>
              </AlertDescription>
            </Alert>

            <div className="flex gap-4">
              <Button 
                onClick={handleSetupUsers} 
                disabled={isSettingUp || isTesting}
                className="flex items-center gap-2"
              >
                {isSettingUp ? (
                  <>
                    <Loader2 className="h-4 w-4 animate-spin" />
                    Setting up users...
                  </>
                ) : (
                  'Setup Demo Users'
                )}
              </Button>

              <Button 
                onClick={handleTestLogin} 
                disabled={isSettingUp || isTesting}
                variant="secondary"
                className="flex items-center gap-2"
              >
                {isTesting ? (
                  <>
                    <Loader2 className="h-4 w-4 animate-spin" />
                    Testing logins...
                  </>
                ) : (
                  'Test All Logins'
                )}
              </Button>
            </div>

            {/* Setup Results */}
            {setupResults && (
              <div className="mt-6 space-y-2">
                <h3 className="font-semibold">Setup Results:</h3>
                {setupResults.map((result, index) => (
                  <div key={index} className="flex items-center gap-2 p-2 rounded bg-gray-100">
                    {result.success ? (
                      <CheckCircle className="h-4 w-4 text-green-600" />
                    ) : (
                      <XCircle className="h-4 w-4 text-red-600" />
                    )}
                    <span className="font-medium">{result.email}:</span>
                    <span className="text-sm text-gray-600">
                      {result.success ? result.message : (result.error || result.message)}
                    </span>
                    {result.needsPasswordReset && (
                      <span className="text-sm text-orange-600 ml-2">
                        (Password reset may be needed)
                      </span>
                    )}
                  </div>
                ))}
              </div>
            )}

            {/* Test Results */}
            {testResults && (
              <div className="mt-6 space-y-2">
                <h3 className="font-semibold">Login Test Results:</h3>
                {testResults.map((result, index) => (
                  <div key={index} className="flex items-center gap-2 p-2 rounded bg-gray-100">
                    {result.success ? (
                      <CheckCircle className="h-4 w-4 text-green-600" />
                    ) : (
                      <XCircle className="h-4 w-4 text-red-600" />
                    )}
                    <span className="font-medium">{result.email}:</span>
                    {result.success ? (
                      <span className="text-sm text-gray-600">
                        Can login • Profile: {result.hasProfile ? '✓' : '✗'} • Role: {result.role || 'N/A'}
                      </span>
                    ) : (
                      <span className="text-sm text-red-600">{result.error}</span>
                    )}
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Troubleshooting</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h4 className="font-semibold mb-2">Common Issues:</h4>
              <ul className="list-disc list-inside space-y-1 text-sm text-gray-600">
                <li>If users already exist but passwords don't work, they may need to be recreated</li>
                <li>Check Supabase Dashboard → Authentication → Users to see existing users</li>
                <li>Ensure your Supabase project allows new user signups</li>
                <li>Check that email confirmations are disabled for testing</li>
              </ul>
            </div>
            
            <div>
              <h4 className="font-semibold mb-2">Manual Setup (Supabase Dashboard):</h4>
              <ol className="list-decimal list-inside space-y-1 text-sm text-gray-600">
                <li>Go to your Supabase Dashboard</li>
                <li>Navigate to Authentication → Users</li>
                <li>Click "Invite user" or "Create user"</li>
                <li>Enter email and password (password123)</li>
                <li>Make sure to confirm the email</li>
                <li>The user profile will be created automatically on first login</li>
              </ol>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default SetupUsers;