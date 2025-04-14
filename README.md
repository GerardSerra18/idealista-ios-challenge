# 🏡 Idealista iOS Challenge

Welcome to my submission for the **Idealista iOS Challenge**!  
This project is a clean, testable, and scalable UIKit-based iOS application with touches of SwiftUI, developed as part of the coding challenge provided by Idealista.

---

## 🚀 Getting Started

### ✅ Requirements

- **Xcode 16.0**
- **iOS 16 to iOS 18**

---

## 📦 Setup

Follow these steps to get the project running locally:

### 1. **Clone the Repository**

```bash
git clone https://github.com/GerardSerra18/idealista-ios-challenge.git
cd idealista-ios-challenge
```

### 2. **Checkout the Development Branch**

```bash
git checkout initialChallenge
```

> No merge is needed — all implementation was done in the `initialChallenge` branch.

### 3. **Open the Project in Xcode**

```bash
open IdealistaChallenge.xcodeproj
```

### 4. **Build & Run the App**

1. Select a simulator (e.g. iPhone 16).
2. Press `⌘R` or click ▶️ to run the app.

---

## 📱 Features

### ✅ Minimum Requirements

- Two main screens:
  - List of property ads
  - Ad detail screen
- Favorite/unfavorite ads
- Show date when the ad was favorited
- Data fetched from remote API
- Built with UIKit
- No third-party libraries used

### ✅ Bonus Features Implemented

- Pull-to-refresh on listing screen
- Dark Mode support
- SwiftUI integration (MapView)
- Localization: English, Spanish, Catalan
- Favorite ads persist using `UserDefaults`
- Favorites view with a separate screen
- Unit tests and UI tests included
- Custom splash screen

---

## 📁 Project Structure

```bash
├── Models/            # Data models
├── Views/             # UIKit views & components
├── ViewControllers/   # List, Detail, Favorites, Splash
├── ViewModels/        # MVVM logic
├── API/               # APIService
├── Utils/             # Utils functions
├── Resources/         # .strings files for 3 languages
├── Tests/             # Unit tests (ViewModels, Storage)
├── UI Tests/          # Basic launch test
└── Assets/            # Images and UI resources
```

---

## 🧪 Running Tests

The project includes both **unit tests** and **UI tests**.

### 🧪 Unit Tests

- Located in: `IdealistaChallengeTests`
- Includes:
  - `ListViewModelTests`
  - `FavoriteStorageTests`

### 📲 UI Tests

- Located in: `IdealistaChallengeUITests`
- Includes a basic launch test.

### ▶️ Run All Tests

In Xcode:

1. Select the `IdealistaChallenge` scheme.
2. Press `⌘U` to run all tests.
3. All tests will execute automatically (no additional setup required).

---

## 🌍 Localization

The app supports **three languages**:

- English (`en`)
- Spanish (`es`)
- Catalan (`ca`)

Set your simulator or device language to test different translations.

---

## 🧠 Technical Notes

- Clean MVVM architecture for scalability
- All UI built programmatically (no Storyboards)
- Reusable UI components for property features
- API designed to be extendable despite static response
- SwiftUI used for `MapView`, embedded into UIKit with `UIHostingController`

---

## ✨ Highlights

- Custom toast feedback on favorite toggle
- Adaptive layout with dynamic type and dark/light support
- Elegant and minimal UI inspired by the Idealista app

---

## 👨‍💻 Author

**Gerard Serra Rodriguez**  

---

