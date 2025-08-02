# Task Manager App

A beautiful and functional task management application built with Flutter and Firebase. This app allows users to create, edit, delete, and mark tasks as complete with a modern, intuitive interface.

## Features

- ✨ **Beautiful Modern UI** - Clean, responsive design with Material 3 components
- 📝 **Task Management** - Create, edit, and delete tasks
- ✅ **Task Completion** - Mark tasks as complete/incomplete
- 🔄 **Real-time Updates** - Live synchronization with Firebase
- 📱 **Cross-platform** - Works on Android, iOS, Web, and Desktop
- 🎨 **Custom Theme** - Purple-based color scheme with Google Fonts
- 📅 **Date Tracking** - Automatic creation and completion date tracking
- 🗑️ **Swipe to Delete** - Intuitive swipe gestures for task deletion
- 🚨 **Priority System** - Mark tasks as high priority with red indicators
- 🔍 **Smart Filtering** - Filter tasks by status and priority
- 🎯 **Visual Priority Indicators** - Red dots for high priority tasks
- 📊 **Task Statistics** - Easy filtering for different task states

## Screenshots

*Screenshots will be added after the app is running*

## Tech Stack

- **Frontend**: Flutter 3.7+
- **Backend**: Firebase Firestore
- **Authentication**: Firebase Auth (ready for future implementation)
- **UI Components**: Material 3, Google Fonts, Flutter Slidable
- **State Management**: StreamBuilder for real-time updates

## Prerequisites

Before running this app, make sure you have:

- Flutter SDK (3.7.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase project set up
- Git

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd week_3
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

1. **Create a Firebase Project**:
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project or use an existing one

2. **Enable Firestore Database**:
   - In Firebase Console, go to Firestore Database
   - Click "Create Database"
   - Choose "Start in test mode" for development
   - Select a location for your database

3. **Configure Firebase in your app**:
   - The `firebase_options.dart` file should already be configured
   - If not, run: `flutterfire configure`

### 4. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point and theme configuration
├── firebase_options.dart     # Firebase configuration
├── models/
│   ├── task.dart            # Task data model
│   └── task_filter.dart     # Task filter enum
├── services/
│   └── firebase_service.dart # Firebase CRUD operations
├── screens/
│   └── home_screen.dart     # Main task list screen
└── widgets/
    ├── task_card.dart       # Individual task display widget
    ├── add_task_dialog.dart # Add/edit task dialog
    └── filter_dropdown.dart # Filter dropdown widget
```

## Usage

### Adding a Task
1. Tap the floating action button (+) or the add icon in the app bar
2. Enter task title (required) and description (optional)
3. Tap "Add Task" to save

### Editing a Task
1. Tap on any task card
2. Modify the title or description
3. Tap "Update" to save changes

### Marking Tasks Complete
1. Tap the circular checkbox on the left side of any task
2. The task will be marked as complete with visual feedback

### Deleting Tasks
1. Swipe left on any task card
2. Tap the red delete button that appears

### Setting Task Priority
1. When creating or editing a task, check the "High Priority" checkbox
2. High priority tasks will display a red dot indicator
3. Use the filter dropdown to view only high priority tasks

### Filtering Tasks
1. Use the filter dropdown at the top of the screen
2. Choose from:
   - **All Tasks**: Shows all tasks
   - **Completed Tasks**: Shows only completed tasks
   - **Uncompleted Tasks**: Shows only pending tasks
   - **High Priority Tasks**: Shows only high priority tasks

## Customization

### Theme Colors
The app uses a purple-based theme. To customize colors, modify the `ColorScheme.fromSeed()` in `main.dart`:

```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0xFF6750A4), // Change this color
  brightness: Brightness.light,
),
```

### Fonts
The app uses Google Fonts (Poppins). To change fonts, update the `textTheme` in `main.dart`:

```dart
textTheme: GoogleFonts.poppinsTextTheme(), // Change to your preferred font
```

## Testing

The app includes comprehensive error handling and loading states. Test the following scenarios:

- ✅ Adding tasks with and without descriptions
- ✅ Editing existing tasks
- ✅ Marking tasks as complete/incomplete
- ✅ Deleting tasks via swipe gesture
- ✅ Setting and managing task priorities
- ✅ Filtering tasks by different criteria
- ✅ Network connectivity issues
- ✅ Empty state when no tasks exist
- ✅ Filter state when no tasks match criteria

## Future Enhancements

- [ ] User authentication
- [ ] Task categories/tags
- [ ] Due dates and reminders
- [ ] Dark mode support
- [ ] Offline support
- [ ] Task search functionality
- [ ] Task sharing
- [ ] Data export/import
- [ ] Task statistics and analytics
- [ ] Multiple priority levels
- [ ] Task templates
- [ ] Bulk operations

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any issues or have questions:

1. Check the Firebase Console for any configuration issues
2. Ensure all dependencies are properly installed
3. Verify your Flutter version is compatible
4. Check the debug console for error messages



**Note**: This app is designed for educational purposes and demonstrates modern Flutter development practices with Firebase integration.
