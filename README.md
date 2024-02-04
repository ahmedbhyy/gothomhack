# GardienLock : GothomHackApp
![DALL·E 2024-02-04 09 42 47 - (1)](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/24b804b8-c9f9-41c9-9cc9-daea08422c8e)


GuardianLock: Face Recognition Car Security 🚗👤 Enhance your car's security with GuardianLock, a Flutter app using advanced face recognition. Only authorized users can access the vehicle, offering an accessible user interface. 🛡️🔐

## Camera Structure

The camera integrated into the smart car security system boasts cutting-edge features that center around driver identification through facial recognition. This component employs AI algorithms to analyze facial features for secure and accurate driver authentication. Enhanced by an ESP32 card, the camera establishes a real-time link to the car facilitating swift communication and data transfer. The focal point of this camera lies in its ability to make rapid decisions based on facial recognition results. Moreover, its synchronization with the mobile application enhances user control.

## Sensor System

In this innovative car security system, a sensor installed in the car door detects its opening, signaling the camera upon detection. Subsequently, the camera sends a notification to the vehicle owner. Following the notification, the camera enters a 5-second waiting period during which it actively scans for a facial recognition match. If no face is detected within this timeframe, an alarm is triggered for an additional 5 seconds. Should the camera still fail to identify a face during this second phase, a remote cutoff signal is initiated, implementing a secure measure to safeguard the vehicle.

## Prototype screenshot
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/7e288ef8-9c46-4ddd-a2d7-64a6e972337f)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/c788aa8e-4ad9-4739-8aed-309dfef479c9)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/ecf1ef95-9ffd-418d-8b01-2d05e4fb8d80)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/13cc7522-e9d9-4b3f-b5c6-4738470c2186)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/47c80b2f-4f09-4977-8399-5b7f8053c6f7)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/cc0bb1a4-35da-4a84-9cd3-ff348cab820a)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/b4d328dd-8fff-45ae-9e21-8b8aa29e37e8)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/a932be0f-025c-40b7-8faf-56608eedc9a8)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/d8765403-866c-4094-8b5b-e2d101b63d0a)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/b6e259fc-40da-46c4-ad8c-c37c504714ae)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/e0a983e7-092a-4abe-b7ee-30c7ec07e870)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/e3b67084-e331-4197-b12d-1bbdab032d1b)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/e59611d9-f352-488b-88ab-693241635530)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/50e2092c-ddcb-4e8b-8743-765d2c4699e1)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/1b042f45-3510-4e4d-b937-4d8b310a148c)
![image](https://github.com/ihebbettaibe/GothomHackApp/assets/152183684/f1f6f3e9-cb88-4d4f-9cc8-23ca2475b6ff)

# Mobile Application

In this mobile application, each user has a personalized profile containing information about their vehicles, authorized drivers, car details, and other features. The application is seamlessly connected to a camera. In the case of unauthorized facial recognition, the camera triggers a call to the owner's phone number and sends an alert through the app. The owner then has the option to permit the driver's access or activate a cutoff feature managed by the ESP32 microcontroller on the onboard system. Notably, the microcontroller includes a timer, so when a cutoff occurs, it has a predetermined duration, providing an added layer of control over the security measures implemented for the vehicle.

# Setup Instructions for GuardianLock

## Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK: The latest stable version.
- Dart SDK: Usually comes with Flutter SDK.
- Android Studio or VS Code: For development.
- Git: For version control.

## Environment Setup

1. **Install Flutter SDK**: Follow the instructions on the Flutter install page for your operating system.
2. **Update your path**: Ensure that the Flutter SDK and Dart SDK binaries are in your PATH.
3. **Verify Installation**: Run `flutter doctor` in the terminal/command prompt to check if any dependencies are missing.

## Project Setup

1. **Clone the Repository**: Clone this repository to your local machine using `git clone [[repository-url](https://github.com/ihebbettaibe/GothomHackApp)]`.
2. **Navigate to Project Directory**: Change directory into the project root `cd [gothomhack]`.
3. **Get Dependencies**: Run `flutter pub get` to fetch the project dependencies. This are all the Dependencies 
  cupertino_icons: ^1.0.2
  get: ^4.6.6
  google_fonts: ^6.1.0
  animate_do: ^3.3.2
  firebase_core: ^2.25.0
  cloud_firestore: ^4.15.0
  firebase_storage: ^11.6.1
  firebase_auth: ^4.17.0
  google_sign_in: ^6.2.1
  awesome_dialog: ^3.2.0
  image_picker: ^1.0.7
  mobile_scanner: ^3.5.6
  flutter_popup_menu_button: ^0.0.1+5
  local_auth: ^2.1.8
  geolocator: ^10.1.0
  latlong2: ^0.9.0
  http: ^1.2.0
  flutter_map: ^6.1.0
5. **Open in IDE**: Open the project in your preferred IDE (Android Studio/VS Code).

## Running the Application

1. **Select Target Device**: Ensure you have an emulator running or a device connected.
2. **Run the App**: Execute `flutter run` in the terminal/command prompt or use the run button in your IDE.

## Building for Production

- **Android**: Run `flutter build apk` to generate an APK.
- **iOS**: Run `flutter build ios` to prepare the iOS app for release. Note: You need to use Xcode for further iOS app configurations.
- **Web**: Run `flutter build web` to generate a release build for the web.

## Figma Link
https://www.figma.com/file/cYMcicmdISRFZuQvnwQbuw/khaliha-aala-lah?type=design&node-id=3-92&mode=design&t=4FfaKTnnBuVPiZYx-0

**Firebase Setup**: If your app uses Firebase, follow the setup instructions for each platform on the Firebase console.


## Troubleshooting

If you encounter any issues, first ensure all environment variables are set correctly and that you have the latest versions of Flutter and Dart SDKs. Refer to the Flutter official documentation or the issue tracker for more help.
