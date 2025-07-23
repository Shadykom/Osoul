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
import { Textarea } from '@/components/ui/textarea';
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
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Calendar } from '@/components/ui/calendar';
import {
  Phone,
  Mail,
  MessageSquare,
  MapPin,
  FileText,
  Calendar as CalendarIcon,
  Clock,
  User,
  DollarSign,
  CheckCircle,
  XCircle,
  AlertCircle,
  Plus,
  Filter,
  Download,
} from 'lucide-react';
import { format } from 'date-fns';
import { collectionService } from '@/services/collectionService';

const CollectionActivities = () => {
  const [activities, setActivities] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedDate, setSelectedDate] = useState(new Date());
  const [showNewActivity, setShowNewActivity] = useState(false);
  const [filters, setFilters] = useState({
    activityType: 'all',
    collector: 'all',
    result: 'all',
    dateRange: 'today',
  });
  const [newActivity, setNewActivity] = useState({
    accountId: '',
    activityType: '',
    contactPerson: '',
    contactNumber: '',
    result: '',
    promiseAmount: '',
    promiseDate: '',
    notes: '',
    nextAction: '',
    nextActionDate: '',
  });

  useEffect(() => {
    fetchActivities();
  }, [filters, selectedDate]);

  const fetchActivities = async () => {
    try {
      setLoading(true);
      // This would call the actual API
      const mockData = generateMockActivities();
      setActivities(mockData);
    } catch (error) {
      console.error('Error fetching activities:', error);
    } finally {
      setLoading(false);
    }
  };

  const generateMockActivities = () => {
    return [
      {
        id: 1,
        accountId: 'ACC001',
        customerName: 'Ahmad Al-Rashid',
        activityType: 'Call',
        collector: 'Abdulaziz Al-Rasheed',
        datetime: '2025-01-21 10:30:00',
        contactPerson: 'Ahmad Al-Rashid',
        contactNumber: '+966501234567',
        result: 'PTP Obtained',
        promiseAmount: 25000,
        promiseDate: '2025-01-25',
        notes: 'Customer agreed to pay partial amount after salary',
        nextAction: 'Follow up on PTP',
        nextActionDate: '2025-01-25',
      },
      {
        id: 2,
        accountId: 'ACC002',
        customerName: 'Fatima Al-Zahrani',
        activityType: 'SMS',
        collector: 'Sara Al-Mutairi',
        datetime: '2025-01-21 09:00:00',
        contactPerson: 'Fatima Al-Zahrani',
        contactNumber: '+966502345678',
        result: 'Delivered',
        promiseAmount: null,
        promiseDate: null,
        notes: 'Payment reminder SMS sent',
        nextAction: 'Call customer',
        nextActionDate: '2025-01-22',
      },
      {
        id: 3,
        accountId: 'ACC003',
        customerName: 'Mohammed Al-Otaibi',
        activityType: 'Visit',
        collector: 'Mohammed Al-Qahtani',
        datetime: '2025-01-20 14:00:00',
        contactPerson: 'Mohammed Al-Otaibi',
        contactNumber: '+966503456789',
        result: 'Customer Not Available',
        promiseAmount: null,
        promiseDate: null,
        notes: 'Neighbor confirmed customer still lives there',
        nextAction: 'Legal Notice',
        nextActionDate: '2025-01-25',
      },
      {
        id: 4,
        accountId: 'ACC051',
        customerName: 'Mansour Al-Rasheed',
        activityType: 'Call',
        collector: 'Fatima Al-Zahrani',
        datetime: '2025-01-21 11:45:00',
        contactPerson: 'Mansour Al-Rasheed',
        contactNumber: '+966541111111',
        result: 'Discussed',
        promiseAmount: 200000,
        promiseDate: '2025-02-15',
        notes: 'Large payment after property sale',
        nextAction: 'Document agreement',
        nextActionDate: '2025-01-23',
      },
      {
        id: 5,
        accountId: 'ACC005',
        customerName: 'Khalid Al-Maliki',
        activityType: 'Legal Notice',
        collector: 'Huda Al-Shahrani',
        datetime: '2025-01-19 16:00:00',
        contactPerson: 'Khalid Al-Maliki',
        contactNumber: '+966505678901',
        result: 'Served',
        promiseAmount: null,
        promiseDate: null,
        notes: 'Legal notice served by court officer',
        nextAction: 'Await response',
        nextActionDate: '2025-01-30',
      },
    ];
  };

  const getActivityIcon = (type) => {
    const icons = {
      'Call': <Phone className="h-4 w-4" />,
      'SMS': <MessageSquare className="h-4 w-4" />,
      'Email': <Mail className="h-4 w-4" />,
      'Visit': <MapPin className="h-4 w-4" />,
      'Letter': <FileText className="h-4 w-4" />,
      'Legal Notice': <AlertCircle className="h-4 w-4" />,
    };
    return icons[type] || <Phone className="h-4 w-4" />;
  };

  const getResultColor = (result) => {
    const colors = {
      'PTP Obtained': 'bg-green-100 text-green-800',
      'Discussed': 'bg-blue-100 text-blue-800',
      'No Answer': 'bg-gray-100 text-gray-800',
      'Customer Not Available': 'bg-orange-100 text-orange-800',
      'Disputed': 'bg-red-100 text-red-800',
      'Delivered': 'bg-green-100 text-green-800',
      'Served': 'bg-purple-100 text-purple-800',
    };
    return colors[result] || 'bg-gray-100 text-gray-800';
  };

  const filteredActivities = activities.filter(activity => {
    if (filters.activityType !== 'all' && activity.activityType !== filters.activityType) return false;
    if (filters.result !== 'all' && activity.result !== filters.result) return false;
    // Add more filter logic as needed
    return true;
  });

  const todayActivities = filteredActivities.filter(activity => {
    const activityDate = new Date(activity.datetime).toDateString();
    return activityDate === selectedDate.toDateString();
  });

  const upcomingActivities = activities.filter(activity => {
    const nextDate = new Date(activity.nextActionDate);
    const today = new Date();
    return nextDate >= today && nextDate <= new Date(today.getTime() + 7 * 24 * 60 * 60 * 1000);
  });

  const NewActivityModal = () => {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
        <div className="bg-white rounded-lg max-w-2xl w-full max-h-[90vh] overflow-y-auto">
          <div className="p-6">
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-2xl font-bold">Record New Activity</h2>
              <Button variant="ghost" onClick={() => setShowNewActivity(false)}>✕</Button>
            </div>

            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label>Account ID</Label>
                  <Input
                    value={newActivity.accountId}
                    onChange={(e) => setNewActivity({ ...newActivity, accountId: e.target.value })}
                    placeholder="Enter account ID"
                  />
                </div>
                <div>
                  <Label>Activity Type</Label>
                  <Select
                    value={newActivity.activityType}
                    onValueChange={(value) => setNewActivity({ ...newActivity, activityType: value })}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select type" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="Call">Call</SelectItem>
                      <SelectItem value="SMS">SMS</SelectItem>
                      <SelectItem value="Email">Email</SelectItem>
                      <SelectItem value="Visit">Visit</SelectItem>
                      <SelectItem value="Letter">Letter</SelectItem>
                      <SelectItem value="Legal Notice">Legal Notice</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label>Contact Person</Label>
                  <Input
                    value={newActivity.contactPerson}
                    onChange={(e) => setNewActivity({ ...newActivity, contactPerson: e.target.value })}
                    placeholder="Name of person contacted"
                  />
                </div>
                <div>
                  <Label>Contact Number</Label>
                  <Input
                    value={newActivity.contactNumber}
                    onChange={(e) => setNewActivity({ ...newActivity, contactNumber: e.target.value })}
                    placeholder="Phone number"
                  />
                </div>
              </div>

              <div>
                <Label>Activity Result</Label>
                <Select
                  value={newActivity.result}
                  onValueChange={(value) => setNewActivity({ ...newActivity, result: value })}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Select result" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="PTP Obtained">PTP Obtained</SelectItem>
                    <SelectItem value="Discussed">Discussed</SelectItem>
                    <SelectItem value="No Answer">No Answer</SelectItem>
                    <SelectItem value="Customer Not Available">Customer Not Available</SelectItem>
                    <SelectItem value="Disputed">Disputed</SelectItem>
                    <SelectItem value="Delivered">Delivered</SelectItem>
                    <SelectItem value="Served">Served</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              {newActivity.result === 'PTP Obtained' && (
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label>Promise Amount</Label>
                    <Input
                      type="number"
                      value={newActivity.promiseAmount}
                      onChange={(e) => setNewActivity({ ...newActivity, promiseAmount: e.target.value })}
                      placeholder="SAR amount"
                    />
                  </div>
                  <div>
                    <Label>Promise Date</Label>
                    <Input
                      type="date"
                      value={newActivity.promiseDate}
                      onChange={(e) => setNewActivity({ ...newActivity, promiseDate: e.target.value })}
                    />
                  </div>
                </div>
              )}

              <div>
                <Label>Notes</Label>
                <Textarea
                  value={newActivity.notes}
                  onChange={(e) => setNewActivity({ ...newActivity, notes: e.target.value })}
                  placeholder="Enter activity notes..."
                  rows={4}
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label>Next Action</Label>
                  <Input
                    value={newActivity.nextAction}
                    onChange={(e) => setNewActivity({ ...newActivity, nextAction: e.target.value })}
                    placeholder="What to do next"
                  />
                </div>
                <div>
                  <Label>Next Action Date</Label>
                  <Input
                    type="date"
                    value={newActivity.nextActionDate}
                    onChange={(e) => setNewActivity({ ...newActivity, nextActionDate: e.target.value })}
                  />
                </div>
              </div>
            </div>

            <div className="mt-6 flex justify-end gap-2">
              <Button variant="outline" onClick={() => setShowNewActivity(false)}>Cancel</Button>
              <Button onClick={() => {
                // Save activity logic here
                setShowNewActivity(false);
              }}>Save Activity</Button>
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
          <h1 className="text-3xl font-bold">Collection Activities</h1>
          <p className="text-gray-500">Track and manage all collection activities</p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline">
            <Download className="h-4 w-4 mr-2" />
            Export
          </Button>
          <Button onClick={() => setShowNewActivity(true)}>
            <Plus className="h-4 w-4 mr-2" />
            New Activity
          </Button>
        </div>
      </div>

      <Tabs defaultValue="activities" className="space-y-4">
        <TabsList>
          <TabsTrigger value="activities">Activities Log</TabsTrigger>
          <TabsTrigger value="calendar">Calendar View</TabsTrigger>
          <TabsTrigger value="upcoming">Upcoming Actions</TabsTrigger>
        </TabsList>

        <TabsContent value="activities" className="space-y-4">
          {/* Filters */}
          <Card>
            <CardContent className="p-6">
              <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                  <Label>Activity Type</Label>
                  <Select value={filters.activityType} onValueChange={(value) => setFilters({ ...filters, activityType: value })}>
                    <SelectTrigger>
                      <SelectValue placeholder="All Types" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">All Types</SelectItem>
                      <SelectItem value="Call">Call</SelectItem>
                      <SelectItem value="SMS">SMS</SelectItem>
                      <SelectItem value="Email">Email</SelectItem>
                      <SelectItem value="Visit">Visit</SelectItem>
                      <SelectItem value="Letter">Letter</SelectItem>
                      <SelectItem value="Legal Notice">Legal Notice</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label>Result</Label>
                  <Select value={filters.result} onValueChange={(value) => setFilters({ ...filters, result: value })}>
                    <SelectTrigger>
                      <SelectValue placeholder="All Results" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">All Results</SelectItem>
                      <SelectItem value="PTP Obtained">PTP Obtained</SelectItem>
                      <SelectItem value="Discussed">Discussed</SelectItem>
                      <SelectItem value="No Answer">No Answer</SelectItem>
                      <SelectItem value="Customer Not Available">Customer Not Available</SelectItem>
                      <SelectItem value="Disputed">Disputed</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label>Date Range</Label>
                  <Select value={filters.dateRange} onValueChange={(value) => setFilters({ ...filters, dateRange: value })}>
                    <SelectTrigger>
                      <SelectValue placeholder="Select range" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="today">Today</SelectItem>
                      <SelectItem value="yesterday">Yesterday</SelectItem>
                      <SelectItem value="week">Last 7 Days</SelectItem>
                      <SelectItem value="month">Last 30 Days</SelectItem>
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

          {/* Activities Table */}
          <Card>
            <CardContent className="p-0">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Time</TableHead>
                    <TableHead>Account</TableHead>
                    <TableHead>Customer</TableHead>
                    <TableHead>Activity</TableHead>
                    <TableHead>Collector</TableHead>
                    <TableHead>Result</TableHead>
                    <TableHead>PTP Amount</TableHead>
                    <TableHead>Notes</TableHead>
                    <TableHead>Next Action</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {loading ? (
                    <TableRow>
                      <TableCell colSpan={9} className="text-center py-8">
                        Loading activities...
                      </TableCell>
                    </TableRow>
                  ) : filteredActivities.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={9} className="text-center py-8">
                        No activities found
                      </TableCell>
                    </TableRow>
                  ) : (
                    filteredActivities.map((activity) => (
                      <TableRow key={activity.id}>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <Clock className="h-4 w-4 text-gray-500" />
                            {format(new Date(activity.datetime), 'HH:mm')}
                          </div>
                        </TableCell>
                        <TableCell className="font-medium">{activity.accountId}</TableCell>
                        <TableCell>{activity.customerName}</TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            {getActivityIcon(activity.activityType)}
                            {activity.activityType}
                          </div>
                        </TableCell>
                        <TableCell>{activity.collector}</TableCell>
                        <TableCell>
                          <Badge className={getResultColor(activity.result)}>{activity.result}</Badge>
                        </TableCell>
                        <TableCell>
                          {activity.promiseAmount ? `SAR ${activity.promiseAmount.toLocaleString()}` : '-'}
                        </TableCell>
                        <TableCell className="max-w-xs truncate" title={activity.notes}>
                          {activity.notes}
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            <div>{activity.nextAction}</div>
                            <div className="text-gray-500">{format(new Date(activity.nextActionDate), 'dd/MM')}</div>
                          </div>
                        </TableCell>
                      </TableRow>
                    ))
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="calendar" className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
            <div className="md:col-span-1">
              <Card>
                <CardContent className="p-4">
                  <Calendar
                    mode="single"
                    selected={selectedDate}
                    onSelect={setSelectedDate}
                    className="rounded-md"
                  />
                </CardContent>
              </Card>
            </div>
            <div className="md:col-span-3">
              <Card>
                <CardHeader>
                  <CardTitle>Activities for {format(selectedDate, 'EEEE, MMMM d, yyyy')}</CardTitle>
                </CardHeader>
                <CardContent>
                  {todayActivities.length === 0 ? (
                    <p className="text-center text-gray-500 py-8">No activities scheduled for this date</p>
                  ) : (
                    <div className="space-y-4">
                      {todayActivities.map((activity) => (
                        <div key={activity.id} className="border rounded-lg p-4">
                          <div className="flex justify-between items-start">
                            <div>
                              <div className="flex items-center gap-2">
                                {getActivityIcon(activity.activityType)}
                                <span className="font-medium">{activity.activityType}</span>
                                <Badge className={getResultColor(activity.result)}>{activity.result}</Badge>
                              </div>
                              <p className="text-sm text-gray-500 mt-1">
                                {activity.customerName} - {activity.accountId}
                              </p>
                              <p className="text-sm mt-2">{activity.notes}</p>
                            </div>
                            <div className="text-right">
                              <p className="text-sm font-medium">{format(new Date(activity.datetime), 'HH:mm')}</p>
                              <p className="text-sm text-gray-500">{activity.collector}</p>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </CardContent>
              </Card>
            </div>
          </div>
        </TabsContent>

        <TabsContent value="upcoming" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Upcoming Actions</CardTitle>
              <CardDescription>Actions scheduled for the next 7 days</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {upcomingActivities.map((activity) => (
                  <div key={activity.id} className="border rounded-lg p-4">
                    <div className="flex justify-between items-start">
                      <div>
                        <div className="flex items-center gap-2">
                          <CalendarIcon className="h-4 w-4 text-gray-500" />
                          <span className="font-medium">
                            {format(new Date(activity.nextActionDate), 'EEEE, MMM d')}
                          </span>
                        </div>
                        <p className="text-sm text-gray-500 mt-1">
                          {activity.customerName} - {activity.accountId}
                        </p>
                        <p className="text-sm font-medium mt-2">{activity.nextAction}</p>
                        <p className="text-sm text-gray-500">Last activity: {activity.activityType} - {activity.result}</p>
                      </div>
                      <div>
                        <Button size="sm">Take Action</Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      {/* New Activity Modal */}
      {showNewActivity && <NewActivityModal />}
    </div>
  );
};

export default CollectionActivities;