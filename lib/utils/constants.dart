import 'package:flutter/material.dart';

// Base URL for API calls
const String BASE_URL =
    "https://quraanshcool.pythonanywhere.com/api"; // Replace with your backend server's address

// Default supported languages
const List<String> SUPPORTED_LANGUAGES = ['ar', 'en'];

// Notification Channel
const String NOTIFICATION_CHANNEL_ID = "azkar_channel";
const String NOTIFICATION_CHANNEL_NAME = "Azkar Notifications";
const String NOTIFICATION_CHANNEL_DESCRIPTION = "Channel for Azkar reminders";

// App-wide colors
const Color PRIMARY_COLOR = Color(0xFF4A90E2);
const Color ACCENT_COLOR = Color(0xFFE94E77);
const Color BACKGROUND_COLOR = Color(0xFFF7F7F7);

// Padding and Margins
const double DEFAULT_PADDING = 16.0;
const double DEFAULT_MARGIN = 16.0;

// UI Strings
const String APP_TITLE = "Azkar App";
const String NO_AZKAR_MESSAGE = "No Azkar available.";
const String WELCOME_MESSAGE = "Welcome to Azkar App!";
const String LANGUAGE_SELECTION_TITLE = "Select Language";

// Asset paths (for icons, images, etc.)
const String SUN_ICON = "assets/icons/sun.png";
const String MOON_ICON = "assets/icons/moon.png";
