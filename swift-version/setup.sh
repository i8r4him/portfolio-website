#!/bin/bash

# Swift Portfolio Website Setup Script
echo "🚀 Setting up Swift Portfolio Website..."

# Check if Swift is installed
if ! command -v swift &> /dev/null; then
    echo "❌ Swift is not installed. Please install Swift first:"
    echo "   https://swift.org/download/"
    exit 1
fi

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
    echo "📦 Installing PostgreSQL..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install postgresql
            brew services start postgresql
        else
            echo "❌ Homebrew not found. Please install PostgreSQL manually."
            exit 1
        fi
    else
        echo "❌ Please install PostgreSQL manually for your system."
        exit 1
    fi
fi

# Create database
echo "🗄️ Creating database..."
createdb portfolio_website 2>/dev/null || echo "Database already exists or user doesn't have permission to create databases."

# Install Swift dependencies
echo "📦 Installing Swift dependencies..."
swift package resolve

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "⚙️ Creating .env file..."
    cat > .env << EOF
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=$(whoami)
DB_PASSWORD=
DB_NAME=portfolio_website

# Development settings
APP_ENV=development
EOF
    echo "✅ Created .env file. Please update database credentials if needed."
fi

# Copy assets from main website
echo "📁 Copying assets from main website..."
if [ -d "../assets" ]; then
    cp -r ../assets Resources/Public/
    echo "✅ Assets copied successfully."
else
    echo "⚠️ Assets directory not found. Please copy assets manually to Resources/Public/"
fi

# Run migrations
echo "🔄 Running database migrations..."
swift run App migrate

echo "✅ Setup complete!"
echo ""
echo "🚀 To start the server:"
echo "   swift run App serve"
echo ""
echo "🌐 Website will be available at: http://localhost:8080"
echo ""
echo "📝 Next steps:"
echo "   1. Update .env file with your database credentials"
echo "   2. Add your projects and blog posts to the database"
echo "   3. Customize the templates in Resources/Views/"
echo "   4. Deploy to Vapor Cloud, Heroku, or your preferred platform"
