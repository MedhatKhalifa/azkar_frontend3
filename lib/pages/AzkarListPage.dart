import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/azkar_controller.dart';
import '../models/azkar_model.dart';

class AzkarListPage extends StatefulWidget {
  final String? subCategory; // Subcategory name (optional)
  final List<Azkar>? matchingAzkar; // Search results (optional)
  final bool isSearchResult; // True if this is a search result

  const AzkarListPage({
    super.key,
    this.subCategory,
    this.matchingAzkar,
    this.isSearchResult = false,
  });

  @override
  _AzkarListPageState createState() => _AzkarListPageState();
}

class _AzkarListPageState extends State<AzkarListPage>
    with TickerProviderStateMixin {
  final Map<int, AnimationController> _controllers = {};
  final Map<int, Animation<double>> _scaleAnimations = {};
  final AzkarController azkarController = Get.put(AzkarController());
  late List<Azkar> _originalAzkarList; // Backup of the original list

  double _textSize = 18.0; // Default text size for azkar.content

  @override
  void initState() {
    super.initState();
    // Create a backup of the original list
    _originalAzkarList = List.from(azkarController.subCategoryAzkar);
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onTileClick(int index, Azkar azkar) {
    if (azkar.count! > 0) {
      setState(() {
        azkar.count = azkar.count! - 1;
      });

      // Trigger the animation for the clicked item
      final controller = _controllers[index];
      if (controller != null) {
        controller.forward().then((_) => controller.reverse());
      }
    }
  }

  void _resetProgress() {
    setState(() {
      // Restore the original list and reset counts
      azkarController.subCategoryAzkar.value = List.from(_originalAzkarList);
      for (var azkar in azkarController.subCategoryAzkar) {
        azkar.count =
            azkar.initialCount; // Assuming `initialCount` is available
      }
    });

    Get.snackbar(
      'pregress_reset'.tr,
      'azkar_reset'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 43, 22),
        title: Text(
          azkarController.subCategoryAzkar.isNotEmpty
              ? azkarController.subCategoryAzkar[0].subCategory!
              : 'subcategory'.tr,
          style: const TextStyle(
            fontFamily: 'sebhafont',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFDAA520),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            tooltip: 'Increase Text Size',
            onPressed: () {
              setState(() {
                _textSize = _textSize < 30 ? _textSize + 2.0 : _textSize;
                //_textSize += 2.0; // Increase text size by 2
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            tooltip: 'Decrease Text Size',
            onPressed: () {
              setState(() {
                _textSize = _textSize > 12.0 ? _textSize - 2.0 : _textSize;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'reset',
            onPressed: () {
              _resetProgress();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: azkarController.subCategoryAzkar.isEmpty
          ? Center(
              child: Text(
                'no_results'.tr,
                style: const TextStyle(
                  fontFamily: 'myarabic',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDAA520),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: azkarController.subCategoryAzkar.length,
              itemBuilder: (context, index) {
                final azkar = azkarController.subCategoryAzkar[index];

                // Initialize animation controller and animation for this index if not already initialized
                if (!_controllers.containsKey(index)) {
                  final controller = AnimationController(
                    vsync: this,
                    duration: const Duration(milliseconds: 200),
                  );
                  _controllers[index] = controller;
                  _scaleAnimations[index] =
                      Tween<double>(begin: 1.0, end: 1.1).animate(
                    CurvedAnimation(parent: controller, curve: Curves.easeOut),
                  );
                }

                return azkar.count == 0
                    ? Dismissible(
                        key: ValueKey(azkar),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            azkarController.subCategoryAzkar.removeAt(index);
                          });
                          // Get.snackbar(
                          //   'Item Removed',
                          //   'Azkar "${azkar.content}" removed from the list.',
                          //   snackPosition: SnackPosition.BOTTOM,
                          // );
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          color: Colors.grey[400],
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            title: Text(
                              azkar.content ?? '',
                              style: TextStyle(
                                fontFamily: 'myarabic',
                                fontSize: _textSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            trailing: Text(
                              '${azkar.count}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            subtitle:
                                azkar.reward != null && azkar.reward != 'nan'
                                    ? Text(
                                        '${'reward'.tr}: ${azkar.reward}',
                                        style: TextStyle(
                                          fontFamily: 'myarabic',
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      )
                                    : null,
                          ),
                        ),
                      )
                    : ScaleTransition(
                        scale: _scaleAnimations[index]!,
                        child: GestureDetector(
                          onTap: () => _onTileClick(index, azkar),
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            color: const Color.fromARGB(255, 22, 43, 22),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              title: Text(
                                azkar.content ?? '',
                                style: TextStyle(
                                  fontFamily: 'myarabic',
                                  fontSize: _textSize,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 241, 241, 238),
                                ),
                              ),
                              trailing: Text(
                                '${azkar.count}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle:
                                  azkar.reward != null && azkar.reward != 'nan'
                                      ? Text(
                                          '${'reward'.tr}: ${azkar.reward}',
                                          style: TextStyle(
                                            fontFamily: 'myarabic',
                                            fontSize: 16,
                                            color: Colors.grey[300],
                                          ),
                                        )
                                      : null,
                            ),
                          ),
                        ),
                      );
              },
            ),
    );
  }
}
