# AssetFlow — Enterprise Asset & Resource Management System

Built for Odoo Hackathon 2026.

## Problem Statement
AssetFlow digitizes how organizations track, allocate, and maintain physical
assets and shared resources — departments, employee directory, asset
lifecycle, allocation & transfer, resource booking, maintenance workflow,
audit cycles, and reporting.

## Tech Stack
- **Frontend:** React (Vite) + TailwindCSS
- **Backend / DB / Auth:** Supabase (Postgres + Auth + Realtime + Storage)
- **Charts:** Recharts
- **QR Codes:** qrcode.react

## Team
- Uvesh Mansuri (Lead) — Auth, Organization Setup
- Nilay P Mahant — Asset Registration, Allocation & Transfer
- Bittu Agarwal — Booking, Maintenance, Dashboard

## Getting Started

```bash
npm install
cp .env.example .env   # then fill in your Supabase URL + anon key
npm run dev
```

## Environment Variables
Create a `.env` file (never commit this) with:

```
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## Project Structure
```
src/
  supabaseClient.js   # Supabase client init
  App.jsx             # Root component / routing
  main.jsx            # Entry point
  index.css           # Tailwind directives
```

## Database
Schema is created directly in the Supabase SQL Editor (see project docs /
team notes). Core tables: departments, asset_categories, employees, assets,
allocations, bookings, maintenance_requests, notifications.

## Roles
- **Admin** — org setup, promotes employees to Department Head / Asset Manager
- **Asset Manager** — registers/allocates assets, approves transfers & maintenance
- **Department Head** — approves department allocations, books resources
- **Employee** — views own assets, books resources, raises maintenance requests
