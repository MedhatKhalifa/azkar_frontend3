import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:azakar/pages/AzkarListPage.dart';
import 'dart:convert';
import '../models/azkar_model.dart';
import '../services/api_service.dart';

class AzkarController extends GetxController {
  var azkarList = <Azkar>[].obs; // List of all Azkar
  var filteredAzkar = <Azkar>[].obs; // Azkar filtered by language
  var matchingAzkar = <Azkar>[].obs;
  var subCategoryAzkar = <Azkar>[].obs;
  var uniqueCategories =
      <String>[].obs; // List of unique categories (filtered by language)
  var uniqueSubCategories =
      <String>[].obs; // List of unique subcategories (filtered by language)
  var uniqueShowedSubCategories =
      <String>[].obs; // List of unique subcategories (filtered by language)
  var selectedLanguage = 'ar'.obs; // Default language is Arabic
  var dbVersion = ''.obs; // Database version

  /// Initialize Azkar data
  Future<void> getAzkarList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? cachedAzkar = prefs.getString('cached_azkar');
      if (cachedAzkar != null) {
        azkarList.value = (json.decode(cachedAzkar) as List<dynamic>)
            .map((azkarJson) => Azkar.fromJson(azkarJson))
            .toList();
      }

      // Filter Azkar based on the default or selected language
      filterAzkarByLanguage();
      // Get shared preferences instance

      // Fetch the latest database version from the server
      String newVersion = await ApiService.fetchDatabaseVersion();

      // Check stored database version
      dbVersion.value = prefs.getString('db_version') ?? '';

      if (dbVersion.value != newVersion) {
        // Fetch Azkar from the server if the database version is updated
        azkarList.value = await ApiService.fetchAzkar();

        // Store updated database version and Azkar list in SharedPreferences
        await prefs.setString('db_version', newVersion);
        await prefs.setString(
          'cached_azkar',
          json.encode(azkarList.map((azkar) => azkar.toJson()).toList()),
        );
        // Load cached Azkar from SharedPreferences if available
        final String? cachedAzkar = prefs.getString('cached_azkar');
        if (cachedAzkar != null) {
          azkarList.value = (json.decode(cachedAzkar) as List<dynamic>)
              .map((azkarJson) => Azkar.fromJson(azkarJson))
              .toList();
        }

        // Filter Azkar based on the default or selected language
        filterAzkarByLanguage();
      }
    } catch (e) {
      print("Error initializing Azkar: $e");
    }
  }

  /// Filter Azkar based on selected language and update unique categories and subcategories
  void filterAzkarByLanguage() {
    // Filter Azkar list based on the selected language
    filteredAzkar.value = azkarList
        .where((azkar) => azkar.language == selectedLanguage.value)
        .toList();

    // Update unique categories and subcategories based on filtered Azkar
    uniqueCategories.value = filteredAzkar
        .map((azkar) => azkar.category ?? '') // Extract categories
        .toSet()
        .where((category) => category.isNotEmpty) // Remove empty values
        .toList();

    uniqueSubCategories.value = filteredAzkar
        .map((azkar) => azkar.subCategory ?? '') // Extract subcategories
        .toSet()
        .where(
          (subCategory) => subCategory.isNotEmpty,
        ) // Remove empty values
        .toList();
    uniqueShowedSubCategories.value = List<String>.from(uniqueSubCategories);
  }

  /// Change the language and refilter Azkar
  void changeLanguage(String language) {
    selectedLanguage.value = language;
    getAzkarList();
    // filterAzkarByLanguage();
  }

  /// Azkar By Category
  ///
  /// Filter Azkar based on selected language and update unique categories and subcategories
  void azkarBySubCategory(String subcategory) {
    // Filter Azkar list based on the selected language
    subCategoryAzkar.value = filteredAzkar
        .where((azkar) => azkar.subCategory == subcategory)
        .toList();

    Get.to(() => const AzkarListPage());
  }

  /// Perform Search
  ///
  ///
  void performSearch2(String query) {
    if (query.isEmpty) {
      // Show a message if no query is entered
      Get.snackbar(
        'error'.tr,
        'enter_search_term'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Normalize Arabic text for better matching
    final normalizedQuery = normalizeArabic(query);

    // Create a Set to track the content and remove duplicates
    Set<String> seenContent = <String>{};

    // Filter Azkar that match content, reward, or subCategory
    matchingAzkar.value = filteredAzkar.where((azkar) {
      final normalizedContent = normalizeArabic(azkar.content ?? '');
      final normalizedReward = normalizeArabic(azkar.reward ?? '');
      final normalizedSubCategory = normalizeArabic(
        azkar.subCategory ?? '',
      );

      // Check if content matches and has not been seen before
      bool isMatching = (normalizedContent.contains(normalizedQuery) ||
          normalizedReward.contains(normalizedQuery) ||
          normalizedSubCategory.contains(normalizedQuery));

      // Only add Azkar to the list if the content is unique
      if (isMatching && !seenContent.contains(normalizedContent)) {
        seenContent.add(normalizedContent); // Add content to the set
        return true; // Include the Azkar in the filtered list
      }

      return false; // Exclude duplicates
    }).toList();
  }

  void performSearch(String query) {
    if (query.isEmpty) {
      // Show a message if no query is entered
      Get.snackbar(
        'error'.tr,
        'enter_search_term'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Normalize Arabic text for better matching
    final normalizedQuery = normalizeArabic(query);

    // Filter Azkar that match content, reward, or subCategory
    final matchingAzkar = filteredAzkar.where((azkar) {
      final normalizedContent = normalizeArabic(azkar.content ?? '');
      final normalizedReward = normalizeArabic(azkar.reward ?? '');
      final normalizedSubCategory = normalizeArabic(
        azkar.subCategory ?? '',
      );

      return normalizedContent.contains(normalizedQuery) ||
          normalizedReward.contains(normalizedQuery) ||
          normalizedSubCategory.contains(normalizedQuery);
    }).toList();

    // Check if there are results
    if (matchingAzkar.isEmpty) {
      // Show a message if no matches are found
      Get.snackbar(
        'search_results'.tr,
        'no_results'.tr,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Navigate to AzkarListPage with matching Azkar
      Get.to(AzkarListPage(matchingAzkar: matchingAzkar, isSearchResult: true));
      print('Test');
    }
  }

  /// Perform Search
  void performSearchSubCategory(String query) {
    if (query.isEmpty) {
      // Ensure uniqueShowedSubCategories is a new copy of uniqueSubCategories
      uniqueShowedSubCategories.value = List<String>.from(uniqueSubCategories);
      return;
    }

    // Normalize query for comparison
    final normalizedQuery = normalizeArabic(query);

    // Filter and create a new copy of the filtered list
    uniqueShowedSubCategories.value = uniqueSubCategories.where((subCategory) {
      final normalizedSubCategory = normalizeArabic(subCategory);

      return normalizedSubCategory.contains(normalizedQuery);
    }).toList();
  }

  /// Normalize Arabic text for better matching
  String normalizeArabic(String text) {
    if (text.isEmpty) return text;
    if (selectedLanguage.value == 'ar') {
      return text
          // Replace common variations
          .replaceAll(
            RegExp(r'[أإآ]', caseSensitive: false),
            'ا',
          ) // Replace أ, إ, آ with ا
          .replaceAll('ى', 'ي') // Replace ى with ي
          .replaceAll('ة', 'ه') // Replace ة with ه
          // Remove diacritics
          .replaceAll(RegExp(r'[ًٌٍَُِّْ]'), '')
          // Remove Tatweel (ــ)
          .replaceAll('ـ', '')
          // Handle extra spaces
          .replaceAll(
            RegExp(r'\s+'),
            ' ',
          ) // Replace multiple spaces with a single space
          .trim(); // Remove leading/trailing spaces
    } else {
      return text.toLowerCase();
    }
  }

  //
}
