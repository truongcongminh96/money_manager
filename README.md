
# 💰 Flutter Money Manager

A simple Flutter app to manage personal transactions, built as an example to demonstrate the **Cubit / Bloc pattern** in Flutter.

## 🎯 Purpose

This project was created to:

- Practice the **Bloc architecture** using `Cubit`
- Apply **clean and modular folder structure**
- Demonstrate working with local transaction data (create, display)

## 🧱 Project Structure

```
lib/
├── common/              # Enums and utilities
├── models/              # Data models (e.g. Transaction)
├── repositories/        # Simulated API/data layers
├── widgets/             # UI widgets and Cubit logic
└── main.dart            # App entry point
```

## 🧪 Features

- 📋 Add and view transaction entries
- 🧠 Manage state using `Cubit` from `flutter_bloc`
- 🧰 Includes `.toMap()` / `.fromMap()` methods for model conversion
- 🗂 Organized using clean architecture principles

## 🛠️ Technologies Used

- ✅ Flutter (3.29 stable)
- ✅ Dart
- ✅ flutter_bloc (Cubit)
- ✅ VS Code or Android Studio

## 🚀 Getting Started

```bash
flutter pub get
flutter run
```

## 📸 Screenshots

> You can add UI screenshots here later for better visualization.

## 📦 Suggestions for Improvement

- Add persistent storage (e.g. Hive or Firebase)
- Add edit/delete functionality for transactions
- Improve UI design with animations or custom themes

## 👨‍💻 Author

- Name: **Truong Cong Minh**
- Purpose: Built for practicing Flutter + Bloc and sharing with the developer community.

## 📄 License

This project is licensed under the MIT License.
