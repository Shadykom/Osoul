# Osoul Modern Reporting System

A comprehensive Islamic Finance Analytics Dashboard built with React + Vite, featuring bilingual support (English/Arabic) and modern UI components.

## Features

- **Executive Dashboard** - Key performance indicators and financial metrics
- **Portfolio Analytics** - Investment portfolio breakdown and analysis
- **Sharia Compliance** - Islamic finance compliance monitoring
- **Customer Analytics** - Customer insights and satisfaction metrics
- **Operations** - Application processing pipeline and efficiency metrics
- **Reports** - Comprehensive reporting system

## Key Highlights

- ✅ **Bilingual Support** - Full English and Arabic language support with RTL layout
- ✅ **Responsive Design** - Works seamlessly on desktop and mobile devices
- ✅ **Interactive Charts** - Built with Recharts for dynamic data visualization
- ✅ **Modern UI** - Clean, professional interface with Osoul Modern branding
- ✅ **Real-time Data** - Dynamic KPI cards and performance metrics

## Technology Stack

- **React 19** - Modern React with hooks
- **Vite** - Fast build tool and development server
- **Tailwind CSS** - Utility-first CSS framework
- **Recharts** - Responsive chart library
- **Lucide React** - Beautiful icon library
- **shadcn/ui** - High-quality UI components

## Brand Integration

The application features the official Osoul Modern branding:
- **Logo** - Authentic Osoul Modern logo in the sidebar
- **Colors** - Brand colors (Golden Yellow #D69E2E and Navy Blue #4A5568)
- **Typography** - Professional Arabic and English typography
- **Icons** - Custom financial and analytics icons

## Getting Started

### Prerequisites
- Node.js 18+ 
- pnpm (recommended) or npm

### Installation
```bash
# Install dependencies
pnpm install

# Start development server
pnpm run dev

# Build for production
pnpm run build

# Preview production build
pnpm run preview
```

## Deployment on Vercel

### Option 1: Vercel CLI
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy to Vercel
vercel

# Follow the prompts to configure your project
```

### Option 2: GitHub Integration
1. Push your code to a GitHub repository
2. Connect your GitHub account to Vercel
3. Import the repository in Vercel dashboard
4. Vercel will automatically detect the Vite configuration
5. Deploy with one click

### Option 3: Drag & Drop
1. Run `pnpm run build` to create the `dist` folder
2. Go to [vercel.com](https://vercel.com)
3. Drag and drop the `dist` folder to deploy

## Project Structure

```
osoul-reporting-system/
├── public/                 # Static assets
├── src/
│   ├── assets/            # Images and static files
│   │   └── osoul-logo.png # Osoul Modern logo
│   ├── components/        # Reusable components
│   ├── App.jsx           # Main application component
│   ├── App.css           # Global styles
│   └── main.jsx          # Application entry point
├── package.json          # Dependencies and scripts
├── vite.config.js        # Vite configuration
├── vercel.json           # Vercel deployment config
└── README.md             # This file
```

## Configuration

The application includes:
- **Responsive breakpoints** for mobile, tablet, and desktop
- **Dark/light mode support** via Tailwind CSS
- **RTL layout support** for Arabic language
- **Optimized bundle** with code splitting

## Browser Support

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## License

This project is proprietary software developed for Osoul Modern.

---

**Osoul Modern Reporting System** - Islamic Finance Analytics Dashboard

