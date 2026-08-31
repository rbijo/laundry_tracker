# Laundry Tracker Agent Instructions

## 1. Project Identity

Project name: Laundry Tracker

Flutter project directory name: laundry_tracker

Target platform: Android only

The application must remain completely free to build, run, and use.

No paid services, subscriptions, cloud backend, API billing, or mandatory online service may be introduced.

All application data must remain stored locally on the device unless explicitly approved otherwise.

Do not rename the application to Loondry Tracker. "Loondry Tracker" is only the development folder name.

---

## 2. Development Method

This project is developed phase by phase.

Agents MUST work only on the phase explicitly assigned to them.

Do not implement future phase functionality unless explicitly instructed.

Do not make unrelated refactors.

Do not add dependencies unless they are required by the current phase and their necessity is explained.

Before making substantial changes, inspect the existing implementation and preserve working functionality.

Prefer simple, maintainable Flutter and Dart solutions.

Do not over engineer features.

---

## 3. Android Only

The final application target is Android.

Do not implement iOS, Web, Windows, macOS, or Linux specific functionality unless explicitly required for development or testing.

Web execution may be used for UI development and testing when convenient.

Android specific functionality MUST ultimately be tested on Android.

---

## 4. Architecture

Use a modular architecture appropriate for a small but maintainable Flutter application.

Keep UI, application logic, persistence, models, and services separated.

Avoid putting business logic directly inside large widget build methods.

Prefer reusable widgets for repeated UI patterns.

The application must remain understandable to a Flutter student.

---

## 5. User Interface

Use Material 3.

The application must support:

System theme
Light theme
Dark theme

The primary navigation contains exactly four destinations:

Home
New
Track
Settings

The visual design should be clean, modern, responsive, and appropriate for an Android application.

Use cards, rounded components, appropriate spacing, clear typography, and accessible touch targets.

Do not copy another application's interface.

The concurrent wash selector will use a circular radial control inspired by thermostat style controls.

---

## 6. Core Application Rules

The application supports concurrent washes.

Concurrent wash limit:

Minimum: 1
Maximum: 30

If the number of active washes is equal to the concurrent wash limit, creation of another wash must be prevented.

If the concurrent wash limit is greater than the number of active washes, another wash may be created.

Each clothing category has a maximum quantity of 20.

Clothing categories:

Shirts
T Shirts
Jeans
Trousers
Informal Pants
Formal Pants
Undergarments
Inner Vest
Miscellaneous

Total clothing count must be calculated automatically.

Total clothing colour indication:

0 to 9: green
10 to 14: yellow
15 to 20: orange
21 or more: red

Within each range, the colour should progressively become darker as the quantity increases.

A wash date may be today or a future date.

A wash date must not be in the past.

Expected Retrieve Date must not be earlier than the Wash Date.

---

## 7. Wash Lifecycle

A new wash begins as IN PROGRESS.

An in progress wash may have its clothing quantities and wash date updated.

When Received is selected, the application must show a closeable modal or popup containing the clothing quantities.

The tracking interface must provide:

Received All
Missing Cloth

Received All moves the wash to COMPLETED.

A successfully received wash is counted as Successfully Tracked.

Missing Cloth creates an issue record containing the missing clothing information.

Issues are automatically generated from tracking actions.

Completed washes remain stored until Reset Washes is explicitly confirmed.

Completed washes must appear in an expandable section on the Track page.

---

## 8. Home Page

The Home page must display:

Hello Robin!

An In Progress section containing active wash cards.

Each active wash card must display its relevant wash date and total clothing count.

A Completed section or card must display:

Total Completed Washes
Successfully Tracked Washes

Successfully Tracked means the wash was received using Received All.

---

## 9. New Wash Page

When the concurrent wash limit has been reached, creation of a new wash must be unavailable.

Otherwise, provide a New Wash action.

The New Wash form must contain all clothing categories with:

Remove button
Editable quantity field
Add button

Quantities must remain between 0 and 20.

The form must be scrollable.

The total clothing quantity must update automatically.

The wash date must default to today's date.

The wash date must be manually editable.

Expected Retrieve Date must be available.

The Expected Retrieve Date must not be earlier than the Wash Date.

Submitting the form must persist the wash locally and make it available on the Track page.

---

## 10. Track Page

Display active washes first.

Each active wash must support:

Updating clothing quantities
Updating wash date
Received action

Received must open the tracking interface.

Received All completes the wash.

Missing Cloth creates an issue.

Completed washes appear below active washes in an expandable section.

Completed records must retain:

Wash date
Total clothing quantity
Successfully tracked status

Individual clothing quantities do not need to be retained for completed wash display.

---

## 11. Settings Page

Settings must contain:

About
Theme selection
Concurrent Wash Limit
Issues
Reset Washes

Theme selection:

System
Light
Dark

Concurrent Wash Limit uses a circular radial selector from 1 through 30.

The selector should visually resemble a thermostat style circular control.

Changing the concurrent wash limit must persist locally.

Issues must display automatically generated issue records in a closeable modal or popup interface.

Reset Washes must require confirmation.

Resetting must remove:

All active washes
All completed washes
All issue records

Resetting must not reset application settings such as theme or concurrent wash limit.

---

## 12. Notifications

Notifications must be completely free.

Use local Android notifications.

Do not introduce Firebase Cloud Messaging or another paid or cloud notification service.

When an Expected Retrieve Date arrives, show a local notification reminding the user that the wash is expected to be collected.

When a wash is successfully tracked, show a local notification.

When an issue is recorded, show a local notification.

When the concurrent wash limit is changed, show a local notification.

When washes are reset, show a local notification.

Android notification permissions and Android version requirements must be handled correctly.

Scheduled notifications must be persisted or rescheduled appropriately so that normal application restarts do not silently invalidate expected reminders.

---

## 13. Persistence

All wash, issue, and application setting data must persist locally.

The application must retain data after normal application restarts.

Do not introduce a backend.

Use the simplest reliable local persistence solution appropriate for the data.

Database or persistence technology must be selected based on reliability, read performance, write performance, maintainability, and compatibility with the current Flutter version.

Do not add a persistence dependency merely because it is popular.

---

## 14. Dependencies

Keep dependencies to the minimum necessary.

Before adding a dependency:

1. Determine whether Flutter already provides the required functionality.
2. Determine whether the dependency is actively maintained.
3. Check Android compatibility.
4. Check whether the dependency introduces unnecessary services or costs.
5. Explain why the dependency is required.

Do not upgrade unrelated dependencies.

Do not run broad dependency upgrades during feature implementation.

---

## 15. Testing

After meaningful code changes:

Run flutter analyze.

Run relevant Flutter tests.

For UI changes, run the application and verify the affected screen.

For Android specific functionality, test on Android before considering the functionality complete.

Do not claim a feature is complete if it has not been verified.

Fix errors introduced by the current change before proceeding.

---

## 16. Git Commit Rules

Git commits MUST follow the project's Git Commit Types document.

Use Conventional Commit format:

type(scope): description

Descriptions MUST use imperative mood.

Descriptions MUST be 50 characters or fewer.

Commits MUST be atomic.

Do not combine unrelated changes into one commit.

Use the appropriate commit type.

Common types:

feat
fix
docs
style
refactor
perf
test
build
ci
chore
revert
ops
security
config

Use feat for new user facing functionality.

Use fix for bug fixes.

Use perf for performance improvements.

Use docs for documentation only.

Use style for formatting without logic changes.

Use refactor for restructuring without behaviour changes.

Use test for tests.

Use build for build system or dependency changes.

Use ci for CI or CD changes.

Use chore for maintenance and tooling.

Use ops for infrastructure and deployment.

Use security for security changes.

Use config for configuration changes.

Breaking changes MUST use ! or a BREAKING CHANGE footer.

Never invent a custom commit type.

Do not create vague commits such as:

update stuff
changes
fix things
final
done
phase update

---

## 17. Semantic Versioning

The project follows Semantic Versioning 2.0.0.

During initial development, use 0.y.z versions.

Initial development release:

0.1.0

Backward compatible new functionality increments the MINOR version.

Backward compatible bug fixes increment the PATCH version.

Breaking changes increment the MAJOR version when applicable.

When the MINOR version increases, PATCH resets to 0.

Examples:

0.1.0 to 0.2.0 for a new development phase

0.2.0 to 0.2.1 for a bug fix

0.2.1 to 0.3.0 for another compatible feature phase

Do not modify an already released version.

Every released version must receive a new version number.

---

## 18. Phase Releases

Every meaningful completed development phase must have a version checkpoint.

A phase release should include:

Updated application version
Git tag
GitHub Release when the repository is available
Relevant README version information when appropriate
Release notes describing the completed functionality

Do not create a release for documentation only, formatting only, or other changes that do not constitute a meaningful release milestone.

Agents MUST NOT arbitrarily choose a release version.

The version must be determined according to the project's Semantic Versioning rules and the current phase plan.

---

## 19. Agent Git Permissions

Agents may inspect Git status, history, and diffs.

Agents MUST NOT push to a remote repository, create a GitHub Release, or delete branches unless explicitly instructed.

Agents MUST NOT rewrite published Git history.

Agents MUST NOT force push.

Agents MUST NOT amend a pushed commit.

Before creating a release or version tag, the agent must verify that the working tree is clean and that the intended version is correct.

---

## 20. Phase Completion

A phase is complete only when:

The assigned functionality is implemented.

The implementation satisfies the phase requirements.

flutter analyze passes.

Relevant tests pass.

The application runs successfully.

Relevant functionality has been manually verified.

Git changes are reviewed.

Commit messages follow the project commit rules.

The appropriate version checkpoint has been recorded when the phase constitutes a release milestone.

Do not declare a phase complete merely because the code compiles.

---

## 21. Scope Discipline

Never modify files unrelated to the assigned task.

Never remove existing functionality unless explicitly required.

Never replace an existing architecture merely because another approach is preferred.

Before a large architectural change, explain the reason and wait for approval.

If requirements are ambiguous, stop and ask for clarification rather than making a significant assumption.

If a requested change conflicts with these instructions, identify the conflict before modifying the project.

---

## 22. Current Development Status

Current project version:

0.1.0

Current phase:

Phase 0: Project Foundation

Next planned phase:

Phase 1: Application Shell

Do not implement Phase 1 until explicitly instructed.