# Laundry Tracker

[![Version](https://img.shields.io/badge/version-0.2.0-blue.svg)](pubspec.yaml)
[![Platform](https://img.shields.io/badge/platform-Android%20only-green.svg)](AGENTS.md)
[![License](https://img.shields.io/badge/license-Free-brightgreen.svg)](AGENTS.md)

Laundry Tracker is a local-only, free Android application designed to track laundry washes, monitor clothing categories, handle retrieve reminders, and log discrepancy issues.

---

## Current Status: Phase 1 Completed (v0.2.0)

### Phase 1: Application Shell Checkpoint
- **Material 3 UI**: Implemented Material 3 theming with functional System, Light, and Dark modes.
- **Navigation Shell**: 4-destination NavigationBar (Home, New, Track, Settings) using IndexedStack to preserve state.
- **Home Screen**: Greeting area ("Hello Robin!"), active in-progress wash section, and completed wash summary metrics.
- **New Wash Screen**: Dedicated visual entry point with category preview.
- **Track Screen**: In-progress tracking section and expandable Completed Washes history section.
- **Settings Screen**: Functional theme switcher, version metadata, and placeholders for wash limits, issues, and reset washes.
- **Architecture**: Modular, student-friendly layered architecture without external third-party dependencies.

---

## Development Roadmap
- [x] **Phase 0**: Project Foundation (0.1.0)
- [x] **Phase 1**: Application Shell (0.2.0)
- [ ] **Phase 2**: Core Data Models & Local Persistence
- [ ] **Phase 3**: New Wash Creation & Validation
- [ ] **Phase 4**: Wash Tracking, Limits & Modal Views
- [ ] **Phase 5**: Issues, Reset Logic & Local Notifications
