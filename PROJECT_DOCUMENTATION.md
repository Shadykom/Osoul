# Osoul Collection Reporting System - Complete Documentation

## Table of Contents
1. [System Overview](#system-overview)
2. [Architecture](#architecture)
3. [Features](#features)
4. [Database Design](#database-design)
5. [API Documentation](#api-documentation)
6. [Frontend Components](#frontend-components)
7. [Deployment Guide](#deployment-guide)
8. [Security](#security)
9. [Performance Optimization](#performance-optimization)
10. [Troubleshooting](#troubleshooting)

## System Overview

The Osoul Collection Reporting System is a comprehensive web application designed for collection departments to track, analyze, and report on collection activities across multiple branches. The system provides real-time insights, customizable dashboards, and detailed comparative reports.

### Key Capabilities
- Multi-branch collection tracking
- Real-time performance monitoring
- Customizable user dashboards
- Comprehensive reporting (monthly, quarterly, branch comparisons)
- Role-based access control
- Target setting and achievement tracking

## Architecture

### Technology Stack

#### Backend
- **Runtime**: Node.js 18+
- **Framework**: Express.js
- **Database**: PostgreSQL 14+
- **Authentication**: JWT (JSON Web Tokens)
- **Validation**: express-validator
- **Logging**: Winston
- **Security**: Helmet, bcrypt, rate limiting

#### Frontend
- **Framework**: React 19 with Vite
- **UI Library**: Tailwind CSS + shadcn/ui
- **State Management**: Zustand
- **Data Fetching**: Axios + React Query
- **Charts**: Recharts
- **Dashboard Layout**: React Grid Layout
- **Form Handling**: React Hook Form + Zod

### System Architecture Diagram

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│                 │     │                 │     │                 │
│  React Frontend │────▶│  Express API    │────▶│  PostgreSQL DB  │
│                 │     │                 │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
        │                       │                       │
        │                       │                       │
        ▼                       ▼                       ▼
   [Nginx Server]         [JWT Auth]            [Data Storage]
   [Static Files]         [API Routes]          [Transactions]
   [SPA Routing]          [Validation]          [Reports]
                          [Rate Limiting]        [Dashboards]
```

## Features

### 1. Authentication & Authorization
- JWT-based authentication
- Role-based access control (Admin, Manager, Collector, Viewer)
- Secure password hashing with bcrypt
- Token expiration and refresh

### 2. Collection Management
- Create, read, update, delete collection transactions
- Track customer information
- Multiple payment methods support
- Transaction status management
- Reference number tracking

### 3. Branch Management
- Multi-branch support
- Regional grouping
- Branch performance tracking
- Manager assignment

### 4. Reporting Features

#### Monthly Comparison Report
- Month-over-month performance analysis
- Target vs actual comparison
- Achievement rate tracking
- Visual charts and detailed tables

#### Quarterly Comparison Report
- Quarter-over-quarter analysis
- Seasonal trend identification
- Performance patterns

#### Branch Comparison Report
- Side-by-side branch performance
- Regional analysis
- Top performers identification
- Ranking system

### 5. Customizable Dashboards
- Drag-and-drop widget placement
- Multiple widget types:
  - Summary cards
  - Line charts
  - Bar charts
  - Pie charts
- Widget configuration options
- Save and load dashboard layouts
- Multiple dashboards per user

### 6. Data Export
- CSV export for all reports
- JSON export option
- Filtered data export
- Scheduled report generation (planned)

## Database Design

### Core Tables

#### users
```sql
- id (Primary Key)
- email (Unique)
- password (Hashed)
- first_name
- last_name
- role (admin/manager/collector/viewer)
- is_active
- created_at
- updated_at
```

#### branches
```sql
- id (Primary Key)
- branch_code (Unique)
- branch_name
- region
- city
- manager_id (Foreign Key → users)
- is_active
- created_at
- updated_at
```

#### collection_transactions
```sql
- id (Primary Key)
- branch_id (Foreign Key → branches)
- transaction_date
- customer_id
- customer_name
- account_number
- transaction_type
- amount
- currency
- payment_method
- collector_id (Foreign Key → users)
- status
- reference_number (Unique)
- notes
- created_at
- updated_at
```

#### collection_targets
```sql
- id (Primary Key)
- branch_id (Foreign Key → branches)
- target_month
- target_year
- target_amount
- currency
- created_by (Foreign Key → users)
- created_at
- updated_at
```

#### user_dashboards
```sql
- id (Primary Key)
- user_id (Foreign Key → users)
- dashboard_name
- is_default
- layout_config (JSONB)
- created_at
- updated_at
```

#### dashboard_widgets
```sql
- id (Primary Key)
- dashboard_id (Foreign Key → user_dashboards)
- widget_type
- widget_title
- position_x
- position_y
- width
- height
- config (JSONB)
- is_visible
- created_at
- updated_at
```

### Database Views
- `monthly_collection_summary`: Aggregated monthly data
- `quarterly_collection_summary`: Aggregated quarterly data

### Indexes
- Branch-date composite index on transactions
- Target period index
- Dashboard widget lookup index

## API Documentation

### Base URL
```
http://localhost:5000/api/v1
```

### Authentication Endpoints

#### POST /auth/login
Login user and receive JWT token.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "user": {
    "id": 1,
    "email": "user@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "role": "admin"
  },
  "token": "eyJhbGciOiJIUzI1NiIs..."
}
```

### Collection Endpoints

#### GET /collections
Get paginated collection transactions.

**Query Parameters:**
- `branchId` (optional): Filter by branch
- `startDate` (optional): Start date (ISO 8601)
- `endDate` (optional): End date (ISO 8601)
- `status` (optional): Transaction status
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 20)

**Response:**
```json
{
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 20,
    "totalCount": 150,
    "totalPages": 8
  }
}
```

### Report Endpoints

#### GET /reports/monthly-comparison
Get monthly comparison data.

**Query Parameters:**
- `year`: Year to analyze
- `branchId` (optional): Specific branch

#### GET /reports/branch-comparison
Compare branch performance.

**Query Parameters:**
- `startDate`: Start date (ISO 8601)
- `endDate`: End date (ISO 8601)
- `region` (optional): Filter by region

### Dashboard Endpoints

#### POST /dashboards/:id/widgets
Add widget to dashboard.

**Request Body:**
```json
{
  "widgetType": "line_chart",
  "widgetTitle": "Monthly Trends",
  "positionX": 0,
  "positionY": 0,
  "width": 6,
  "height": 4,
  "config": {
    "dataSource": "performance_trends",
    "metric": "total_collected",
    "period": "month"
  }
}
```

## Frontend Components

### Core Components

#### DashboardGrid
- Drag-and-drop grid layout
- Widget management
- Auto-save layout changes
- Responsive design

#### DashboardWidget
- Dynamic widget rendering
- Data fetching and caching
- Error handling
- Loading states

#### MonthlyComparisonReport
- Interactive charts
- Data tables
- Export functionality
- Year/branch filtering

#### BranchComparisonReport
- Performance rankings
- Regional grouping
- Top performers highlight
- Detailed metrics

### State Management

#### Auth Store (Zustand)
```javascript
- user: Current user object
- token: JWT token
- isAuthenticated: Auth status
- login(): Login function
- logout(): Logout function
- checkAuth(): Verify authentication
- hasRole(): Role checking
```

## Deployment Guide

### Local Development

1. **Prerequisites**
   - Node.js 18+
   - PostgreSQL 14+
   - Git

2. **Setup Steps**
   ```bash
   # Clone repository
   git clone <repository-url>
   cd osoul-reporting-system

   # Run setup script
   chmod +x setup.sh
   ./setup.sh
   ```

### Docker Deployment

1. **Build and Run**
   ```bash
   # Build and start all services
   docker-compose up -d

   # View logs
   docker-compose logs -f

   # Stop services
   docker-compose down
   ```

2. **Access Services**
   - Frontend: http://localhost
   - Backend API: http://localhost:5000
   - pgAdmin: http://localhost:5050

### Production Deployment

1. **Environment Variables**
   ```env
   NODE_ENV=production
   DATABASE_URL=postgresql://user:pass@host:5432/db
   JWT_SECRET=secure_random_string
   FRONTEND_URL=https://yourdomain.com
   ```

2. **Database Setup**
   ```bash
   # Run migrations
   npm run db:migrate

   # Seed initial data (optional)
   npm run db:seed
   ```

3. **Process Management (PM2)**
   ```bash
   # Install PM2
   npm install -g pm2

   # Start backend
   pm2 start backend/src/server.js --name osoul-api

   # Save PM2 configuration
   pm2 save
   pm2 startup
   ```

4. **Nginx Configuration**
   ```nginx
   server {
       listen 80;
       server_name yourdomain.com;

       location / {
           root /var/www/osoul-frontend;
           try_files $uri /index.html;
       }

       location /api {
           proxy_pass http://localhost:5000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

## Security

### Implemented Security Measures

1. **Authentication**
   - JWT tokens with expiration
   - Bcrypt password hashing (10 rounds)
   - Secure token storage

2. **API Security**
   - Helmet.js for security headers
   - Rate limiting (100 requests/15 minutes)
   - Input validation on all endpoints
   - SQL injection prevention (parameterized queries)

3. **Frontend Security**
   - XSS protection
   - CSRF protection
   - Secure cookie handling
   - Content Security Policy

### Security Best Practices

1. **Environment Variables**
   - Never commit `.env` files
   - Use strong JWT secrets
   - Rotate secrets regularly

2. **Database Security**
   - Use least privilege principle
   - Regular backups
   - Connection pooling
   - SSL/TLS for connections

3. **API Security**
   - HTTPS only in production
   - API versioning
   - Request validation
   - Error message sanitization

## Performance Optimization

### Backend Optimizations

1. **Database**
   - Indexed frequently queried columns
   - Connection pooling (max 20 connections)
   - Query optimization
   - Materialized views for reports

2. **API**
   - Response compression
   - Caching strategy
   - Pagination on large datasets
   - Async/await for I/O operations

3. **Monitoring**
   - Winston logging
   - Performance metrics
   - Error tracking
   - Health checks

### Frontend Optimizations

1. **Bundle Size**
   - Code splitting
   - Lazy loading
   - Tree shaking
   - Minification

2. **Runtime Performance**
   - React.memo for expensive components
   - Virtualization for large lists
   - Debounced API calls
   - Optimistic updates

3. **Caching**
   - React Query caching
   - Local storage for user preferences
   - Service worker (planned)

## Troubleshooting

### Common Issues

1. **Database Connection Failed**
   ```bash
   # Check PostgreSQL status
   sudo systemctl status postgresql

   # Verify credentials
   psql -U username -d database_name

   # Check connection string
   echo $DATABASE_URL
   ```

2. **Frontend Can't Connect to API**
   ```bash
   # Check backend is running
   curl http://localhost:5000/health

   # Verify CORS settings
   # Check VITE_API_URL in .env
   ```

3. **Authentication Issues**
   ```bash
   # Clear browser storage
   localStorage.clear()

   # Check JWT expiration
   # Verify JWT_SECRET matches
   ```

### Debug Mode

1. **Enable Debug Logging**
   ```bash
   # Backend
   NODE_ENV=development npm run dev

   # Frontend
   VITE_DEBUG=true npm run dev
   ```

2. **Database Queries**
   ```javascript
   // Enable query logging in database.js
   pool.on('query', (query) => {
     console.log('QUERY:', query);
   });
   ```

### Support

For additional support:
- Check logs in `backend/logs/`
- Review error messages in browser console
- Contact: support@osoul.com

---

**Version**: 1.0.0  
**Last Updated**: December 2024  
**Maintained By**: Osoul Development Team