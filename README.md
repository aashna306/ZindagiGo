# ZindagiGo- Because Life Doesn't Pause With Age

##  About our app
Independence with a safety net—that's the Zindagi Go promise. This thoughtfully designed companion app empowers seniors to navigate modern life with confidence while keeping loved ones connected in moments that matter. From health management to entertainment, everything seniors need rests in the palm of their hand, wrapped in an interface that respects their wisdom and preserves their dignity.
Zindagi Go: Where care meets independence, and golden years truly shine.

---

## Key Features of ZindagiGo
1. **Fall Detection with SOS & Location Sharing** =>
Instant Alerts: Automatically detects falls and sends SOS alerts with real-time location sharing, ensuring quick assistance.

2. **Voice-Activated SOS for Emergencies** =>
Hands-Free Alerts: Raise emergency alerts through voice commands for faster response during critical situations.

3. **Personalized Chatbot (Multilingual & Speech-to-Text Enabled)** =>
Smart & Multilingual Assistance: Interact with an AI-driven chatbot that supports multiple languages, along with speech-to-text input, making communication  effortless in your preferred language.

4. **Image Processing** =>
Quickly scan and process images like prescriptions, making it simple to store and access important health information.

5. **Secure & Simple Login/Signup** =>
Multiple safe and easy ways to log in or sign up, with authentication designed for convenience and peace of mind.

6. **Easy-to-Use Interface** =>
User-Friendly Design: Simple navigation with large buttons and readable text, making the app highly accessible for elderly users.

7. **Built-in Torch and Zoom Functionality** =>
Enhanced Visibility: Use the built-in torch and zoom features to improve visibility in low-light situations and for easy reading.

8. **Upload & Categorize Prescriptions** =>
Smart Organization: Upload prescriptions and let the app automatically categorize and store them for easy future reference.

🔮 New Features (In Progress):

9. **Community Groups** =>
Connect with like-minded individuals, join interest-based groups, and combat loneliness through socializing within the app.

10. **Help Line Numbers** =>
Emergency numbers are given here to give fast access and they can also add those are important

11. **Location Sharing** =>
Automatic location is shared while SOS

12. **Banking Assistance** =>
Securely store pension records and access detailed

13. **Entertainment Recommendations** =>
Receive personalized suggestions for news, shows, and movies, tailored to your preferences.

14. **Fitness Tracker** =>
Track your daily steps and sleep cycle, with exercise recommendations based on your medical history for better health.

---

##  Tech Stack
- Frontend: Flutter (Dart)
- Backend: Node.js (Express)
- Database: MongoDB (User data, medical records)
- Authentication: Firebase Auth
- Storage: MongoDB (for images and user data)
- AI Integration: Google Gemini API (for prescription assistance)

---

##  Installation & Setup
### Prerequisites
- Install [Flutter](https://flutter.dev/docs/get-started/install) on your system.
- Set up a Firebase Project and enable Authentication.
- Set up MongoDB Atlas or a local MongoDB database.
- Install Node.js and run the backend server.

### Clone the Repository
git clone https://github.com/arpita-goel/ZindagiGo.git
cd ZindagiGo


### Install Dependencies
flutter pub get


### Configure Firebase
1. Download the google-services.json file from Firebase and place it in android/app/.
2. Enable Firestore Database and Storage in Firebase Console.

### Set Up Environment Variables
- Create a .env file in the root directory.
- Copy the contents of .env.example and fill in your API keys.
- Example:
  env
  MONGO_URI=your-mongodb-uri
  GEMINI_API_KEY=your-gemini-api-key
  PORT=your-backend-port
  

### Run the App
flutter run


---

##  Backend Setup
### Prerequisites
- Ensure you have Node.js installed.
- Navigate to the backend directory:
  cd backend/src
  
- Install dependencies:
  npm install
  
- Start the backend server:
  npm start
  
- Ensure the backend is running before launching the Flutter app.

---

## Emergency Number (SOS Feature) and Fall Detection
To safely test the SOS feature and fall detection without any error , change the emergency number in the codebase:
navigate to :

lib/home_page.dart

change the line at 39 and at 160  with your emergency number, you can also change country code
=> String emergencyNumber = "+91";


While in an ideal production setup, the emergency number should be stored and fetched securely from the backend for flexibility and ease of updates, we have intentionally avoided this approach during the testing phase, for the following reason......

Controlled Testing Environment

By hardcoding the emergency number in the app, we ensure that only trusted developers or testers can modify it deliberately in the code.

This creates a controlled environment, where testing of the SOS and fall detection features happens safely without triggering unintended or fake emergency calls.

Since our codebase and builds are currently shared with testers and contributors, hardcoding sensitive functionalities like the emergency number helps prevent backend exploitation.

----

## OTP Verification (login)
For the purpose of testing and demonstration, we have configured Firebase Authentication to use a test phone number and OTP

Test Phone Number: +91 1234567890

Test OTP: 111111

Reason for This Approach:

Firebase Free Tier Limitations

Firebase does not offer unlimited free SMS verifications. During development and testing, using real phone numbers could quickly exhaust the free quota.

Test numbers allow us to bypass actual SMS sending, ensuring cost-free and unlimited testing.

Avoiding Spam and Abuse
If we used real-time OTPs with dynamic phone numbers, there’s a risk of misuse or accidental spam to genuine phone numbers.

Test numbers eliminate this risk by providing a controlled environment.

Safe and Reliable Testing

Using test credentials ensures that all testers and developers can log in without needing real phone numbers.

This provides a consistent testing experience across devices and environments.


-----

## Battery Optimization
To ensure background services run properly, please disable battery optimization for this app
1. Go to Settings > Battery & Performance
2. Select Battery Optimization
3. Find "Zindagi Go" and set it to "Don't optimize"


---


##  Permissions Required
- Camera & Storage - Required for OCR-based prescription scanning.
- Microphone - Needed for voice-activated SOS feature.
- Location - Required for live location sharing with emergency contacts.
- Notification Access - Enables reminders for medications and pensions.

---

## ⚠ Troubleshooting
### Common Issues & Fixes
1. Firebase Authentication Error  
   - Ensure Firebase Auth is enabled and google-services.json is correctly placed in android/app/.
2. Backend Connection Issues  
   - Verify that MongoDB is running and that your backend is connected.
   - Double-check the IPv4 address configuration in the UserInfoPage medical records page and ChatPage.
3. Notifications Not Working  
   - Enable notifications in Firebase and check that the app has notification permissions.
4. Location Sharing Not Working  
   - Ensure location permissions are granted on the device.

---

##  Next Milestone
- Collaboration with organisations for senior citizens - for easy caretaking and management through app.
- Smartwatch Integration - Expand accessibility with wearable devices.
- Enhanced Accessibility - Voice guidance for visually impaired users.
- Offline Mode - Enable basic features without an internet connection.
  
---

##  Demo Video
[🔗 Watch the Demo](https://youtu.be/x6FV2Lsp5w0)

---

##  MVP link
 [🔗 Download APK]([https://drive.google.com/drive/folders/1IeptxeWMiKFt-LKFsUkSzY7Hls4pXYun?usp=sharing](https://drive.google.com/drive/u/1/folders/1IeptxeWMiKFt-LKFsUkSzY7Hls4pXYun))

---

## 👥 Contributors
- Team Members- Arpita Goel,
                Lakshita Gupta,
                Aashna Sharma,
                Vyomika

---

## 📞 Contact
For any queries, feel free to reach out:
📧 Email: zindagigoapp@gmail.com

---

🔹 Made with ❤ by Team Care Code
