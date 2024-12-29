import 'package:azakar/pages/azan/prayer_view.dart';
import 'package:azakar/pages/sebha/sebha_homePage.dart';
import 'package:azakar/pages/subCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
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
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 55, 98, 55),
            ),
            child: Center(
              child: Text(
                'app_name'.tr,
                style: const TextStyle(
                  fontFamily: 'sebhafont',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDAA520),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(FlutterIslamicIcons.tasbih2),
            title: Text('tasbih'.tr),
            onTap: () {
              Get.to(TasbihListPage());
            },
          ),
          ListTile(
            leading: const Icon(FlutterIslamicIcons.prayingPerson),
            title: Text('azan'.tr),
            onTap: () {
              Get.to(PrayerTimesScreen());
            },
          ),
          ListTile(
            leading: const Icon(FlutterIslamicIcons.prayer),
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
            leading: const Icon(FlutterIslamicIcons.calendar),
            title: Text('history_checklist'.tr),
            onTap: () {
              Get.to(() => const CalendarScreen());
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
