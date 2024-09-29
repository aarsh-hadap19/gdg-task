# GDG Task - Build a Simple Dynamic Android App that dynamically loads content (text and images) from Firebase.
This project is a Flutter application that fetches content from Firestore and displays images and text with basic animations. It uses Firebase for the backend and Flutter as the UI framework.

## Features

- Fetches data from Firestore.
- Displays an image and text for each Firestore document.
- Allows navigation through the fetched content using forward and backward buttons.
- Animated transitions when data is displayed.

## Setup Instructions

### 1. Prerequisites

Before you can run this project, you need:

- Flutter installed on your machine. Follow the official guide [here](https://flutter.dev/docs/get-started/install).
- Firebase project set up and Firestore database created.
- A Firestore collection named `content` with documents containing `text` and `url` fields.

### 2. Firebase Setup

To configure Firebase for this project:

1. **Create a Firebase Project**
    - Go to [Firebase Console](https://console.firebase.google.com/) and create a new project.

2. **Add Firebase to your Flutter App**

   - Follow the steps to add Firebase to your Flutter app:
       - **Manual Setup**:
           - Go to the Firebase Console, select your project, and follow the "Add App" wizard.
           - Download the `google-services.json` file for Android and place it in your `android/app` directory.
           - For iOS, follow the Firebase iOS setup guide and add the `GoogleService-Info.plist` file to your Xcode project.

       - **Or, use the FlutterFire CLI**:
           - Install the FlutterFire CLI using the following command:
               ```bash
               dart pub global activate flutterfire_cli
               ```
           - Once installed, configure Firebase for your Flutter project by running:
               ```bash
               flutterfire configure
               ```
           - Follow the prompts to select your Firebase project and platforms (iOS, Android, Web, etc.).
           - The CLI will automatically add the necessary configuration files for both iOS and Android.

3. **Enable Firestore**
    - In the Firebase Console, navigate to the Firestore section and enable Firestore for your project.

4. **Create a Firestore Collection**
    - Create a collection named `content`.
    - Add documents with fields:
        - `text` (string): A description or title for the content.
        - `url` (string): A direct link to an image.

### 3. Running the Project

1. Clone this repository or copy the project files.
2. Run the following commands in the project directory:
   ```bash
   flutter pub get
   flutter run
3. The app will display a button to fetch data from Firestore. Once fetched, you can navigate through the content using the forward and backward buttons.

### 4. Project Structure

- **main.dart**: Entry point of the application. Initializes Firebase and sets up the theme.
- **home_page.dart**: Main UI page where data is fetched from Firestore and displayed with animations.

### 5. Dependencies

This project uses the following dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
   cloud_firestore: ^5.4.3
   firebase_core: ^3.6.0 
   ```

### 6. Screenshots

<div align="center">
  <img src="https://github.com/aarsh-hadap19/gdg-task/blob/main/screenshots/getData.png" alt="Get Data Button" width="250" height="auto">
  <img src="https://github.com/aarsh-hadap19/gdg-task/blob/main/screenshots/img1.png" alt="Screen 1" width="250" height="auto">
</div>

<div align="center">
  <img src="https://github.com/aarsh-hadap19/gdg-task/blob/main/screenshots/img2.png" alt="Screen 2" width="250" height="auto">
  <img src="https://github.com/aarsh-hadap19/gdg-task/blob/main/screenshots/img3.png" alt="Screen 3" width="250" height="auto">
</div>
