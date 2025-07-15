# Weather App

A modern, cross-platform Flutter application for searching locations and viewing detailed weather forecasts. This app leverages clean architecture, BLoC state management, persistent storage, and beautiful UI elements for a smooth user experience.

---

## 📁 File Structure

```
weather_app/
│
├── android/                  # Android native code
├── ios/                      # iOS native code
├── linux/                    # Linux native code
├── macos/                    # macOS native code
├── windows/                  # Windows native code
├── web/                      # Web support
├── assets/                   # Images, Lottie animations, etc.
├── lib/
│   ├── data/
│   │   ├── api_client.dart           # HTTP client abstraction
│   │   ├── api_endpoints.dart        # API endpoint constants
│   │   ├── model/                    # Data models (Weather, Location, etc.)
│   │   ├── offline_storage/          # SharedPreferences helpers
│   │   └── remote_data_source/       # API data source implementations
│   ├── domain/
│   │   ├── bloc/                     # BLoC classes, events, states
│   │   └── use_cases/                # Use case abstractions
│   ├── helper/                       # Utilities (colors, dialogs, text, etc.)
│   ├── view/
│   │   ├── weather_screen.dart       # Main weather UI
│   │   └── widgets/                  # Shared widgets (e.g., loaders)
│   └── main.dart                     # App entry point
├── test/                     # Unit and widget tests
├── pubspec.yaml              # Dependencies & assets
└── README.md                 # Project documentation
```

---

## 🌐 APIs Used

- **Weather Forecast**: [`https://api.open-meteo.com/v1/forecast`](https://open-meteo.com/)
- **Geocoding/Location Search**: [`https://geocoding-api.open-meteo.com/v1/search`](https://open-meteo.com/)

APIs are accessed via the `ApiClient` class in `lib/data/api_client.dart`.

---

## 🏗️ State Management

- **BLoC Pattern**: Uses [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) for robust, scalable state management.
- All business logic is handled in `lib/domain/bloc/` and consumed in the UI layer.

---

## 💾 Persistent Storage

- **SharedPreferences** via `shared_preferences` package for storing last searched location and user preferences.
- See: `lib/data/offline_storage/location_preference.dart`

---

## ⚙️ How to Run the App

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd weather_app
   ```
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Run the app**
   - For Android/iOS:
     ```bash
     flutter run
     ```
   - For Web:
     ```bash
     flutter run -d chrome
     ```
   - For Desktop:
     ```bash
     flutter run -d windows  # or macos/linux
     ```

---

## 📦 Key Dependencies

- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) - State management
- [`http`](https://pub.dev/packages/http) - REST API calls
- [`shared_preferences`](https://pub.dev/packages/shared_preferences) - Persistent storage
- [`lottie`](https://pub.dev/packages/lottie) - Animations
- [`intl`](https://pub.dev/packages/intl) - Date formatting
- [`fluttertoast`](https://pub.dev/packages/fluttertoast) - Toast notifications

See `pubspec.yaml` for the full list and versions.

---

## ✨ Features

- Search for locations and view recent searches
- Fetch and display current weather and forecasts
- Smooth, animated UI with Lottie
- Offline persistence of last location
- Responsive design for mobile, web, and desktop

---

## 🛠️ Architecture & Conventions

- **Clean Architecture**: Separation of data, domain, and presentation layers
- **Reusable Widgets**: All UI components are modular and reusable
- **Constants & Helpers**: Centralized in `lib/helper/`

---

## 📢 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License

[MIT](LICENSE)

---

## 🙏 Credits

- [Open-Meteo](https://open-meteo.com/) for free weather and geocoding APIs.
- Flutter & Dart teams for the amazing framework and language.

---

Feel free to reach out for any questions or contributions!
