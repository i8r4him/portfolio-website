import Vapor
import Fluent
import FluentPostgresDriver
import Leaf

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure Leaf for templating
    app.views.use(.leaf)
    
    // Configure database
    if let databaseURL = Environment.get("DATABASE_URL") {
        app.databases.use(try .postgres(url: databaseURL), as: .psql)
    } else {
        // Local development database
        app.databases.use(.postgres(
            hostname: Environment.get("DB_HOST") ?? "localhost",
            port: Environment.get("DB_PORT").flatMap(Int.init(_:)) ?? 5432,
            username: Environment.get("DB_USERNAME") ?? "vapor_username",
            password: Environment.get("DB_PASSWORD") ?? "vapor_password",
            database: Environment.get("DB_NAME") ?? "vapor_database"
        ), as: .psql)
    }
    
    // Configure migrations
    app.migrations.add(CreateBlogPost())
    app.migrations.add(CreateProject())
    
    // Register routes
    try routes(app)
}

// MARK: - Routes
func routes(_ app: Application) throws {
    app.get { req async throws -> View in
        let context = HomePageContext(
            title: "Ibrahim | iOS Developer",
            hero: HeroSection(
                name: "Ibrahim",
                title: "iOS Developer & Swift Enthusiast",
                description: "I'm an aspiring iOS Developer passionate about building intuitive and user-friendly applications."
            ),
            projects: [
                Project(
                    id: UUID(),
                    title: "Task Manager Pro",
                    description: "A modern task management app with cloud sync, built entirely with SwiftUI.",
                    technologies: ["SwiftUI", "Core Data", "CloudKit"],
                    category: .swiftui,
                    githubURL: "https://github.com/i8r4him/task-manager",
                    appStoreURL: nil
                ),
                Project(
                    id: UUID(),
                    title: "Weather Forecast",
                    description: "A beautiful weather app with location-based forecasts and animated icons.",
                    technologies: ["UIKit", "Core Location", "Weather API"],
                    category: .uikit,
                    githubURL: "https://github.com/i8r4him/weather-app",
                    appStoreURL: nil
                )
            ]
        )
        return try await req.view.render("index", context)
    }
    
    app.get("about") { req async throws -> View in
        let context = AboutPageContext(
            title: "About - Ibrahim | iOS Developer",
            skills: [
                Skill(category: "Programming Languages", items: ["Swift", "Objective-C"]),
                Skill(category: "Frameworks", items: ["SwiftUI", "UIKit", "Core Data", "Core Animation"]),
                Skill(category: "Tools", items: ["Xcode", "Git", "CocoaPods", "Swift Package Manager"]),
                Skill(category: "Design", items: ["Human Interface Guidelines", "Auto Layout", "Accessibility"])
            ],
            journey: "I started my journey in iOS development with a curiosity about how mobile apps work. Since then, I've been constantly learning and improving my skills through personal projects, online courses, and real-world applications.",
            goals: "I'm actively seeking opportunities to work on exciting iOS projects, whether that's freelance work, internships, or full-time positions. I'm particularly interested in apps that solve real problems and make people's lives easier."
        )
        return try await req.view.render("about", context)
    }
    
    app.get("projects") { req async throws -> View in
        let projects = try await Project.query(on: req.db).all()
        let context = ProjectsPageContext(
            title: "Projects - Ibrahim | iOS Developer",
            projects: projects
        )
        return try await req.view.render("projects", context)
    }
    
    app.get("blog") { req async throws -> View in
        let posts = try await BlogPost.query(on: req.db)
            .sort(\.$createdAt, .descending)
            .all()
        let context = BlogPageContext(
            title: "Swift Blog - Ibrahim | iOS Developer",
            posts: posts
        )
        return try await req.view.render("blog", context)
    }
    
    app.get("blog", ":slug") { req async throws -> View in
        guard let slug = req.parameters.get("slug") else {
            throw Abort(.badRequest)
        }
        
        guard let post = try await BlogPost.query(on: req.db)
            .filter(\.$slug == slug)
            .first() else {
            throw Abort(.notFound)
        }
        
        let context = BlogPostContext(
            title: "\(post.title) - Ibrahim's Swift Blog",
            post: post
        )
        return try await req.view.render("blog-post", context)
    }
    
    app.get("contact") { req async throws -> View in
        let context = ContactPageContext(
            title: "Contact - Ibrahim | iOS Developer",
            email: "your.email@example.com",
            linkedin: "https://linkedin.com/in/your-profile",
            github: "https://github.com/i8r4him",
            twitter: "https://twitter.com/your-handle"
        )
        return try await req.view.render("contact", context)
    }
    
    // API endpoints
    app.group("api") { api in
        api.get("projects") { req async throws -> [Project] in
            return try await Project.query(on: req.db).all()
        }
        
        api.get("blog") { req async throws -> [BlogPost] in
            return try await BlogPost.query(on: req.db)
                .sort(\.$createdAt, .descending)
                .all()
        }
        
        api.post("contact") { req async throws -> HTTPStatus in
            // Handle contact form submission
            // You can integrate with email services here
            return .ok
        }
    }
}
