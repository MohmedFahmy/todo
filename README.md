# 📝 ToDo App (Flutter)

A simple and intuitive **ToDo App** built with Flutter.
Users can add, update, and delete tasks, set reminders with notifications, and switch between light/dark themes. The app uses **GetX** for state management, ensuring a smooth and reactive user experience.

---

## ✨ Features

* Add, edit, and delete tasks
* Set task reminders with **local notifications**
* Dynamic **light/dark theme switching** with GetX
* Task scheduling with proper **timezone handling**
* Smooth animations for better UI/UX
* Local database support with **Sqflite**

---

## 🛠️ Packages Used

* **get** → State management & theme handling
* **get_storage** → Lightweight local storage
* **sqflite** → Local database for tasks
* **flutter_local_notifications** + **timezone** → Scheduling reminders
* **flutter_native_timezone** → Manual timezone setup (added via local path in `pubspec.yaml`)
* **google_fonts** → Custom fonts
* **flutter_svg** → Scalable vector icons
* **flutter_staggered_animations** → Smooth animations
* **date_picker_timeline** & **intl** → Date formatting & timeline picker
* **android_intent_plus** → Android-specific intents

---

## 📸 Screenshots
Dark theme
<img width="1920" height="1440" alt="770shots_so" src="https://github.com/user-attachments/assets/abe86e5c-46c0-4f21-ae70-e1a85dec0160" />


Light theme
<img width="1920" height="1440" alt="102shots_so" src="https://github.com/user-attachments/assets/3ebfd4ab-4b32-4f7a-8327-8ab6f26fa4eb" />


---

## 💡 Challenges

* Configuring **local notifications** correctly required proper timezone setup.
* Manually linking **flutter_native_timezone** helped ensure reminders fired at the correct time.
* Implementing theme switching with GetX made the UI more flexible and user-friendly.

---

## 🚀 Getting Started

1. Clone the repository

```bash
git clone https://github.com/your-username/todo-app.git
```

2. Install dependencies

```bash
flutter pub get
```

3. Run the app

```bash
flutter run
```

---

## 📌 Conclusion

This project helped me practice **state management, theming, local database handling, and notification scheduling** with Flutter.

---

### 🔗 Connect

If you like this project, don’t forget to ⭐ the repo!

