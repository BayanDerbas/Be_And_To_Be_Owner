import 'dart:html' as html;
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static String? fcm_Token;

  Future<void> initNotifications() async {
    // 1️⃣ Register Service Worker (required for background messages on web)
    if (html.window.navigator.serviceWorker != null) {
      try {
        await html.window.navigator.serviceWorker!.register(
          'firebase-messaging-sw.js',
        );
        print('✅ Service Worker registered');
      } catch (e) {
        print('❌ Service Worker registration failed: $e');
      }
    }

    // 2️⃣ Request Notification Permission
    NotificationSettings settings = await _fcm.requestPermission();
    print("🔔 Permission: ${settings.authorizationStatus}");

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print('❌ User declined notifications');
      return;
    }

    // 3️⃣ Get FCM Token (with VAPID key)
    try {
      String? token = await _fcm.getToken(
        vapidKey:
            "BC0G6648G2h5E0PZ5C9UOGk2E5HlQOtWCqsVbUMWEuibu7CYht4x1mGpeJ3V6KH0nMusfhOoz6ebE4BJ0biJPQ8",
      );
      if (token != null) {
        fcm_Token = token;
        print("📱 FCM Token: $token");
      }
    } catch (e) {
      print('❌ Failed to get FCM token: $e');
    }

    // 4️⃣ Listen to Foreground Messages
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("📩 رسالة جديدة (Foreground):");
    //   print("Title: ${message.notification?.title}");
    //   print("Body: ${message.notification?.body}");
    //   print("Data: ${message.data}");
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 رسالة جديدة (Foreground): ${message.notification?.title}");

      if (html.Notification.supported) {
        html.Notification(
          message.notification?.title ?? 'إشعار جديد',
          body: message.notification?.body ?? '',
        );
      }
    });

    // 5️⃣ Listen to Messages when clicked from Notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📬 Notification clicked:");
      print("Title: ${message.notification?.title}");
    });
  }
}

// import 'dart:html' as html;
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../core/utils/secure_storage.dart';
//
// class NotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   Future<void> initNotifications() async {
//     // Note: Firebase is already initialized in main.dart
//     // No need to initialize again here
//
//     // 1️⃣ Register Service Worker (for web push)
//     if (html.window.navigator.serviceWorker != null) {
//       try {
//         await html.window.navigator.serviceWorker!
//             .register('firebase-messaging-sw.js');
//         print('✅ Service Worker registered');
//       } catch (e) {
//         print('❌ Service Worker registration failed: $e');
//       }
//     }
//
//     // 2️⃣ Sign-in with backend token (required for FCM on web)
//     try {
//       final token = await SecureStorage.getToken();
//       print('🔍 Backend token from storage: ${token != null ? "Found" : "Not found"}');
//
//       if (token != null) {
//         // Sign in with custom token from your backend
//         print('🔄 Attempting custom token sign-in...');
//         await FirebaseAuth.instance.signInWithCustomToken(token);
//         print('✅ Signed in with backend token');
//       } else {
//         // Fallback to anonymous sign-in
//         print('🔄 Attempting anonymous sign-in...');
//         await FirebaseAuth.instance.signInAnonymously();
//         print('✅ Signed in anonymously (no backend token)');
//       }
//
//       // Wait for auth state to be ready
//       print('🔄 Waiting for auth state...');
//       await FirebaseAuth.instance.authStateChanges().first;
//       print('✅ Auth state ready');
//
//       // Check current user
//       final currentUser = FirebaseAuth.instance.currentUser;
//       print('👤 Current user: ${currentUser?.uid ?? "null"}');
//       print('🔑 User token: ${currentUser?.getIdToken() != null ? "Available" : "Not available"}');
//
//     } catch (e) {
//       print('❌ Firebase Auth sign-in failed: $e');
//       // Try anonymous as last resort
//       try {
//         print('🔄 Attempting fallback anonymous sign-in...');
//         await FirebaseAuth.instance.signInAnonymously();
//         await FirebaseAuth.instance.authStateChanges().first;
//         print('✅ Fallback anonymous sign-in successful');
//
//         final currentUser = FirebaseAuth.instance.currentUser;
//         print('👤 Fallback user: ${currentUser?.uid ?? "null"}');
//       } catch (e2) {
//         print('❌ All sign-in methods failed: $e2');
//         return;
//       }
//     }
//
//     // 3️⃣ Request notification permission
//     NotificationSettings settings = await _fcm.requestPermission();
//     print("🔔 Permission: ${settings.authorizationStatus}");
//
//     if (settings.authorizationStatus != AuthorizationStatus.authorized) {
//       print('❌ User declined notifications');
//       return;
//     }
//
//     // 4️⃣ Get FCM token (wait a bit for auth to fully settle)
//     print('⏳ Waiting for auth to settle...');
//     await Future.delayed(const Duration(milliseconds: 1000));
//
//     // Double check auth state before getting token
//     final currentUser = FirebaseAuth.instance.currentUser;
//     print('🔍 Final auth check - User: ${currentUser?.uid ?? "null"}');
//
//     // Try to get ID token first
//     try {
//       final idToken = await currentUser?.getIdToken();
//       print('🔑 ID Token available: ${idToken != null ? "Yes" : "No"}');
//     } catch (e) {
//       print('❌ Failed to get ID token: $e');
//     }
//
//     // Try FCM without VAPID key first (simpler approach)
//     try {
//       print('🔄 Attempting to get FCM token without VAPID...');
//       String? token = await _fcm.getToken();
//       print("📱 FCM Token (no VAPID): $token");
//
//       if (token != null) {
//         print('✅ FCM token obtained successfully!');
//       }
//     } catch (e) {
//       print('❌ Failed to get FCM token (no VAPID): $e');
//
//       // Try with VAPID key as fallback
//       try {
//         print('🔄 Attempting to get FCM token with VAPID...');
//         String? token = await _fcm.getToken(
//           vapidKey: "BC0G6648G2h5E0PZ5C9UOGk2E5HlQOtWCqsVbUMWEuibu7CYht4x1mGpeJ3V6KH0nMusfhOoz6ebE4BJ0biJPQ8",
//         );
//         print("📱 FCM Token: $token");
//       } catch (e2) {
//         print('❌ Failed to get FCM token with VAPID: $e2');
//         print('💡 FCM not working - this is normal for development');
//         print('🔧 To fix: 1) Get correct VAPID key from Firebase Console 2) Clear browser cache');
//       }
//     }
//
//     // 5️⃣ Listen to foreground messages
//     // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     //   print("📩 New message: ${message.notification?.title ?? 'No Title'}");
//     // });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("📩 رسالة جديدة:");
//       print("Title: ${message.notification?.title}");
//       print("Body: ${message.notification?.body}");
//       print("Data: ${message.data}");
//     });
//
//
//     // 6️⃣ Optional: Listen to messages opened from notification click
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("📬 Message clicked: ${message.notification?.title ?? 'No Title'}");
//     });
//   }
// }
