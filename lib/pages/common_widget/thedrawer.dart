import 'package:azakar/pages/sebha/sebha_homePage.dart';
import 'package:azakar/pages/subCategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azakar/pages/actions/historyActions.dart';
import 'package:azakar/translation/translation_page.dart';
import '../actions/viewTodayActions.dart';
import '../azkar_search.dart';
import '../sebha/sebha_tasbihList.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Center(
              child: Text(
                'app_name'.tr,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: Text('azkar'.tr),
            onTap: () {
              Get.to(() => const SubCategoryPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: Text('today_action_list'.tr),
            onTap: () {
              Get.to(
                () => LargeFormScreen(
                  selectedDate: DateTime.now(), // Pass the desired date here
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.task_alt),
            title: Text('history_checklist'.tr),
            onTap: () {
              Get.to(() => const CalendarScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.safety_check),
            title: Text('sebha'.tr),
            onTap: () {
              Get.to(TasbihListPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: Text('search'.tr),
            onTap: () {
              Get.to(() => const AzkarSearchPage());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('change_language'.tr),
            onTap: () {
              Get.to(() => const TrnaslationPage());
            },
          ),
          // Uncomment and translate additional menu items as needed
          // ListTile(
          //   leading: Icon(Icons.color_lens),
          //   title: Text('change_theme'.tr),
          //   onTap: () {},
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.web),
          //   title: Text('islamic_websites_apps'.tr),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/websites');
          //   },
          // ),
        ],
      ),
    );
  }
}
