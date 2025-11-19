# Mini Lead Manager

A lightweight Flutter application for managing sales leads with local persistence using Hive.

## Features

- **Lead Management**: Create, view, edit, and delete leads
- **Status Tracking**: Track leads through their lifecycle (New, Contacted, Converted, Lost)
- **Filtering**: Filter leads by status for quick access
- **Local Storage**: Offline-first architecture using Hive for fast local data persistence
- **Material Design 3**: Modern UI following Material Design 3 guidelines

## Tech Stack

- **Flutter SDK**: ^3.9.2
- **State Management**: Provider package for reactive state updates
- **Local Database**: Hive for lightweight, fast NoSQL storage
- **UI Components**: Material 3 with custom theming

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- iOS Simulator / Android Emulator / Physical device

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Paras-kash/mini_lead_manager.git
cd mini_lead_manager
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point, Hive initialization
├── models/
│   └── lead.dart            # Lead data model with Hive adapters
├── providers/
│   └── leads_provider.dart  # Business logic and state management
└── screens/
    ├── home_screen.dart     # Main list view with filtering
    ├── lead_form_screen.dart # Create/edit lead form
    └── lead_detail_screen.dart # Lead details and quick actions
```

## Usage

1. **Add a Lead**: Tap the floating action button or the "+" icon in the app bar
2. **View Details**: Tap any lead card to see full details
3. **Update Status**: Use the dropdown in the detail view to change lead status
4. **Filter Leads**: Use the filter chips at the top of the home screen
5. **Edit/Delete**: Use the icons in the detail view's app bar

## Architecture

The app follows a clean architecture pattern:

- **Models**: Plain Dart classes with Hive type adapters for serialization
- **Providers**: ChangeNotifier-based state management for reactive UI updates
- **Screens**: Stateless widgets that consume provider state

Hive adapters are manually implemented to avoid build_runner dependency conflicts.

## License

This project is developed for educational purposes.
