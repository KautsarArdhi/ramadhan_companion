# 📱 Ramadhan Companion

A smart Islamic companion app built with Flutter that provides real-time prayer schedules, fasting tracking, and spiritual engagement features.

---

## 🚀 Overview

Ramadhan Companion is designed to help users stay mindful during Ramadan and daily prayers by providing:

- 📍 Automatic location detection
- 🕌 Real-time prayer schedule (based on GPS)
- ⏳ Live countdown to the next prayer
- 🧠 Clean architecture with feature-based structure
- ⚡ Reactive state management using Riverpod

This project follows an Agile 6-day sprint development approach.

---

## 🏗 Architecture

The app uses a **feature-based layered architecture**:
lib/
├── core/
│ └── utils/
│ └── prayer_time_helper.dart
│
├── features/
│ └── prayer_time/
│ ├── data/
│ │ ├── model/
│ │ ├── service/
│ │ └── location_service.dart
│ │
│ ├── provider/
│ └── view/
│
└── main.dart


### Layers Explained

- **Service Layer** → External systems (GPS & API)
- **Provider Layer** → State orchestration (Riverpod)
- **UI Layer** → Presentation logic
- **Helper Layer** → Pure business logic (time calculation)

---

## 🛠 Tech Stack

- Flutter
- Riverpod (State Management)
- Dio (HTTP Client)
- Geolocator (GPS access)
- intl (Date & time formatting)
- Aladhan API (Prayer time source)

---

## 🧠 Core Features Implemented

### 1️⃣ Location Integration
- Permission handling
- GPS retrieval
- Exception-safe async flow

### 2️⃣ Prayer API Integration
- Dynamic date-based API call
- JSON parsing into strongly-typed model
- Error handling & resilience

### 3️⃣ State Management
- Immutable state with `StateNotifier`
- `copyWith` pattern
- Reactive UI updates

### 4️⃣ Business Logic
- Next prayer detection
- Automatic rollover to next day (Fajr)
- Time difference calculation

### 5️⃣ Live Countdown
- Timer lifecycle handling
- Safe disposal to prevent memory leaks
- Real-time UI synchronization

---

## 📊 Agile Development Approach

This project was developed using a structured 6-day sprint approach:

| Sprint | Focus |
|--------|-------|
| 1 | Prayer Engine Foundation |
| 2 | Hero UI Design |
| 3 | Data Enrichment |
| 4 | Fasting Interaction |
| 5 | Navigation & Structure |
| 6 | Smart Features (AI / Notification) |

---

## ⚙️ How It Works

1. App retrieves user location via Geolocator
2. Sends latitude & longitude to Aladhan API
3. Parses response into `PrayerTimeModel`
4. Determines next prayer via helper logic
5. Starts real-time countdown timer
6. UI reacts automatically via Riverpod

---

## 🔥 Engineering Challenges Solved

- Avoiding side-effects inside `build()` method
- Managing Timer lifecycle safely
- Handling asynchronous permission flow
- Separating business logic from UI layer
- Preventing state override issues in copyWith

---

## 📌 Future Improvements

- Hijriyah date integration
- Fasting streak system
- Local persistence (SharedPreferences)
- Push notifications for prayer time
- AI-powered spiritual reminders
- Play Store deployment

---

## 👤 Author

Developed as a structured Flutter learning & portfolio project using modern development practices.
