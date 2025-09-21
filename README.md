# Ibrahim's Swift Portfolio Website

A modern, Swift-based portfolio website built with Vapor framework, featuring a blog, project showcase, and contact form. This is a full-stack Swift application showcasing iOS development skills.

## 🚀 Features

- **Swift Backend**: Built entirely with Swift using Vapor framework
- **Database-Driven**: PostgreSQL database for blog posts and projects
- **REST API**: Full API endpoints for all data
- **Template Engine**: Leaf templating for dynamic HTML generation
- **Responsive Design**: Mobile-first responsive design
- **Dark Theme**: Professional dark mode styling
- **Full-Stack Swift**: Demonstrates both iOS and web development skills

## 📝 Migration Note

This project was migrated from a static HTML version to a full Swift/Vapor application. The static version has been removed to focus on the Swift-based implementation.

## 🛠️ Tech Stack

- **Backend**: Swift + Vapor
- **Database**: PostgreSQL
- **Templating**: Leaf
- **Frontend**: HTML + CSS + JavaScript
- **Deployment**: Vapor Cloud / Heroku / AWS

## 📋 Prerequisites

- Swift 5.9+
- PostgreSQL
- Xcode (for development)

## 🚀 Quick Start

### 1. Install Dependencies

```bash
# Clone the repository
cd swift-version

# Install Swift dependencies
swift package resolve
```

### 2. Database Setup

```bash
# Install PostgreSQL (macOS)
brew install postgresql
brew services start postgresql

# Create database
createdb portfolio_website
```

### 3. Environment Configuration

Create a `.env` file:

```bash
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=your_username
DB_PASSWORD=your_password
DB_NAME=portfolio_website

# Or use DATABASE_URL for production
# DATABASE_URL=postgres://username:password@host:port/database
```

### 4. Run the Application

```bash
# Run migrations
swift run App migrate

# Start the server
swift run App serve
```

The website will be available at `http://localhost:8080`

## 📁 Project Structure

```
swift-version/
├── Sources/
│   └── App/
│       ├── App.swift              # Main application setup
│       ├── Models/                # Database models
│       │   ├── Project.swift      # Project model
│       │   └── BlogPost.swift     # Blog post model
│       └── Context/               # Page contexts
│           └── PageContexts.swift # View contexts
├── Resources/
│   ├── Views/                     # Leaf templates
│   │   ├── base.leaf             # Base template
│   │   ├── index.leaf            # Homepage
│   │   ├── about.leaf            # About page
│   │   ├── projects.leaf         # Projects page
│   │   ├── blog.leaf             # Blog listing
│   │   ├── blog-post.leaf        # Individual blog post
│   │   └── contact.leaf          # Contact page
│   └── Public/                   # Static assets
│       ├── assets/
│       │   ├── css/              # Stylesheets
│       │   ├── js/               # JavaScript
│       │   └── images/           # Images
├── Package.swift                 # Swift package configuration
└── README.md                    # This file
```

## 🎨 Customization

### Adding Projects

Projects are stored in the database. You can add them via:

1. **Database directly**:
```sql
INSERT INTO projects (title, description, technologies, category, github_url) 
VALUES ('My App', 'Description here', '["SwiftUI", "Core Data"]', 'swiftui', 'https://github.com/username/repo');
```

2. **API endpoint** (when implemented):
```bash
curl -X POST http://localhost:8080/api/projects \
  -H "Content-Type: application/json" \
  -d '{"title": "My App", "description": "Description", "technologies": ["SwiftUI"], "category": "swiftui"}'
```

### Adding Blog Posts

Similar to projects, blog posts are database-driven:

```sql
INSERT INTO blog_posts (title, slug, excerpt, content, category, tags, read_time, featured, published) 
VALUES ('My Post', 'my-post', 'Excerpt here', 'Full content...', 'swift', '["Swift", "iOS"]', 5, true, true);
```

## 🌐 API Endpoints

- `GET /api/projects` - Get all projects
- `GET /api/blog` - Get all blog posts
- `POST /api/contact` - Submit contact form

## 🚀 Deployment

### Vapor Cloud (Recommended)

```bash
# Install Vapor CLI
brew install vapor/tap/vapor

# Login to Vapor Cloud
vapor cloud login

# Deploy
vapor cloud deploy
```

### Heroku

```bash
# Create Heroku app
heroku create your-portfolio-app

# Add PostgreSQL addon
heroku addons:create heroku-postgresql:hobby-dev

# Set environment variables
heroku config:set DATABASE_URL=$(heroku config:get DATABASE_URL)

# Deploy
git push heroku main
```

### AWS/DigitalOcean

Use Docker or direct server deployment with your preferred cloud provider.

## 🔧 Development

### Adding New Routes

```swift
// In App.swift routes function
app.get("my-new-page") { req async throws -> View in
    let context = MyPageContext(title: "My Page")
    return try await req.view.render("my-page", context)
}
```

### Adding New Models

```swift
// Create new model file
final class MyModel: Model, Content {
    static let schema = "my_models"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    // Add migration
    struct CreateMyModel: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("my_models")
                .id()
                .field("name", .string, .required)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema("my_models").delete()
        }
    }
}
```

## 📝 License

© 2025 Ibrahim. All rights reserved.

---

**Built with ❤️ using Swift and Vapor**
