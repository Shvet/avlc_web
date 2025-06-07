# 🧩 Avlc SDK

`avlc_sdk` is a Flutter SDK that helps developers integrate authentication and OTP verification features into their apps using email or phone. It includes methods for logging in users, sending OTPs, verifying OTPs, and managing access/refresh tokens via `SharedPreferences`.

---

## 🚀 Features

- User Login with Email & Password
- Send OTP to Email or Phone
- Verify OTP
- Access Token & Refresh Token Storage
- Callback-based Initialization

---

## 📦 Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  avlc_sdk: ^1.0.0
````

---

## 🛠️ Usage

### 1. Import the SDK

```dart
import 'package:avlc_sdk/avlc_sdk.dart';
```

### 2. Initialize the SDK

```dart
final avlc = AvlcWeb(
  email: "user@example.com",
  password: "yourpassword",
  onInitialize: (isInitialized, {error}) {
    if (isInitialized) {
      print("SDK Initialized and User Logged In!");
    } else {
      print("Initialization failed: $error");
    }
  },
);
```

### 3. Send OTP

```dart
avlc.sendOtp({"email": "user@example.com"}, (response) {
  print("OTP Send Response: $response");
});
```

### 4. Verify OTP

```dart
avlc.verifyOtp({"email": "user@example.com", "otp": "123456"}, (response) {
  print("OTP Verify Response: $response");
});
```

---

## 🧪 Example

```dart
AvlcWeb(
  email: "john.doe@gmail.com",
  password: "securePassword123",
  onInitialize: (isInitialized, {error}) {
    if (isInitialized) {
      print("Welcome!");
    } else {
      print("Login error: $error");
    }
  },
);
```

## 📚 API Reference

| Method                 | Description                                    |
| ---------------------- | ---------------------------------------------- |
| `loginUser()`          | Automatically called on initialization         |
| `sendOtp()`            | Sends OTP to email or phone number             |
| `verifyOtp()`          | Verifies the OTP sent to email or phone number |
| `getPlatformVersion()` | Returns the platform version (optional)        |

---

## 📄 License

MIT License. See the [LICENSE](LICENSE) file for more details.

```
