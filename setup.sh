#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Osoul Collection Reporting System Setup${NC}"
echo -e "${GREEN}========================================${NC}"

# Check prerequisites
echo -e "\n${YELLOW}Checking prerequisites...${NC}"

# Check Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}Node.js is not installed. Please install Node.js 18+ first.${NC}"
    exit 1
fi

# Check PostgreSQL
if ! command -v psql &> /dev/null; then
    echo -e "${RED}PostgreSQL is not installed. Please install PostgreSQL 14+ first.${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Prerequisites check passed${NC}"

# Backend setup
echo -e "\n${YELLOW}Setting up backend...${NC}"
cd backend

# Install backend dependencies
echo "Installing backend dependencies..."
npm install

# Copy environment file
if [ ! -f .env ]; then
    cp .env.example .env
    echo -e "${YELLOW}Please edit backend/.env with your database credentials${NC}"
    echo "Press Enter to continue after editing..."
    read
fi

# Create database
echo "Creating database..."
createdb osoul_reporting 2>/dev/null || echo "Database already exists"

# Run migrations
echo "Running database migrations..."
npm run db:migrate

# Seed database
echo "Seeding database with sample data..."
npm run db:seed

# Start backend
echo -e "${GREEN}✓ Backend setup complete${NC}"
echo "Starting backend server..."
npm run dev &
BACKEND_PID=$!

# Frontend setup
echo -e "\n${YELLOW}Setting up frontend...${NC}"
cd ..

# Install frontend dependencies
echo "Installing frontend dependencies..."
npm install

# Create frontend .env
if [ ! -f .env ]; then
    echo "VITE_API_URL=http://localhost:5000/api/v1" > .env
fi

# Start frontend
echo -e "${GREEN}✓ Frontend setup complete${NC}"
echo "Starting frontend server..."
npm run dev &
FRONTEND_PID=$!

echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}Setup Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "\nBackend running at: ${YELLOW}http://localhost:5000${NC}"
echo -e "Frontend running at: ${YELLOW}http://localhost:5173${NC}"
echo -e "\n${YELLOW}Default Login Credentials:${NC}"
echo -e "Admin: admin@osoul.com / password123"
echo -e "Manager: manager@osoul.com / password123"
echo -e "Collector: collector1@osoul.com / password123"
echo -e "Viewer: viewer@osoul.com / password123"
echo -e "\nPress Ctrl+C to stop both servers"

# Wait for interrupt
trap "kill $BACKEND_PID $FRONTEND_PID; exit" INT
wait