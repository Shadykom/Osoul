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
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import {
  Scale,
  Gavel,
  FileText,
  Calendar,
  DollarSign,
  Building,
  User,
  AlertTriangle,
  Clock,
  Download,
  Plus,
  Filter,
} from 'lucide-react';
import { format } from 'date-fns';
import { collectionService } from '@/services/collectionService';

const CollectionLegalCases = () => {
  const [legalCases, setLegalCases] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filters, setFilters] = useState({
    status: 'all',
    caseType: 'all',
    court: 'all',
    dateRange: 'all',
  });
  const [selectedCase, setSelectedCase] = useState(null);
  const [showCaseDetails, setShowCaseDetails] = useState(false);

  useEffect(() => {
    fetchLegalCases();
  }, [filters]);

  const fetchLegalCases = async () => {
    try {
      setLoading(true);
      // This would call the actual API
      const mockData = generateMockLegalCases();
      setLegalCases(mockData);
    } catch (error) {
      console.error('Error fetching legal cases:', error);
    } finally {
      setLoading(false);
    }
  };

  const generateMockLegalCases = () => {
    return [
      {
        id: 1,
        caseNumber: 'EX2024/1234',
        accountId: 'ACC003',
        customerName: 'Mohammed Al-Otaibi',
        nationalId: '3456789012',
        caseType: 'Execution',
        courtName: 'Riyadh General Court',
        filingDate: '2024-10-15',
        lawyerName: 'Abdullah Legal Firm',
        caseStatus: 'Under Execution',
        judgmentDate: '2024-12-20',
        judgmentAmount: 950000,
        legalCosts: 25000,
        nextHearingDate: '2025-02-15',
        outstandingAmount: 950000,
        recoveredAmount: 0,
        lastUpdate: '2025-01-20',
      },
      {
        id: 2,
        caseNumber: 'CV2024/5678',
        accountId: 'ACC005',
        customerName: 'Khalid Al-Maliki',
        nationalId: '5678901234',
        caseType: 'Civil Case',
        courtName: 'Jeddah General Court',
        filingDate: '2024-08-20',
        lawyerName: 'Al-Fahad Law Office',
        caseStatus: 'Judgment Obtained',
        judgmentDate: '2024-11-15',
        judgmentAmount: 48000,
        legalCosts: 8000,
        nextHearingDate: null,
        outstandingAmount: 48000,
        recoveredAmount: 0,
        lastUpdate: '2025-01-15',
      },
      {
        id: 3,
        caseNumber: 'EX2024/3456',
        accountId: 'ACC059',
        customerName: 'Hamza Al-Maliki',
        nationalId: '9999999999',
        caseType: 'Execution',
        courtName: 'Dammam Commercial Court',
        filingDate: '2024-09-30',
        lawyerName: 'Al-Enezi Advocates',
        caseStatus: 'Under Execution',
        judgmentDate: '2024-12-15',
        judgmentAmount: 850000,
        legalCosts: 35000,
        nextHearingDate: '2025-04-01',
        outstandingAmount: 850000,
        recoveredAmount: 150000,
        lastUpdate: '2025-01-18',
      },
      {
        id: 4,
        caseNumber: 'CV2024/9012',
        accountId: 'ACC010',
        customerName: 'Sara Al-Mutairi',
        nationalId: '0123456789',
        caseType: 'Civil Case',
        courtName: 'Dammam General Court',
        filingDate: '2024-09-10',
        lawyerName: 'Al-Rashid Legal Consultants',
        caseStatus: 'Filed',
        judgmentDate: null,
        judgmentAmount: null,
        legalCosts: 5000,
        nextHearingDate: '2025-02-10',
        outstandingAmount: 42000,
        recoveredAmount: 0,
        lastUpdate: '2025-01-19',
      },
      {
        id: 5,
        caseNumber: 'EX2024/5678',
        accountId: 'ACC032',
        customerName: 'Wafa Al-Salem',
        nationalId: '2424242424',
        caseType: 'Execution',
        courtName: 'Riyadh General Court',
        filingDate: '2024-11-15',
        lawyerName: 'Al-Mutairi Law Firm',
        caseStatus: 'Under Execution',
        judgmentDate: '2025-01-10',
        judgmentAmount: 32000,
        legalCosts: 5000,
        nextHearingDate: null,
        outstandingAmount: 32000,
        recoveredAmount: 5000,
        lastUpdate: '2025-01-16',
      },
    ];
  };

  const getStatusColor = (status) => {
    const colors = {
      'Filed': 'bg-blue-100 text-blue-800',
      'In Progress': 'bg-yellow-100 text-yellow-800',
      'Judgment Obtained': 'bg-green-100 text-green-800',
      'Under Execution': 'bg-purple-100 text-purple-800',
      'Closed': 'bg-gray-100 text-gray-800',
    };
    return colors[status] || 'bg-gray-100 text-gray-800';
  };

  const getCaseTypeIcon = (type) => {
    return type === 'Execution' ? <Gavel className="h-4 w-4" /> : <Scale className="h-4 w-4" />;
  };

  const filteredCases = legalCases.filter(legalCase => {
    if (filters.status !== 'all' && legalCase.caseStatus !== filters.status) return false;
    if (filters.caseType !== 'all' && legalCase.caseType !== filters.caseType) return false;
    if (filters.court !== 'all' && !legalCase.courtName.includes(filters.court)) return false;
    return true;
  });

  const activeCases = filteredCases.filter(c => c.caseStatus !== 'Closed');
  const totalJudgmentAmount = filteredCases.reduce((sum, c) => sum + (c.judgmentAmount || 0), 0);
  const totalLegalCosts = filteredCases.reduce((sum, c) => sum + c.legalCosts, 0);
  const totalRecovered = filteredCases.reduce((sum, c) => sum + c.recoveredAmount, 0);

  const CaseDetailsModal = ({ legalCase, onClose }) => {
    if (!legalCase) return null;

    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
        <div className="bg-white rounded-lg max-w-4xl w-full max-h-[90vh] overflow-y-auto">
          <div className="p-6">
            <div className="flex justify-between items-start mb-6">
              <div>
                <h2 className="text-2xl font-bold">Legal Case Details</h2>
                <p className="text-gray-500">Case Number: {legalCase.caseNumber}</p>
              </div>
              <Button variant="ghost" onClick={onClose}>✕</Button>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {/* Case Information */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Case Information</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Case Type</span>
                    <div className="flex items-center gap-2">
                      {getCaseTypeIcon(legalCase.caseType)}
                      <span className="text-sm font-medium">{legalCase.caseType}</span>
                    </div>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Court</span>
                    <span className="text-sm font-medium">{legalCase.courtName}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Filing Date</span>
                    <span className="text-sm font-medium">{format(new Date(legalCase.filingDate), 'dd/MM/yyyy')}</span>
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-sm text-gray-500">Status</span>
                    <Badge className={getStatusColor(legalCase.caseStatus)}>{legalCase.caseStatus}</Badge>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Lawyer/Firm</span>
                    <span className="text-sm font-medium">{legalCase.lawyerName}</span>
                  </div>
                </CardContent>
              </Card>

              {/* Customer Information */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Customer Information</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Customer Name</span>
                    <span className="text-sm font-medium">{legalCase.customerName}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">National ID</span>
                    <span className="text-sm font-medium">{legalCase.nationalId}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Account ID</span>
                    <span className="text-sm font-medium">{legalCase.accountId}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Outstanding Amount</span>
                    <span className="text-sm font-medium">SAR {legalCase.outstandingAmount.toLocaleString()}</span>
                  </div>
                </CardContent>
              </Card>

              {/* Financial Summary */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Financial Summary</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  {legalCase.judgmentAmount && (
                    <div className="flex justify-between">
                      <span className="text-sm text-gray-500">Judgment Amount</span>
                      <span className="text-sm font-medium">SAR {legalCase.judgmentAmount.toLocaleString()}</span>
                    </div>
                  )}
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Legal Costs</span>
                    <span className="text-sm font-medium">SAR {legalCase.legalCosts.toLocaleString()}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Total Claim</span>
                    <span className="text-sm font-medium">
                      SAR {((legalCase.judgmentAmount || legalCase.outstandingAmount) + legalCase.legalCosts).toLocaleString()}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Recovered Amount</span>
                    <span className="text-sm font-medium">SAR {legalCase.recoveredAmount.toLocaleString()}</span>
                  </div>
                  <div className="mt-4">
                    <div className="flex justify-between text-sm mb-1">
                      <span>Recovery Progress</span>
                      <span>{((legalCase.recoveredAmount / (legalCase.judgmentAmount || legalCase.outstandingAmount)) * 100).toFixed(1)}%</span>
                    </div>
                    <Progress 
                      value={(legalCase.recoveredAmount / (legalCase.judgmentAmount || legalCase.outstandingAmount)) * 100} 
                      className="h-2"
                    />
                  </div>
                </CardContent>
              </Card>

              {/* Important Dates */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Important Dates</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  {legalCase.judgmentDate && (
                    <div className="flex justify-between">
                      <span className="text-sm text-gray-500">Judgment Date</span>
                      <span className="text-sm font-medium">{format(new Date(legalCase.judgmentDate), 'dd/MM/yyyy')}</span>
                    </div>
                  )}
                  {legalCase.nextHearingDate && (
                    <div className="flex justify-between">
                      <span className="text-sm text-gray-500">Next Hearing</span>
                      <span className="text-sm font-medium">{format(new Date(legalCase.nextHearingDate), 'dd/MM/yyyy')}</span>
                    </div>
                  )}
                  <div className="flex justify-between">
                    <span className="text-sm text-gray-500">Last Update</span>
                    <span className="text-sm font-medium">{format(new Date(legalCase.lastUpdate), 'dd/MM/yyyy')}</span>
                  </div>
                </CardContent>
              </Card>
            </div>

            <div className="mt-6 flex justify-end gap-2">
              <Button variant="outline" onClick={onClose}>Close</Button>
              <Button>View Documents</Button>
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
          <h1 className="text-3xl font-bold">Legal Cases</h1>
          <p className="text-gray-500">Manage and track legal proceedings</p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline">
            <Download className="h-4 w-4 mr-2" />
            Export
          </Button>
          <Button>
            <Plus className="h-4 w-4 mr-2" />
            New Case
          </Button>
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <Card>
          <CardHeader className="pb-3">
            <div className="flex items-center justify-between">
              <CardTitle className="text-sm font-medium text-gray-500">Active Cases</CardTitle>
              <Scale className="h-4 w-4 text-gray-400" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{activeCases.length}</div>
            <p className="text-xs text-gray-500 mt-1">Currently in progress</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-3">
            <div className="flex items-center justify-between">
              <CardTitle className="text-sm font-medium text-gray-500">Total Judgment</CardTitle>
              <DollarSign className="h-4 w-4 text-gray-400" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">SAR {(totalJudgmentAmount / 1000000).toFixed(1)}M</div>
            <p className="text-xs text-gray-500 mt-1">Total judgment amount</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-3">
            <div className="flex items-center justify-between">
              <CardTitle className="text-sm font-medium text-gray-500">Legal Costs</CardTitle>
              <FileText className="h-4 w-4 text-gray-400" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">SAR {(totalLegalCosts / 1000).toFixed(0)}K</div>
            <p className="text-xs text-gray-500 mt-1">Total legal expenses</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-3">
            <div className="flex items-center justify-between">
              <CardTitle className="text-sm font-medium text-gray-500">Recovered</CardTitle>
              <AlertTriangle className="h-4 w-4 text-gray-400" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">SAR {(totalRecovered / 1000).toFixed(0)}K</div>
            <p className="text-xs text-gray-500 mt-1">Amount recovered</p>
          </CardContent>
        </Card>
      </div>

      <Tabs defaultValue="all" className="space-y-4">
        <TabsList>
          <TabsTrigger value="all">All Cases</TabsTrigger>
          <TabsTrigger value="active">Active</TabsTrigger>
          <TabsTrigger value="execution">Under Execution</TabsTrigger>
          <TabsTrigger value="upcoming">Upcoming Hearings</TabsTrigger>
        </TabsList>

        <TabsContent value="all" className="space-y-4">
          {/* Filters */}
          <Card>
            <CardContent className="p-6">
              <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                  <Label>Case Status</Label>
                  <Select value={filters.status} onValueChange={(value) => setFilters({ ...filters, status: value })}>
                    <SelectTrigger>
                      <SelectValue placeholder="All Status" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">All Status</SelectItem>
                      <SelectItem value="Filed">Filed</SelectItem>
                      <SelectItem value="In Progress">In Progress</SelectItem>
                      <SelectItem value="Judgment Obtained">Judgment Obtained</SelectItem>
                      <SelectItem value="Under Execution">Under Execution</SelectItem>
                      <SelectItem value="Closed">Closed</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label>Case Type</Label>
                  <Select value={filters.caseType} onValueChange={(value) => setFilters({ ...filters, caseType: value })}>
                    <SelectTrigger>
                      <SelectValue placeholder="All Types" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">All Types</SelectItem>
                      <SelectItem value="Civil Case">Civil Case</SelectItem>
                      <SelectItem value="Execution">Execution</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label>Court</Label>
                  <Select value={filters.court} onValueChange={(value) => setFilters({ ...filters, court: value })}>
                    <SelectTrigger>
                      <SelectValue placeholder="All Courts" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">All Courts</SelectItem>
                      <SelectItem value="Riyadh">Riyadh Courts</SelectItem>
                      <SelectItem value="Jeddah">Jeddah Courts</SelectItem>
                      <SelectItem value="Dammam">Dammam Courts</SelectItem>
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

          {/* Cases Table */}
          <Card>
            <CardContent className="p-0">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Case Number</TableHead>
                    <TableHead>Customer</TableHead>
                    <TableHead>Type</TableHead>
                    <TableHead>Court</TableHead>
                    <TableHead>Status</TableHead>
                    <TableHead>Judgment Amount</TableHead>
                    <TableHead>Recovered</TableHead>
                    <TableHead>Next Hearing</TableHead>
                    <TableHead>Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {loading ? (
                    <TableRow>
                      <TableCell colSpan={9} className="text-center py-8">
                        Loading legal cases...
                      </TableCell>
                    </TableRow>
                  ) : filteredCases.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={9} className="text-center py-8">
                        No legal cases found
                      </TableCell>
                    </TableRow>
                  ) : (
                    filteredCases.map((legalCase) => (
                      <TableRow key={legalCase.id} className="cursor-pointer hover:bg-gray-50">
                        <TableCell className="font-medium">{legalCase.caseNumber}</TableCell>
                        <TableCell>
                          <div>
                            <div className="font-medium">{legalCase.customerName}</div>
                            <div className="text-sm text-gray-500">{legalCase.accountId}</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            {getCaseTypeIcon(legalCase.caseType)}
                            {legalCase.caseType}
                          </div>
                        </TableCell>
                        <TableCell>{legalCase.courtName}</TableCell>
                        <TableCell>
                          <Badge className={getStatusColor(legalCase.caseStatus)}>{legalCase.caseStatus}</Badge>
                        </TableCell>
                        <TableCell>
                          {legalCase.judgmentAmount ? `SAR ${legalCase.judgmentAmount.toLocaleString()}` : '-'}
                        </TableCell>
                        <TableCell>
                          <div>
                            <div>SAR {legalCase.recoveredAmount.toLocaleString()}</div>
                            <Progress 
                              value={(legalCase.recoveredAmount / (legalCase.judgmentAmount || legalCase.outstandingAmount)) * 100} 
                              className="h-1 mt-1"
                            />
                          </div>
                        </TableCell>
                        <TableCell>
                          {legalCase.nextHearingDate ? (
                            <div className="flex items-center gap-1">
                              <Calendar className="h-3 w-3 text-gray-500" />
                              {format(new Date(legalCase.nextHearingDate), 'dd/MM')}
                            </div>
                          ) : '-'}
                        </TableCell>
                        <TableCell>
                          <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => {
                              setSelectedCase(legalCase);
                              setShowCaseDetails(true);
                            }}
                          >
                            View
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="active">
          <Card>
            <CardHeader>
              <CardTitle>Active Legal Cases</CardTitle>
              <CardDescription>Cases currently in progress or filed</CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-center text-gray-500 py-8">Active cases view coming soon...</p>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="execution">
          <Card>
            <CardHeader>
              <CardTitle>Cases Under Execution</CardTitle>
              <CardDescription>Cases with judgments being executed</CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-center text-gray-500 py-8">Execution cases view coming soon...</p>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="upcoming">
          <Card>
            <CardHeader>
              <CardTitle>Upcoming Hearings</CardTitle>
              <CardDescription>Court hearings scheduled in the next 30 days</CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-center text-gray-500 py-8">Upcoming hearings view coming soon...</p>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      {/* Case Details Modal */}
      {showCaseDetails && (
        <CaseDetailsModal
          legalCase={selectedCase}
          onClose={() => {
            setShowCaseDetails(false);
            setSelectedCase(null);
          }}
        />
      )}
    </div>
  );
};

export default CollectionLegalCases;