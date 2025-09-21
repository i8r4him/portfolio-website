import Vapor
import Fluent

final class BlogPost: Model, Content {
    static let schema = "blog_posts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "slug")
    var slug: String
    
    @Field(key: "excerpt")
    var excerpt: String
    
    @Field(key: "content")
    var content: String
    
    @Field(key: "category")
    var category: BlogCategory
    
    @Field(key: "tags")
    var tags: [String]
    
    @Field(key: "read_time")
    var readTime: Int // in minutes
    
    @Field(key: "featured")
    var featured: Bool
    
    @Field(key: "published")
    var published: Bool
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, title: String, slug: String, excerpt: String, content: String, category: BlogCategory, tags: [String], readTime: Int, featured: Bool = false, published: Bool = true) {
        self.id = id
        self.title = title
        self.slug = slug
        self.excerpt = excerpt
        self.content = content
        self.category = category
        self.tags = tags
        self.readTime = readTime
        self.featured = featured
        self.published = published
    }
}

enum BlogCategory: String, CaseIterable, Codable {
    case swift = "swift"
    case swiftui = "swiftui"
    case ios = "ios"
    case architecture = "architecture"
    case testing = "testing"
    case tools = "tools"
    
    var displayName: String {
        switch self {
        case .swift: return "Swift"
        case .swiftui: return "SwiftUI"
        case .ios: return "iOS"
        case .architecture: return "Architecture"
        case .testing: return "Testing"
        case .tools: return "Tools"
        }
    }
    
    var color: String {
        switch self {
        case .swift: return "#ff6b35"
        case .swiftui: return "#4fc3f7"
        case .ios: return "#00bcd4"
        case .architecture: return "#9c27b0"
        case .testing: return "#4caf50"
        case .tools: return "#ff9800"
        }
    }
}

// MARK: - Migration
struct CreateBlogPost: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("blog_posts")
            .id()
            .field("title", .string, .required)
            .field("slug", .string, .required)
            .field("excerpt", .string, .required)
            .field("content", .string, .required)
            .field("category", .string, .required)
            .field("tags", .array(of: .string), .required)
            .field("read_time", .int, .required)
            .field("featured", .bool, .required)
            .field("published", .bool, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .unique(on: "slug")
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("blog_posts").delete()
    }
}
