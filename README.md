# crypto_app

A Flutter-based cryptocurrency tracker application using **CoinGecko API**.

## Features

- Track real-time prices of various cryptocurrencies.
- Cross-platform support: Android, iOS, Web, macOS, Windows, and Linux.
- Modern Flutter UI.
- Easy to extend with additional coins or features.

![Group 427319145](https://github.com/user-attachments/assets/4459b45c-68b7-46fc-958f-d691d91fa0c9)

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter)
- Android Studio or Xcode for mobile builds

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/crypto_app.git
   cd crypto_app
   ```

2. Install dependencies:
   ```sh
   flutter pub get
   ```

3. Run the app:
   ```sh
   flutter run
   ```

## Project Structure

- `lib/` - Main Dart source code for the Flutter app.
- `android/` - Android-specific configuration and code.
- `ios/` - iOS-specific configuration and code.
- `web/` - Web-specific configuration.
- `macos/`, `windows/`, `linux/` - Desktop platform support.
- `pubspec.yaml` - Project metadata and dependencies.

## Android Configuration

- Application ID: `com.example.crypto_app`
- Minimum SDK version: Defined in `android/app/build.gradle`
- Main activity: `android/app/src/main/AndroidManifest.xml`

## macOS Configuration

- Bundle Identifier: `com.example.cryptoApp`
- Product name: `crypto_app`
- See [`macos/Runner/Configs/AppInfo.xcconfig`](macos/Runner/Configs/AppInfo.xcconfig)

## Building for Release

- Android: Update signing configs in [`android/app/build.gradle`](android/app/build.gradle)
- iOS/macOS: Update bundle identifiers and provisioning profiles as needed

## License

[MIT](LICENSE) (add your license file if needed)

---

> This project was bootstrapped with Flutter. For more information, see the [Flutter documentation](https://flutter.dev/docs).
