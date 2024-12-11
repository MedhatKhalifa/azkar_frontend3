import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azakar/pages/common_widget/thedrawer.dart';
import '../controllers/azkar_controller.dart';
import 'AzkarListPage.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({super.key});

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

final AzkarController controller = Get.put(AzkarController());

class _SubCategoryPageState extends State<SubCategoryPage> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 43, 22),
        title: isSearching
            ? TextField(
                controller: searchController,
                textDirection: TextDirection.rtl,
                onChanged: (query) {
                  controller.performSearchSubCategory(query);
                },
                style: const TextStyle(
                  fontFamily: 'sebhafont',
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'search_hint'.tr,
                  hintStyle: TextStyle(
                    fontFamily: 'sebhafont',
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFDAA520),
                      width: 2,
                    ),
                  ),
                ),
              )
            : Text(
                'subcategory_title'.tr,
                style: const TextStyle(
                  fontFamily: 'sebhafont',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDAA520),
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.grey[300],
            ),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  controller.performSearchSubCategory('');
                }
                isSearching = !isSearching;
              });
            },
          ),
        ],
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      backgroundColor: const Color.fromARGB(255, 194, 218, 200),
      body: Obx(() {
        if (controller.uniqueShowedSubCategories.isEmpty) {
          return Center(
            child: Text(
              'no_results'.tr,
              style: const TextStyle(
                fontFamily: 'sebhafont',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.uniqueShowedSubCategories.length,
            itemBuilder: (context, index) {
              final subCategory = controller.uniqueShowedSubCategories[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                color: const Color.fromARGB(255, 22, 43, 22),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  title: Text(
                    subCategory,
                    style: const TextStyle(
                      fontFamily: 'sebhafont',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 240, 245, 244),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromARGB(255, 240, 245, 244),
                  ),
                  onTap: () {
                    controller.azkarBySubCategory(subCategory);
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
