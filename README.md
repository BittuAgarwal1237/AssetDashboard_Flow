# AssetFlow — Enterprise Asset & Resource Management System

Built for Odoo Hackathon 2026.

## Problem Statement
AssetFlow digitizes how organizations track, allocate, and maintain physical
assets and shared resources. It covers departments and employee directory
setup, asset lifecycle tracking, allocation & transfer (with conflict
handling), shared resource booking (with overlap validation), a maintenance
approval workflow, structured audit cycles, and a KPI dashboard with
notifications.

## Tech Stack
- **Frontend:** Flutter (single codebase, responsive for web/mobile)
- **Backend / DB / Auth:** Supabase (Postgres + Auth + Realtime + Storage)
- **Charts:** fl_chart
- **QR Codes:** qr_flutter

## Features
- Role-based accounts: Admin, Asset Manager, Department Head, Employee
- Non-self-elevating signup — new accounts start as Employee only
- Asset lifecycle: Available, Allocated, Reserved, Under Maintenance, Lost,
  Retired, Disposed
- Allocation conflict detection with Transfer Request flow
- Resource booking with time-slot overlap validation
- Maintenance approval workflow (Pending → Approved → In Progress → Resolved)
- Audit cycles with auditor assignment and auto-generated discrepancy reports
- Real-time dashboard KPIs and notifications

## Getting Started

### Prerequisites
- Flutter SDK installed ([flutter.dev](https://flutter.dev))
- A Supabase project (Postgres + Auth) already set up

### Setup
```bash
flutter pub get
```

Copy the config template and fill in your Supabase credentials:
```bash
cp lib/config/supabase_config.example.dart lib/config/supabase_config.dart
```

Edit `lib/config/supabase_config.dart` with your project's URL and anon key
(found in Supabase → Settings → API Keys). This file is gitignored and
should never be committed.

### Run
```bash
flutter run -d chrome   # for web
flutter run              # for connected device/emulator
```

## Project Structure
```
lib/
  main.dart                          # App entry point, Supabase init
  config/
    supabase_config.example.dart     # Template (committed)
    supabase_config.dart             # Actual credentials (gitignored)
  models/                            # Data models
  screens/                           # UI screens
```

## Database
Schema is created directly in the Supabase SQL Editor. Core tables:
departments, asset_categories, employees, assets, allocations, bookings,
maintenance_requests, notifications.

## Roles
- **Admin** — org setup, promotes employees to Department Head / Asset Manager
- **Asset Manager** — registers/allocates assets, approves transfers & maintenance
- **Department Head** — approves department allocations, books resources
- **Employee** — views own assets, books resources, raises maintenance requests
