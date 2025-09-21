import Vapor
import Fluent

final class Project: Model, Content {
    static let schema = "projects"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "technologies")
    var technologies: [String]
    
    @Field(key: "category")
    var category: ProjectCategory
    
    @Field(key: "github_url")
    var githubURL: String?
    
    @Field(key: "app_store_url")
    var appStoreURL: String?
    
    @Field(key: "demo_url")
    var demoURL: String?
    
    @Field(key: "image_url")
    var imageURL: String?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, title: String, description: String, technologies: [String], category: ProjectCategory, githubURL: String? = nil, appStoreURL: String? = nil, demoURL: String? = nil, imageURL: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.technologies = technologies
        self.category = category
        self.githubURL = githubURL
        self.appStoreURL = appStoreURL
        self.demoURL = demoURL
        self.imageURL = imageURL
    }
}

enum ProjectCategory: String, CaseIterable, Codable {
    case swiftui = "swiftui"
    case uikit = "uikit"
    case games = "games"
    case tools = "tools"
    
    var displayName: String {
        switch self {
        case .swiftui: return "SwiftUI"
        case .uikit: return "UIKit"
        case .games: return "Games"
        case .tools: return "Tools"
        }
    }
    
    var icon: String {
        switch self {
        case .swiftui: return "📱"
        case .uikit: return "🛠️"
        case .games: return "🎮"
        case .tools: return "⚙️"
        }
    }
}

// MARK: - Migration
struct CreateProject: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("projects")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("technologies", .array(of: .string), .required)
            .field("category", .string, .required)
            .field("github_url", .string)
            .field("app_store_url", .string)
            .field("demo_url", .string)
            .field("image_url", .string)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("projects").delete()
    }
}
