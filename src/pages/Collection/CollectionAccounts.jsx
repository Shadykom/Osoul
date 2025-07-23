import React, { useState, useEffect } from 'react';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { Badge } from '@/components/ui/badge';
import { Progress } from '@/components/ui/progress';
import {
  Search,
  Filter,
  Download,
  Phone,
  Mail,
  MapPin,
  User,
  Calendar,
  DollarSign,
  AlertCircle,
  ChevronRight,
} from 'lucide-react';
import { format } from 'date-fns';
import { collectionService } from '@/services/collectionService';

const CollectionAccounts = () => {
  const [accounts, setAccounts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filters, setFilters] = useState({
    search: '',
    bucket: 'all',
    collector: 'all',
    product: 'all',
    branch: 'all',
    status: 'all',
  });
  const [selectedAccount, setSelectedAccount] = useState(null);
  const [showDetails, setShowDetails] = useState(false);

  useEffect(() => {
    fetchAccounts();
  }, [filters]);

  const fetchAccounts = async () => {
    try {
      setLoading(true);
      // This would call the actual API
      const mockData = generateMockAccounts();
      setAccounts(mockData);
    } catch (error) {
      console.error('Error fetching accounts:', error);
    } finally {
      setLoading(false);
    }
  };

  const generateMockAccounts = () => {
    return [
      {
        accountId: 'ACC001',
        customerId: 'CUST001',
        customerName: 'Ahmad Al-Rashid',
        nationalId: '1234567890',
        productType: 'Auto Finance',
        outstanding: 125000,
        dpd: 95,
        bucket: 'Bucket 4',
        collector: 'Abdulaziz Al-Rasheed',
        lastPaymentDate: '2024-09-15',
        lastContactDate: '2025-01-20',
        phoneNumber: '+966501234567',
        email: 'ahmad.rashid@email.com',
        address: 'King Fahd Road, Riyadh 12345',
        monthlyInstallment: 4687.50,
        caseStatus: 'Active',
        priority: 'High',
      },
      {
        accountId: 'ACC003',
        customerId: 'CUST003',
        customerName: 'Mohammed Al-Otaibi',
        nationalId: '3456789012',
        productType: 'Home Finance',
        outstanding: 950000,
        dpd: 120,
        bucket: 'Bucket 4',
        collector: 'Mohammed Al-Qahtani',
        lastPaymentDate: '2024-08-10',
        lastContactDate: '2025-01-18',
        phoneNumber: '+966503456789',
        email: 'mohammed.otaibi@business.com',
        address: 'Al Olaya District, Riyadh 11111',
        monthlyInstallment: 7200,
        caseStatus: 'Legal',
        priority: 'Critical',
      },
      {
        accountId: 'ACC051',
        customerId: 'CUST051',
        customerName: 'Mansour Al-Rasheed',
        nationalId: '1111111111',
        productType: 'Home Finance',
        outstanding: 2200000,
        dpd: 30,
        bucket: 'Bucket 2',
        collector: 'Fatima Al-Zahrani',
        lastPaymentDate: '2024-11-10',
        lastContactDate: '2025-01-21',
        phoneNumber: '+966541111111',
        email: 'mansour.rasheed@email.com',
        address: 'King Abdullah Road, Riyadh 54321',
        monthlyInstallment: 15000,
        caseStatus: 'Active',
        priority: 'Medium',
      },
    ];
  };

  const getBucketColor = (bucket) => {
    const colors = {
      'Bucket 1': 'bg-yellow-500',
      'Bucket 2': 'bg-orange-500',
      'Bucket 3': 'bg-red-500',
      'Bucket 4': 'bg-red-700',
      'Bucket 5': 'bg-red-900',
    };
    return colors[bucket] || 'bg-gray-500';
  };

  const getPriorityColor = (priority) => {
    const colors = {
      'Low': 'bg-green-100 text-green-800',
      'Medium': 'bg-yellow-100 text-yellow-800',
      'High': 'bg-orange-100 text-orange-800',
      'Critical': 'bg-red-100 text-red-800',
    };
    return colors[priority] || 'bg-gray-100 text-gray-800';
  };

  const getStatusColor = (status) => {
    const colors = {
      'Active': 'bg-blue-100 text-blue-800',
      'Legal': 'bg-purple-100 text-purple-800',
      'Write-off Review': 'bg-gray-100 text-gray-800',
      'Closed': 'bg-green-100 text-green-800',
    };
    return colors[status] || 'bg-gray-100 text-gray-800';
  };

  const filteredAccounts = accounts.filter(account => {
    if (filters.search && !account.customerName.toLowerCase().includes(filters.search.toLowerCase()) &&
        !account.accountId.toLowerCase().includes(filters.search.toLowerCase()) &&
        !account.nationalId.includes(filters.search)) {
      return false;
    }
    if (filters.bucket !== 'all' && account.bucket !== filters.bucket) return false;
    if (filters.product !== 'all' && account.productType !== filters.product) return false;
    if (filters.status !== 'all' && account.caseStatus !== filters.status) return false;
    return true;
  });

  const AccountDetailsModal = ({ account, onClose }) => {
    if (!account) return null;

    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
        <div className="bg-white rounded-lg max-w-4xl w-full max-h-[90vh] overflow-y-auto">
          <div className="p-6">
            <div className="flex justify-between items-start mb-6">
              <div>
                <h2 className="text-2xl font-bold">{account.customerName}</h2>
                <p className="text-gray-500">Account: {account.accountId}</p>
              </div>
              <Button variant="ghost" onClick={onClose}>✕</Button>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {/* Customer Information */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Customer Information</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="flex items-center gap-2">
                    <User className="h-4 w-4 text-gray-500" />
                    <span className="text-sm">National ID: {account.nationalId}</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Phone className="h-4 w-4 text-gray-500" />
                    <span className="text-sm">{account.phoneNumber}</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Mail className="h-4 w-4 text-gray-500" />
                    <span className="text-sm">{account.email}</span>
                  </div>
                  <div className="flex items-start gap-2">
                    <MapPin className="h-4 w-4 text-gray-500 mt-1" />
                    <span className="text-sm">{account.address}</span>
                  </div>
                </CardContent>
              </Card>

              {/* Account Details */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Account Details</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Product Type</span>
                    <span className="text-sm font-medium">{account.productType}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Outstanding</span>
                    <span className="text-sm font-medium">SAR {account.outstanding.toLocaleString()}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Monthly Installment</span>
                    <span className="text-sm font-medium">SAR {account.monthlyInstallment.toLocaleString()}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Days Past Due</span>
                    <span className="text-sm font-medium">{account.dpd} days</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Aging Bucket</span>
                    <Badge className={getBucketColor(account.bucket)}>{account.bucket}</Badge>
                  </div>
                </CardContent>
              </Card>

              {/* Collection Status */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Collection Status</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="flex justify-between items-center">
                    <span className="text-sm text-gray-500">Case Status</span>
                    <Badge className={getStatusColor(account.caseStatus)}>{account.caseStatus}</Badge>
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-sm text-gray-500">Priority</span>
                    <Badge className={getPriorityColor(account.priority)}>{account.priority}</Badge>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Assigned Collector</span>
                    <span className="text-sm font-medium">{account.collector}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Last Payment</span>
                    <span className="text-sm font-medium">{format(new Date(account.lastPaymentDate), 'dd/MM/yyyy')}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Last Contact</span>
                    <span className="text-sm font-medium">{format(new Date(account.lastContactDate), 'dd/MM/yyyy')}</span>
                  </div>
                </CardContent>
              </Card>

              {/* Quick Actions */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Quick Actions</CardTitle>
                </CardHeader>
                <CardContent className="space-y-2">
                  <Button className="w-full justify-start" variant="outline">
                    <Phone className="h-4 w-4 mr-2" />
                    Call Customer
                  </Button>
                  <Button className="w-full justify-start" variant="outline">
                    <Mail className="h-4 w-4 mr-2" />
                    Send Email
                  </Button>
                  <Button className="w-full justify-start" variant="outline">
                    <Calendar className="h-4 w-4 mr-2" />
                    Schedule Visit
                  </Button>
                  <Button className="w-full justify-start" variant="outline">
                    <DollarSign className="h-4 w-4 mr-2" />
                    Record Payment
                  </Button>
                </CardContent>
              </Card>
            </div>

            <div className="mt-6 flex justify-end gap-2">
              <Button variant="outline" onClick={onClose}>Close</Button>
              <Button>View Full Details</Button>
            </div>
          </div>
        </div>
      </div>
    );
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold">Collection Accounts</h1>
          <p className="text-gray-500">Manage and monitor delinquent accounts</p>
        </div>
        <Button>
          <Download className="h-4 w-4 mr-2" />
          Export
        </Button>
      </div>

      {/* Filters */}
      <Card>
        <CardContent className="p-6">
          <div className="grid grid-cols-1 md:grid-cols-6 gap-4">
            <div className="md:col-span-2">
              <Label>Search</Label>
              <div className="relative">
                <Search className="absolute left-2 top-2.5 h-4 w-4 text-gray-500" />
                <Input
                  placeholder="Search by name, ID, or account..."
                  value={filters.search}
                  onChange={(e) => setFilters({ ...filters, search: e.target.value })}
                  className="pl-8"
                />
              </div>
            </div>
            <div>
              <Label>Bucket</Label>
              <Select value={filters.bucket} onValueChange={(value) => setFilters({ ...filters, bucket: value })}>
                <SelectTrigger>
                  <SelectValue placeholder="All Buckets" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Buckets</SelectItem>
                  <SelectItem value="Bucket 1">Bucket 1 (1-30)</SelectItem>
                  <SelectItem value="Bucket 2">Bucket 2 (31-60)</SelectItem>
                  <SelectItem value="Bucket 3">Bucket 3 (61-90)</SelectItem>
                  <SelectItem value="Bucket 4">Bucket 4 (91-180)</SelectItem>
                  <SelectItem value="Bucket 5">Bucket 5 (180+)</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label>Product</Label>
              <Select value={filters.product} onValueChange={(value) => setFilters({ ...filters, product: value })}>
                <SelectTrigger>
                  <SelectValue placeholder="All Products" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Products</SelectItem>
                  <SelectItem value="Auto Finance">Auto Finance</SelectItem>
                  <SelectItem value="Personal Finance">Personal Finance</SelectItem>
                  <SelectItem value="Home Finance">Home Finance</SelectItem>
                  <SelectItem value="SME Finance">SME Finance</SelectItem>
                  <SelectItem value="Credit Card">Credit Card</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label>Status</Label>
              <Select value={filters.status} onValueChange={(value) => setFilters({ ...filters, status: value })}>
                <SelectTrigger>
                  <SelectValue placeholder="All Status" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Status</SelectItem>
                  <SelectItem value="Active">Active</SelectItem>
                  <SelectItem value="Legal">Legal</SelectItem>
                  <SelectItem value="Write-off Review">Write-off Review</SelectItem>
                  <SelectItem value="Closed">Closed</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="flex items-end">
              <Button variant="outline" className="w-full">
                <Filter className="h-4 w-4 mr-2" />
                More Filters
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Accounts Table */}
      <Card>
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Account ID</TableHead>
                <TableHead>Customer Name</TableHead>
                <TableHead>Product</TableHead>
                <TableHead>Outstanding</TableHead>
                <TableHead>DPD</TableHead>
                <TableHead>Bucket</TableHead>
                <TableHead>Status</TableHead>
                <TableHead>Priority</TableHead>
                <TableHead>Collector</TableHead>
                <TableHead>Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? (
                <TableRow>
                  <TableCell colSpan={10} className="text-center py-8">
                    Loading accounts...
                  </TableCell>
                </TableRow>
              ) : filteredAccounts.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={10} className="text-center py-8">
                    No accounts found
                  </TableCell>
                </TableRow>
              ) : (
                filteredAccounts.map((account) => (
                  <TableRow key={account.accountId} className="cursor-pointer hover:bg-gray-50">
                    <TableCell className="font-medium">{account.accountId}</TableCell>
                    <TableCell>
                      <div>
                        <div className="font-medium">{account.customerName}</div>
                        <div className="text-sm text-gray-500">{account.nationalId}</div>
                      </div>
                    </TableCell>
                    <TableCell>{account.productType}</TableCell>
                    <TableCell>SAR {account.outstanding.toLocaleString()}</TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        {account.dpd > 90 && <AlertCircle className="h-4 w-4 text-red-500" />}
                        {account.dpd} days
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge className={getBucketColor(account.bucket)}>{account.bucket}</Badge>
                    </TableCell>
                    <TableCell>
                      <Badge className={getStatusColor(account.caseStatus)}>{account.caseStatus}</Badge>
                    </TableCell>
                    <TableCell>
                      <Badge className={getPriorityColor(account.priority)}>{account.priority}</Badge>
                    </TableCell>
                    <TableCell>{account.collector}</TableCell>
                    <TableCell>
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => {
                          setSelectedAccount(account);
                          setShowDetails(true);
                        }}
                      >
                        <ChevronRight className="h-4 w-4" />
                      </Button>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>

      {/* Account Details Modal */}
      {showDetails && (
        <AccountDetailsModal
          account={selectedAccount}
          onClose={() => {
            setShowDetails(false);
            setSelectedAccount(null);
          }}
        />
      )}
    </div>
  );
};

export default CollectionAccounts;