# NCM Mobile App

A Flutter mobile application for NCM Municipal Management System.

## 🏗️ Architecture

This project follows a **Feature-First + Clean Architecture** approach with MVC elements for optimal scalability and maintainability.

### Folder Structure

```
lib/
├── config/                 # App configuration and environment setup
├── core/                   # Core functionality shared across features
│   ├── constants/          # App constants and configuration values
│   ├── services/           # Core services (API, Auth, etc.)
│   ├── theme/              # App theming and styling
│   └── utils/              # Utility functions and helpers
├── data/                   # Data layer
│   ├── models/             # Data models with Freezed
│   ├── repositories/       # Repository implementations
│   └── datasources/        # API and local data sources
├── domain/                 # Business logic layer
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Business use cases
├── features/               # Feature-specific code
│   ├── auth/               # Authentication feature
│   ├── dashboard/          # Main dashboard
│   ├── visits/             # Field worker visits
│   ├── complaints/         # Complaint management
│   └── members/            # Member management
├── shared/                 # Shared widgets and components
└── main.dart               # App entry point
```

## 🚀 Tech Stack

### State Management
- **Riverpod** - Modern, compile-safe state management

### API & Networking
- **Dio** - HTTP client for API calls
- **Retrofit** - Type-safe API client generation
- **Pretty Dio Logger** - Request/response logging

### Storage
- **Hive** - Fast local database
- **SharedPreferences** - Simple key-value storage
- **Flutter Secure Storage** - Secure token storage

### UI & Navigation
- **Material 3** - Latest Material Design
- **GoRouter** - Declarative routing
- **Gap** - Spacing widgets

### Code Generation
- **Freezed** - Immutable data classes
- **json_serializable** - JSON serialization
- **build_runner** - Code generation tool

## 🔧 Setup

1. **Prerequisites**
   ```bash
   flutter --version  # Ensure Flutter 3.16+ for Material 3
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Code** (when adding new models)
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

## 🔐 Authentication

The app uses **Laravel Sanctum** for authentication with the NCM backend API:

- Token-based authentication
- Secure storage using Flutter Secure Storage
- Auto-refresh and logout handling
- Role-based access (Member, Field Worker, Admin)

## 📱 Features

### Members
- View personal profile and membership details
- Track field worker visits
- Submit and track complaints
- Community engagement features

### Field Workers
- Manage assigned member visits
- Record visit notes and sentiment analysis
- Handle complaint assignments
- Generate activity reports

### Shared Features
- Real-time notifications
- Offline support with local caching
- Multi-municipality support
- Dark/light theme switching

## 🔗 API Integration

The app connects to the Laravel backend at:
- **Development**: `https://ncm2025.test/api`
- **Staging**: `https://staging-api.ncm.co.za/api`
- **Production**: `https://api.ncm.co.za/api`

### Key Endpoints
- `POST /login` - User authentication
- `GET /user` - Current user profile
- `GET /visits` - Field worker visits
- `POST /complaints` - Submit complaints
- `GET /complaint-categories` - Service categories

## 🎨 Design System

Based on **Material 3** with custom theming for South African municipal services:

### Colors
- **Primary**: Blue (#1976D2) - Trust and reliability
- **Secondary**: Green (#388E3C) - Growth and sustainability
- **Error**: Red (#D32F2F) - Alerts and warnings
- **Warning**: Orange (#F57C00) - Caution

### Typography
- **Font Family**: Inter (clean, modern, accessible)
- **Weights**: Regular (400), Medium (500), SemiBold (600), Bold (700)

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Generate test coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📦 Build & Deploy

### Development Build
```bash
flutter build apk --debug
flutter build ios --debug
```

### Production Build
```bash
flutter build apk --release
flutter build ios --release
flutter build web --release
```

## 🔒 Security

- API tokens stored in secure storage
- Input validation on all forms
- HTTPS-only communication
- Certificate pinning (production)
- Obfuscated release builds

## 📚 Development Guidelines

### Code Style
- Follow Dart/Flutter style guide
- Use meaningful variable names
- Add documentation for complex logic
- Prefer composition over inheritance

### State Management
- Use Riverpod providers for shared state
- Keep UI state local when possible
- Implement proper error handling
- Use freezed for immutable data

### API Integration
- Always handle network errors
- Implement retry logic for failed requests
- Cache responses when appropriate
- Show loading states for better UX

## 🤝 Contributing

1. Create feature branch: `git checkout -b feature/new-feature`
2. Follow coding standards and add tests
3. Commit changes: `git commit -m 'Add new feature'`
4. Push to branch: `git push origin feature/new-feature`
5. Create Pull Request

## 📄 License

Copyright © 2025 Motionstack Design. All rights reserved.