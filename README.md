md
# Disease Tracker App

A mobile application built with Flutter to track and visualize disease-related data, providing users with global and country-specific statistics, nearby medical center information, and personalized profile management.
 
## Key Features & Benefits

*   **Global and Country-Specific Disease Statistics:** Access up-to-date data on disease cases, recoveries, and deaths worldwide or for specific countries.
*   **Nearby Medical Center Locator:** Find and locate nearby hospitals and medical centers using integrated map functionality.
*   **User Authentication and Profile Management:** Secure user accounts with login/signup, account verification, and profile personalization.
*   **Interactive Maps:** Visualize medical centers and disease-related information on interactive maps.
*   **Zoomable Widgets:** Zoom into specific charts and information using zoomable widgets for better viewing experience.
*   **User-Friendly Interface:** Designed with intuitive navigation and a clean, modern user interface.

## Prerequisites & Dependencies

Before you begin, ensure you have the following installed:

*   **Flutter SDK:** Version 3.0 or higher
*   **Dart SDK:** Version 2.17 or higher
*   **Android Studio or Xcode:**  For running the app on emulators/simulators or real devices.
*   **Git:** For version control

The project also relies on the following Dart packages, which are managed by Flutter's `pubspec.yaml`:

*   `google_sign_in`:  For Google Sign-In authentication.
*   `google_maps_flutter`:  For integrating Google Maps into the application.
*   `http`: For making network requests.
*   `flutter_zoom_widget`: For implementing zoomable widgets.
*   (And other packages as defined in `pubspec.yaml`)

## Installation & Setup Instructions

1.  **Clone the Repository:**

    ```bash
    git clone https://github.com/saqibcheema/Disease_Tracker_App.git
    cd Disease_Tracker_App
    ```

2.  **Install Dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Configure API Keys (if necessary):**

    If the application requires any API keys (e.g., Google Maps API), configure them appropriately in the relevant files.  Refer to the API provider's documentation for specific instructions.  This often involves adding your API key to the `android/app/src/main/AndroidManifest.xml` and `ios/Runner/Info.plist` files.

4.  **Run the Application:**

    Connect a physical device or start an emulator/simulator and run the app:

    ```bash
    flutter run
    ```

    Choose the target device (Android or iOS).

## Usage Examples

### Accessing Global Statistics:

The app retrieves global disease statistics from a data source (likely an API). The relevant code can be found in `lib/UI/main.dart` (or a similar UI file). The data is then displayed on the Global Statistics Page.

### Finding Nearby Medical Centers:

The `lib/UI/Maps` directory contains the code for displaying medical centers on a Google Map. The app uses the `google_maps_flutter` package and may use the `NearestHospital.dart` model to represent hospital data. The exact mechanism for retrieving nearby hospitals will vary depending on the API used.

```dart
// Example of using Google Maps in Flutter (Conceptual)
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ...

GoogleMap(
  initialCameraPosition: CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  ),
  markers: Set.from([
    Marker(
      markerId: MarkerId('hospital1'),
      position: LatLng(37.7833, -122.4067),
      infoWindow: InfoWindow(title: 'Hospital A'),
    ),
  ]),
);
```

**Note:** The exact implementation may differ in the project.

## 📸 App Screenshots

### 🔹 SignUp Screen
![SignUp Screen](images/Signup%20Page.jpg)

### 🔹 Account Verification Screen
![SignUp Screen](images/Account%20Verification%20Page.jpg)

### 🔹 Home Screen
![Home Screen](images/Dashboard%20screen.jpg)

### 🔹 Global Stats Page
![Global Stats](images/Global%20Statistices%20Page.jpg)

### 🔹 Country Selector
![Country Selector](images/Country%20Selection%20screen.jpg)

### 🔹 Nearby Hospitals Map
![Nearby Hospitals](images/Medical%20Centers%20Screen.jpg)

### 🔹 User Profile
![User Profile](images/Profile%20Page.jpg)

## Configuration Options

The app can be configured through various settings:

*   **API URLs:** The URLs for disease data APIs are defined in `lib/API/apis_Urls.dart`. You can modify these URLs to point to different data sources.
*   **App Colors:**  The application's color scheme is defined in `lib/Components/app_colors.dart`.  You can customize these colors to match your preferences.
*   **Font Styles:** Font styles are defined in `lib/Components/text_style.dart`.  You can modify these to change the app's typography.
*   **Build Flavors:** You can create different build flavors for development, staging, and production environments.  This allows you to use different API endpoints and settings for each environment.  This configuration is generally done using Flutter's build configurations.

## Contributing Guidelines

We welcome contributions to the Disease Tracker App! To contribute:

1.  **Fork the repository.**
2.  **Create a new branch for your feature or bug fix:** `git checkout -b feature/your-feature-name` or `git checkout -b fix/your-fix-name`
3.  **Make your changes and commit them with descriptive commit messages.**
4.  **Push your branch to your forked repository:** `git push origin feature/your-feature-name`
5.  **Create a pull request (PR) to the main repository.**

Please ensure your code adheres to the project's coding style and includes appropriate tests.  Your PR will be reviewed by a maintainer.
 
## Acknowledgments

*   Flutter Team
*   Google Maps Platform
*   Data providers for disease statistics (To be added once known)
*   Contributors to the project
