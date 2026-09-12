# Libya Medical Record System

### _Your Health, Your Vault — Empowering Patients, Doctors & Institutions Across Libya_

[![Flutter](https://img.shields.io/badge/Flutter-3.24.0-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5.0-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Provider](https://img.shields.io/badge/Provider-6.x-2196F3?style=for-the-badge)](https://pub.dev/packages/provider)
[![Material 3](https://img.shields.io/badge/Material%203-Design-6200EA?style=for-the-badge&logo=material-design&logoColor=white)](https://m3.material.io)
[![License](https://img.shields.io/badge/License-Proprietary-red?style=for-the-badge)](#-license)

<div align="center">

![Libya Medical Record System](https://via.placeholder.com/200x80/10B981/FFFFFF?text=LIBYA+HEALTH)

**🏥 A Unified Healthcare Ecosystem Built for Libya**

_Securely manage your records, share access with doctors, and oversee clinical teams_

</div>

---

## 🌟 Overview

> **"Ownership of medical data belongs to the patient. Expertise belongs to the doctor. Management belongs to the institution."**

Libya Medical Record System is a **multi-role** healthcare platform designed to modernize clinical workflows in Libya. It bridges the gap between private vaults and professional oversight, ensuring that medical history is portable, secure, and actionable.

The app serves three primary pillars of healthcare:

| Role | Core Workflow |
|------|-------------------|
| 👤 **Patient** | Manage health records, track vitals, and grant secure access to doctors via QR/Tokens |
| 🩺 **Doctor** | Manage a clinical patient directory, review shared history, and log new clinical entries |
| 🏛️ **Institution** | Manage clinical teams, process join requests, and maintain a professional facility presence |

---

## ⚡ Key Features

<table>
<tr>
<td align="center">🛡️<br/><strong>Secure Patient Vault</strong><br/>Comprehensive history including Vitals, Meds, Lab Tests, and visual Dental mapping</td>
<td align="center">📋<br/><strong>Clinical Oversight</strong><br/>Doctor-specific portal to manage patients and contribute new records securely</td>
<td align="center">🏢<br/><strong>Facility Dashboard</strong><br/>Premium Facebook-style management for hospital owners to oversee medical staff</td>
<td align="center">🌍<br/><strong>Bilingual M3</strong><br/>Full English & Arabic support with almarai typography and emerald clinical theme</td>
</tr>
</table>

---

## 🏗️ Architecture

This project follows a **feature-first**, layered structure — ensuring high scalability and clean separation between clinical data and UI logic.

```
📱 Libya Medical Record System
├── 🎨 Presentation Layer    (Flutter + Material 3)
├── 💼 State Layer            (Provider — reactive data flows)
├── 🔄 Data Layer               (Hive + Repository Pattern)
└── 🔧 Core Infrastructure       (Premium Sliver headers, unified input decorators)
```

### 📂 Folder Structure

```
lib/
├── core/
│   └── shared/
│       ├── theme/              # AppColors (Emerald Green), AppTextStyles (Almarai)
│       └── widgets/            # EmptyStateWidget, fieldDecoration, SliverPageHeader...
│
├── data/
│   ├── models/                 # DentalRecord, VitalModel, UserRegistration...
│   └── providers/              # Clinical state management (DashboardProvider)
│
├── features/
│   ├── my_records/             # Patient Vault (Vitals, Meds, Lab, Radiology...)
│   ├── patients/               # Doctor Portal (Patient Directory, Clinical Oversight)
│   ├── institutions/           # Facility Portal (Owned Institutions, Team Management)
│   ├── experts/                # Medical Expert Discovery & Search
│   └── auth/                   # Registration, OTP, & Profile setup
│
└── main.dart
```

---

## 🎨 Design System

### 🌈 Brand Palette (Emerald Clinical)

```dart
// Primary — Emerald Green
static const Color primary        = Color(0xFF10B981);
static const Color primaryDark    = Color(0xFF059669);
static const Color primarySurface = Color(0xFFD1FAE5);

// Semantic — Clinical Indicators
static const Color success        = Color(0xFF16A34A); // Normal results
static const Color warning        = Color(0xFFF59E0B); // Abnormal results
static const Color error          = Color(0xFFEF4444); // Critical/Allergy
static const Color info           = Color(0xFF3B82F6); // Resolved conditions
```

### 📱 Typography

Built on **[Almarai](https://fonts.google.com/specimen/Almarai)** — specifically chosen for its high legibility in clinical reports across both **Arabic and Latin** scripts.

| Style | Size | Use case |
|---|---|---|
| `displayLarge` | 32 ExtraBold | Splash / Hero headings |
| `headlineLarge` | 22 Bold | Page titles & Clinical headers |
| `titleMedium` | 16 SemiBold | Card titles & Tab labels |
| `bodyMedium` | 14 Regular | Clinical notes & Form data |
| `labelSmall` | 11 Medium | Result tags (Normal/Critical) |

---

## 🚀 Getting Started

### Prerequisites

```
Flutter 3.24.0+
Dart 3.5.0+
```

### Installation

```bash
# Clone the repository
git clone https://github.com/<your-username>/libya_medical_record_system.git
cd libya_medical_record_system

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🌍 Localization

Full **English ↔ Arabic** support with RTL awareness. Clinical terms are mapped precisely to ensure medical accuracy in both languages.

---

## 🏆 Engineering Standards

| ❌ Forbidden | ✅ Mandatory |
|---|---|
| Deeply nested UI | Modular **Sliver-based** layouts |
| Hardcoded strings | Centralized **AppRoutes** & Constants |
| Deprecated APIs | **withValues(alpha:)**, **WidgetState**, **Material 3** |
| Ad-hoc navigation | **GoRouter** with deep-linking & path parameters |

---

## 🗺️ Roadmap

- [x] Emerald Clinical Design System
- [x] Comprehensive Patient Vault (13+ Record Categories)
- [x] Interactive Dental Teeth Selector & Mapping
- [x] Doctor Patient Portal with Token-Based Access
- [x] Hospital Owner Management Dashboard (Facebook-style)
- [x] Crash-proof Deep-linking Routing
- [ ] Push Notifications for Medication Reminders
- [ ] Real-time Chat between Patients & Doctors
- [ ] Offline local-first storage with Hive

---

## 📄 License

This project is private and proprietary. All rights reserved.

---

## 👤 Author

**Anifahm Olawale**
Senior Flutter Developer

📧 [anifahmolawale@gmail.com](mailto:anifahmolawale@gmail.com)
🌐 [anifahm.com](https://anifahm.com)

---

<div align="center">

**🏥 Built with Flutter, for Libya's Healthcare Future**

_© 2026 Anifahm Olawale. All rights reserved._

</div>
