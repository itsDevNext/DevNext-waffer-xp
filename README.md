# Waffer XP

Waffer XP is a gamified savings application that transforms saving money into an engaging and rewarding experience. Users create savings goals, track their progress, earn XP, unlock achievements, and complete challenges to build consistent financial habits.

---

## Features

- User Authentication
- Savings Goal Management
- Progress Tracking:
  - Progress bars
- XP & Level System:
  - Milestone celebrations
  - Recovery missions
- Achievement Badges
- Weekly Challenges
- Personalized Dashboard
- Notifications

---

## Technology Stack

### Frontend
- Flutter
- Dart
- Lottie

### Backend
- Supabase
- PostgreSQL

### Design
- Figma

---

## Project Structure

```text
DevNext-waffer-xp/
│
├── README.md
├── .gitignore
│
├── docs/
│   └──  technical-documentation.pdf
│
├── frontend/
│   ├── pubspec.yaml
│   ├── analysis_options.yaml
│   ├── README.md
│   │
│   ├── android/
│   ├── ios/
│   ├── web/
│   ├── linux/
│   ├── macos/
│   ├── windows/
│   ├── test/
│   │
│   ├── assets/
│   │   ├── fonts/
│   │   ├── icons/
│   │   ├── images/
│   │   └── lottie/
│   │
│   └── lib/
│       │
│       ├── main.dart
│       │
│       ├── app/
│       │   ├── app.dart
│       │   ├── router.dart
│       │   └── theme.dart
│       │
│       ├── core/
│       │   ├── constants/
│       │   ├── services/
│       │   ├── utils/
│       │   └── widgets/
│       │
│       ├── features/
│       │   │
│       │   ├── auth/
│       │   │   ├── controller/
│       │   │   ├── data/
│       │   │   └── view/
│       │   │       ├── screens/
│       │   │       └── widgets/
│       │   │
│       │   ├── dashboard/
│       │   │   ├── controller/
│       │   │   ├── data/
│       │   │   └── view/
│       │   │       ├── screens/
│       │   │       └── widgets/
│       │   │
│       │   ├── savings_goals/
│       │   │   ├── controller/
│       │   │   ├── data/
│       │   │   └── view/
│       │   │       ├── screens/
│       │   │       └── widgets/
│       │   │
│       │   ├── progress_tracking/
│       │   │   ├── controller/
│       │   │   ├── data/
│       │   │   └── view/
│       │   │       ├── screens/
│       │   │       └── widgets/
│       │   │
│       │   ├── gamification/
│       │   │   ├── controller/
│       │   │   ├── data/
│       │   │   └── view/
│       │   │       ├── screens/
│       │   │       └── widgets/
│       │   │
│       │   ├── profile/
│       │   │   ├── controller/
│       │   │   ├── data/
│       │   │   └── view/
│       │   │       ├── screens/
│       │   │       └── widgets/
│       │   │
│       │   └── notifications/
│       │       ├── controller/
│       │       ├── data/
│       │       └── view/
│       │           ├── screens/
│       │           └── widgets/
│       │
│       └── shared/
│           ├── models/
│           ├── widgets/
│           ├── extensions/
│           └── enums/
│
└── backend/
    └── supabase/
```

---

## Getting Started

### Clone the repository

```bash
git clone https://github.com/DevNext-Team/DevNext-waffer-xp.git
```

### Frontend

```bash
cd frontend
flutter pub get
flutter run
```

### Backend (Supabase)

```bash
cd backend
supabase start
```

---



## Team

- Lamyaa Alghaihab
- Thikera Ahmed
- Yara Alrasheed

---

## License

This project was developed by DevNext Team for Amad Hackathon.
