# Meeting Room Booking Application

A comprehensive Flutter application to view meeting rooms, check available time slots, and reserve spaces seamlessly. This application connects to the EmployeeVoice endpoints to persist bookings and validates data both locally and remotely.

---

## 🚀 How to Run the Project

1. **Prerequisites**:
   Ensure you have the latest stable [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured on your machine.
   
2. **Clone and Install dependencies**:
   Run the following commands in your terminal:
   ```bash
   git clone <your-repository-url>
   cd room_task
   flutter pub get
   ```

3. **Code Generation** (Optional, if you modify models):
   This project uses `json_serializable`. If you modify any Entities or Models, you must regenerate the internal serialized files:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the App**:
   Select your emulator or physical device and run:
   ```bash
   flutter run
   ```

---

## 🛠 Libraries Used

The project relies on industry-standard packages to maintain high performance and readability:

- **State Management**: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) - Utilized heavily via the `Cubit` pattern for elegant asynchronous UI state reactions.
- **Networking API**: [`dio`](https://pub.dev/packages/dio) - A powerful HTTP client used for handling Base URLs, query parameters, timeouts, and JSON interceptors.
- **Dependency Injection**: [`get_it`](https://pub.dev/packages/get_it) - Decouples our logic by establishing a service locator to inject UseCases and Cubits across the app safely.
- **Serialization**: [`json_serializable`](https://pub.dev/packages/json_serializable) & [`json_annotation`](https://pub.dev/packages/json_annotation) - Used alongside `build_runner` for completely type-safe backend JSON parsing.
- **Responsiveness**: [`flutter_screenutil`](https://pub.dev/packages/flutter_screenutil) - To guarantee the UI scales symmetrically across varying screen sizes without rigid pixel layouts.
- **Animations & Aesthetics**: 
  - [`flutter_animate`](https://pub.dev/packages/flutter_animate) - Built-in tweening to provide premium feeling cascade sliders and fade effects.
  - [`google_fonts`](https://pub.dev/packages/google_fonts) - Provides the dynamic typography (`Outfit` and `Inter`) for a clean modern interface.
- **Feedback Alerts**: [`cherry_toast`](https://pub.dev/packages/cherry_toast) - Beautiful, non-blocking floating toasts for conveying validation and server errors.

---

## 🧠 Technical Decisions Made

1. **Clean Architecture Paradigm**:
   Organized the project symmetrically into `Domain`, `Data`, and `Presentation` layers. This strict structural separation cleanly detaches the UI logic from the network endpoints. It guarantees the application can easily scale, or endpoints swapped out, without affecting the core views.

2. **Cubit over Full BLoC**:
   Due to the straightforward nature of Form submissions and List GET requests (lacking complex intersecting events), `Cubit` provided exactly the granular state emission needed (Loading -> Loaded -> Error) without boilerplate overhead.

3. **Centralized API Error Parsing**:
   Instead of exposing generic HTTP errors inside widgets, we inject an `ApiErrorHandler` deeply inside the remote data source. If our server fails validation (e.g., specific null constraints return code 400), the handler catches `DioExceptions`, dynamically navigates the JSON exception arrays, and extracts exact field messages as `ServerFailure` structures ensuring the UI is consistently localized.

4. **Fail-Safe Booking Validation**:
   - **Locally**: Form buttons are heavily clamped by dynamic reactive validators. Using customized exact `DateTime.parse()` conversions negates faulty validation overlap comparisons before a request is even fired. Avoids polling the server pointlessly.
   - **Remotely**: Network GET caching loops were carefully evaded by depending on robust local array `.add()` mutation, keeping data in absolute harmony.

---

## ⏱ Approximate Time Spent

**Approximate time spent to design, architect, develop, and polish:** ~3-4 Hours.
