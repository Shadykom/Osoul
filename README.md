# Osoul Collection Reporting System

A comprehensive database-driven application with customizable dashboards for collection department reporting, featuring month-to-month, quarter-to-quarter, and branch-to-branch comparisons.

## Features

- 🔐 **Authentication & Authorization**: Secure JWT-based authentication with role-based access control
- 📊 **Comprehensive Reporting**: 
  - Monthly and quarterly comparison reports
  - Branch-to-branch performance analysis
  - Collection trends and forecasting
  - Top performers identification
- 📈 **Customizable Dashboards**: 
  - User-driven dashboard creation
  - Drag-and-drop widget placement
  - Configurable charts and metrics
  - Real-time data updates
- 🏢 **Multi-Branch Management**: Support for multiple branches with individual targets and performance tracking
- 💰 **Collection Management**: Complete CRUD operations for collection transactions
- 🎯 **Target Setting**: Set and track monthly/quarterly collection targets
- 📱 **Responsive Design**: Works seamlessly on desktop and mobile devices
- 🌐 **Bilingual Support**: Full English and Arabic language support with RTL layout

## Tech Stack

### Frontend
- React 19 with Vite
- Tailwind CSS for styling
- Recharts for data visualization
- React Grid Layout for customizable dashboards
- Axios for API communication
- Zustand for state management
- shadcn/ui components

### Backend
- Node.js with Express.js
- PostgreSQL database
- JWT authentication
- RESTful API architecture
- Winston for logging
- Express-validator for input validation

## Prerequisites

- Node.js 18+
- PostgreSQL 14+
- npm or pnpm package manager

## Quick Start

### 1. Clone the repository
```bash
git clone <repository-url>
cd osoul-reporting-system
```

### 2. Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env
# Edit .env with your database credentials

# Create database
createdb osoul_reporting

# Run migrations
npm run db:migrate

# Seed sample data
npm run db:seed

# Start backend server
npm run dev
```

The backend will run on `http://localhost:5000`

### 3. Frontend Setup

```bash
# From project root
cd ..

# Install frontend dependencies
npm install

# Create .env file for frontend
echo "VITE_API_URL=http://localhost:5000/api/v1" > .env

# Start frontend development server
npm run dev
```

The frontend will run on `http://localhost:5173`

## Default Login Credentials

After seeding the database, use these credentials to log in:

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@osoul.com | password123 |
| Manager | manager@osoul.com | password123 |
| Collector | collector1@osoul.com | password123 |
| Viewer | viewer@osoul.com | password123 |

## Project Structure

```
osoul-reporting-system/
├── backend/
│   ├── src/
│   │   ├── config/         # Database and app configuration
│   │   ├── controllers/    # Request handlers
│   │   ├── middleware/     # Express middleware
│   │   ├── routes/         # API routes
│   │   ├── utils/          # Utility functions
│   │   └── server.js       # Express server setup
│   ├── database/
│   │   ├── schema.sql      # Database schema
│   │   ├── migrate.js      # Migration script
│   │   └── seed.js         # Seed data script
│   └── package.json
├── src/
│   ├── components/         # React components
│   ├── services/          # API service layers
│   ├── stores/            # State management
│   ├── pages/             # Page components
│   ├── assets/            # Images and static files
│   └── App.jsx            # Main app component
└── package.json
```

## Key Features Explained

### 1. Customizable Dashboards
- Users can create multiple dashboards
- Add, remove, and rearrange widgets
- Configure widget settings (chart type, data source, time period)
- Save dashboard layouts
- Export dashboard configurations

### 2. Comprehensive Reporting
- **Monthly Comparison**: Compare collection performance month-over-month
- **Quarterly Analysis**: View quarterly trends and patterns
- **Branch Comparison**: Analyze performance across different branches
- **Performance Metrics**: Track KPIs like collection rate, average transaction value, customer count
- **Export Options**: Download reports in CSV or JSON format

### 3. User Roles
- **Admin**: Full system access, user management, system configuration
- **Manager**: View reports, manage branches and targets, approve transactions
- **Collector**: Create and manage collection transactions, view own performance
- **Viewer**: Read-only access to reports and dashboards

### 4. Data Visualization
- Line charts for trends over time
- Bar charts for comparisons
- Pie charts for distribution analysis
- Summary cards for key metrics
- Heat maps for geographic analysis
- Customizable chart colors and styles

## API Documentation

The backend provides a RESTful API with the following main endpoints:

### Authentication
- `POST /api/v1/auth/login` - User login
- `POST /api/v1/auth/register` - Register new user
- `GET /api/v1/auth/me` - Get current user
- `PUT /api/v1/auth/password` - Update password

### Collections
- `GET /api/v1/collections` - List transactions with filters
- `POST /api/v1/collections` - Create new transaction
- `PUT /api/v1/collections/:id` - Update transaction
- `DELETE /api/v1/collections/:id` - Delete transaction

### Reports
- `GET /api/v1/reports/monthly-comparison` - Monthly comparison data
- `GET /api/v1/reports/quarterly-comparison` - Quarterly comparison data
- `GET /api/v1/reports/branch-comparison` - Branch performance comparison
- `GET /api/v1/reports/performance-trends` - Performance trend analysis

### Dashboards
- `GET /api/v1/dashboards` - List user dashboards
- `POST /api/v1/dashboards` - Create new dashboard
- `PUT /api/v1/dashboards/:id` - Update dashboard
- `POST /api/v1/dashboards/:id/widgets` - Add widget to dashboard

For detailed API documentation, see `backend/README.md`

## Development

### Running Tests
```bash
# Backend tests
cd backend && npm test

# Frontend tests
npm test
```

### Code Style
- ESLint for JavaScript linting
- Prettier for code formatting
- Follow React best practices
- Use functional components with hooks

### Building for Production

```bash
# Build frontend
npm run build

# Build backend
cd backend && npm run build
```

## Deployment

### Vercel Deployment (Frontend)
1. Connect your GitHub repository to Vercel
2. Set environment variable: `VITE_API_URL` to your backend URL
3. Deploy with automatic builds on push

### Backend Deployment
1. Set up PostgreSQL database on your server
2. Configure environment variables for production
3. Use PM2 for process management:
   ```bash
   pm2 start backend/src/server.js --name osoul-api
   ```
4. Set up nginx as reverse proxy

### Docker Deployment (Optional)
```bash
# Build and run with docker-compose
docker-compose up -d
```

## Security Considerations

- All passwords are hashed using bcrypt
- JWT tokens expire after 7 days
- Rate limiting: 100 requests per 15 minutes
- Input validation on all endpoints
- SQL injection protection
- XSS protection
- CORS configured for production domains

## Performance Optimization

- Database indexes on frequently queried fields
- Pagination for large data sets
- Caching for expensive queries
- Lazy loading for dashboard widgets
- Code splitting for optimal bundle size

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Troubleshooting

### Common Issues

1. **Database connection errors**
   - Check PostgreSQL is running
   - Verify database credentials in `.env`
   - Ensure database exists

2. **Frontend API connection issues**
   - Check backend is running on correct port
   - Verify `VITE_API_URL` in frontend `.env`
   - Check CORS settings

3. **Build errors**
   - Clear node_modules and reinstall
   - Check Node.js version (18+)
   - Verify all dependencies are installed

## License

This project is proprietary software for Osoul Company.

## Support

For support, email support@osoul.com or contact the development team.

---

**Osoul Collection Reporting System** - Comprehensive Collection Analytics Dashboard

