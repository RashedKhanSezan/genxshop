# GenxShop - Premium Product Management System 🎧

GenxShop is a modern, high-performance Flutter application features a sleek "Glassmorphic" UI and an offline-first architecture to manage products and services seamlessly.

---

## ✨ Key Features

* **Premium Glassmorphic UI**: A modern dark-themed aesthetic with glassy backgrounds and soft shadows.
* **Onboarding Flow**: A smooth 3-screen introduction for new users using `PageView` and GetX.
* **Offline Caching**: Powered by **Hive**, allowing you to browse your collection even without an internet connection (perfect for those basement listening sessions!).
* **State Management**: Clean and reactive architecture using **GetX**.
* **Full CRUD**: Create, read, update, and delete products with real-time API integration.
* **Secure Auth**: Token-based authentication with persistence via SharedPreferences.

---

## 🛠️ Tech Stack

| Technology | Purpose |
| :--- | :--- |
| **Flutter** | Cross-platform UI Framework |
| **GetX** | State Management & Navigation |
| **Hive** | Lightweight NoSQL Database (Offline Cache) |
| **HTTP** | REST API Communication |
| **SharedPreferences** | Local Session Storage |
| **Dotted Border** | Custom UI Elements |

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles to ensure scalability and maintainability:

* **Data Layer**: Handles raw data through `DataSources` (Remote API & Local Hive) and `Repositories` (Logic for switching between Network/Cache).
* **Presentation Layer**: Contains `Pages` (UI), `Controllers` (Business Logic), and `Bindings` (Dependency Injection).
* **Route Management**: Centralized navigation handling in `AppPages` and `AppRoutes`.

---

## 🚀 Getting Started

### Prerequisites
* Flutter SDK (Stable)
* Dart SDK

### Installation

1.  **Clone the repository**:
    ```bash
    git clone [https://github.com/your-username/genxshop.git](https://github.com/your-username/genxshop.git)
    cd genxshop
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Generate Hive Adapters**:
    Since Hive uses code generation for performance, run the following:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the App**:
    ```bash
    flutter run
    ```
