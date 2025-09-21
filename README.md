# Ibrahim's Swift Portfolio Website

A modern, dark-themed portfolio website showcasing iOS development skills with Swift and SwiftUI.

## 🏗️ Project Structure

```
portfolio-website/
├── index.html              # Main homepage
├── README.md              # Project documentation
├── assets/                # Static assets
│   ├── css/              # Stylesheets
│   │   ├── style.css     # Main styles (dark theme)
│   │   └── blog.css      # Blog-specific styles
│   ├── js/               # JavaScript files
│   │   ├── main.js       # Main functionality
│   │   ├── projects.js   # Project filtering
│   │   └── blog.js       # Blog interactions
│   ├── images/           # Images and photos
│   └── icons/            # Icon assets
├── pages/                # Main website pages
│   ├── about.html        # About page
│   ├── projects.html     # Projects showcase
│   ├── blog.html         # Blog listing page
│   └── contact.html      # Contact page
├── blog/                 # Blog content
│   ├── posts/            # Individual blog posts
│   │   └── swiftui-state-management.html
│   └── templates/        # Blog post templates
└── components/           # Reusable components
    ├── header.html       # Navigation header
    └── footer.html       # Site footer
```

## 🚀 Features

### Design
- **Dark Mode**: Professional dark theme with cyan accents
- **Responsive**: Mobile-first design that works on all devices
- **Modern UI**: Clean, minimalist design with smooth animations

### Portfolio
- **Interactive Projects**: Filter projects by technology (SwiftUI, UIKit, Games)
- **Project Showcase**: Beautiful project cards with hover effects
- **Technology Tags**: Clear indication of technologies used

### Blog
- **Swift-Focused Content**: Tutorials and insights about iOS development
- **Code Syntax Highlighting**: Beautiful code blocks with copy functionality
- **Category Filtering**: Organize posts by Swift, iOS, Architecture, etc.
- **Reading Progress**: Visual progress indicator while reading

### Technical
- **Vanilla HTML/CSS/JS**: No frameworks, fast loading
- **SEO Optimized**: Proper meta tags and semantic HTML
- **Accessibility**: WCAG compliant design
- **Performance**: Optimized images and minimal dependencies

## 🛠️ Development

### Local Development
```bash
# Start local server
python3 -m http.server 8000

# Or using Node.js
npx serve .

# Or using PHP
php -S localhost:8000
```

### Adding New Blog Posts
1. Create new HTML file in `blog/posts/`
2. Use the existing blog post structure
3. Update navigation if needed
4. Commit and push changes

### Customizing Content
- **Profile Picture**: Add your photo as `assets/images/profile.jpg`
- **Projects**: Update `pages/projects.html` with your real projects
- **Contact Info**: Update contact details in `pages/contact.html`
- **About**: Customize your story in `pages/about.html`

## 📱 Technologies Showcased

- **Swift**: Core programming language
- **SwiftUI**: Modern declarative UI framework
- **UIKit**: Traditional iOS UI framework
- **Core Data**: Data persistence
- **Combine**: Reactive programming
- **Firebase**: Backend services
- **SpriteKit**: Game development

## 🎨 Color Scheme

- **Primary**: #00bcd4 (Cyan)
- **Secondary**: #4fc3f7 (Light Blue)
- **Background**: #0a0a0a (Dark)
- **Text**: #e0e0e0 (Light Gray)
- **Cards**: #1e1e1e (Dark Gray)

## 📄 License

© 2025 Ibrahim. All rights reserved.

## 🤝 Contributing

This is a personal portfolio website. Feel free to use it as inspiration for your own portfolio!

---

**Live Site**: [https://i8r4him.github.io/portfolio-website/](https://i8r4him.github.io/portfolio-website/)
