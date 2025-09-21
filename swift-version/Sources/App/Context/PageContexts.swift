import Vapor

// MARK: - Base Context
struct BasePageContext {
    let title: String
}

// MARK: - Home Page Context
struct HomePageContext: Content {
    let title: String
    let hero: HeroSection
    let projects: [Project]
}

struct HeroSection: Content {
    let name: String
    let title: String
    let description: String
}

// MARK: - About Page Context
struct AboutPageContext: Content {
    let title: String
    let skills: [Skill]
    let journey: String
    let goals: String
}

struct Skill: Content {
    let category: String
    let items: [String]
}

// MARK: - Projects Page Context
struct ProjectsPageContext: Content {
    let title: String
    let projects: [Project]
}

// MARK: - Blog Page Context
struct BlogPageContext: Content {
    let title: String
    let posts: [BlogPost]
}

// MARK: - Blog Post Context
struct BlogPostContext: Content {
    let title: String
    let post: BlogPost
}

// MARK: - Contact Page Context
struct ContactPageContext: Content {
    let title: String
    let email: String
    let linkedin: String
    let github: String
    let twitter: String
}
