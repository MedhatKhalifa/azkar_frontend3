import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/theme.dart';
import 'pages/splash_screen.dart';
import 'translation/translation.dart';

Future<void> main() async {
  // Ensure proper widget binding initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Uncomment and configure Firebase if needed
  // await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  // DependencyInjection.init(); // Add dependency injection if required

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wazker',
      theme: LocalThemes.lightTheme, // Custom light theme
      //theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false, // Removes the debug banner
      // Set the splash screen as the initial page
      home: const SplashScreen(), //SplashScreen(),
      //Add localization delegates to support Material and Cupertino widgets
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Define supported locales for your app
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],

      // Enable GetX translations
      translations: Translate(),
      locale: Get.deviceLocale, // Automatically detects the device's locale
      fallbackLocale: const Locale(
        'ar',
      ), // Defaults to Arabic if no match is found
    );
  }
}
