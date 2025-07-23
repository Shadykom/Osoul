#!/bin/bash

echo "🚀 Osoul Collection System - Supabase Setup"
echo "=========================================="
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file..."
    cp .env.supabase.example .env
    echo "✅ .env file created"
    echo ""
    echo "⚠️  Please update the .env file with your Supabase credentials:"
    echo "   - VITE_SUPABASE_URL"
    echo "   - VITE_SUPABASE_ANON_KEY"
    echo ""
else
    echo "✅ .env file already exists"
fi

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
npm install

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Update .env with your Supabase credentials"
echo "2. Run the SQL scripts in your Supabase dashboard:"
echo "   - supabase-migration.sql (creates tables)"
echo "   - supabase-demo-users.sql (creates demo data)"
echo "3. Create demo users in Supabase Auth"
echo "4. Run 'npm run dev' to start the application"
echo ""
echo "📖 See SUPABASE_INTEGRATION.md for detailed instructions"