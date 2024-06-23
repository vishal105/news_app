# News App

## Overview

The News App is a Flutter application that displays a list of news articles. Users can sign in and out, view a list of news articles, and view the details of each article. The app uses Firebase for authentication, analytics, and crash reporting.

## Features

- User authentication (sign in and sign out) using Firebase
- Display a list of news articles
- View detailed information about a news article
- Firebase Analytics integration to track user interactions
- Firebase Crashlytics for crash reporting
- Responsive design for mobile, tablet, and desktop layouts

## Project Structure and Architecture

The project follows the Clean Architecture pattern with BLoC for state management.

# Project Structure

This project follows a modular structure to maintain a clean and scalable architecture. Below is an overview of the project structure:

## Core
Contains common utilities, themes, and configurations used across the app.

- **error**: Custom exceptions and failure classes.
- **network**: API client and network-related utilities.
- **services**: Firebase services for analytics.
- **themes**: Theme configurations.
- **usecases**: Base use case classes.
- **utils**: Utility classes and responsive design helper.

## Data
Contains data layer implementations and related components.

- **datasources**: Remote data sources.
- **models**: Data models.
- **repositories**: Repository implementations.
- **di**: Dependency injection setup.

## Domain
Contains domain layer abstractions and use cases.

- **entities**: Entity classes.
- **repositories**: Repository interfaces.
- **usecases**: Use cases.

## Presentation
Contains UI and BLoC (Business Logic Component) files.

- **blocs**: BLoC implementations.
- **pages**: Page widgets.
- **widgets**: Reusable widgets.
- **router**: App router for navigation.

## Test
Contains unit and widget tests.

- **domain**: Domain layer tests.
- **presentation**: Presentation layer tests.


### Key Components

- **BLoC (Business Logic Component)**: Used for state management.
- **Firebase Authentication**: Used for user authentication.
- **Firebase Analytics**: Used to track user interactions.
- **Firebase Crashlytics**: Used for crash reporting.
- **Dio**: Used for making API requests.
- **GetIt**: Used for dependency injection.

## Setup Instructions

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase CLI: [Install Firebase CLI](https://firebase.google.com/docs/cli#install_the_firebase_cli)

### Step-by-Step Setup

1. **Prepare your workspace:**

    - Install the Firebase CLI and log in:

      ```bash
      firebase login
      ```

    - Install the Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

    - Create a Flutter project:

      ```bash
      flutter create news_app
      cd news_app
      ```

2. **Install and run the FlutterFire CLI:**

    - Activate the FlutterFire CLI:

      ```bash
      dart pub global activate flutterfire_cli
      ```

    - At the root of your Flutter project directory, run:

      ```bash
      flutterfire configure --project=news-e15d4
      ```

      This automatically registers your per-platform apps with Firebase and adds a `lib/firebase_options.dart` configuration file to your Flutter project.

3. **Install dependencies:**

   ```bash
   flutter pub get
   
4. **Configure environment variables:**

Create a .env file in the root directory of the project with the following content:

    ```bash
      BASE_URL=https://newsapi.org
      API_KEY=your_news_api_key
    ```

5. **Initialize Firebase:**
    ```bash
   firebase init
   ```
   
   Choose the features you want to set up (e.g., Firestore, Authentication).
   Follow the on-screen instructions to complete the setup.

6. **Run the project:**
    ```bash
   flutter run
    ```
   **Running Tests**
   To run the unit tests, use the following command:
     ```bash
   flutter test
    ```

## Assumptions and Design Decisions
- **Clean Architecture:** The project follows the Clean Architecture principles to separate concerns and improve maintainability.
- **BLoC for State Management:** BLoC was chosen for state management to provide a clear separation between the business logic and the UI.
- **Firebase Integration:** Firebase was chosen for authentication, analytics, and crash reporting due to its ease of integration and rich feature set.
- **Dio for API Requests:** Dio was chosen for making API requests due to its powerful and flexible features, such as interceptors.
- **GetIt for Dependency Injection:** GetIt was chosen for dependency injection to manage dependencies and improve testability.

**Notes**
Ensure that you have a valid API key for the News API and update the `.env` file accordingly.
This project uses Firebase for various services; ensure your Firebase project is properly set up with the necessary configurations.
If you encounter any issues or have any questions, please feel free to open an issue on the GitHub repository or contact the project maintainers.

if Test cases not work properly run below command
      ```bash
      flutter pub run build_runner build
      ```   