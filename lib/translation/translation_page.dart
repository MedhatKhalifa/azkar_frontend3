import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:azakar/pages/subCategory.dart';

import '../controllers/azkar_controller.dart';
import '../core/size_config.dart';

class TrnaslationPage extends StatefulWidget {
  const TrnaslationPage({super.key});

  @override
  _TrnaslationPageState createState() => _TrnaslationPageState();
}

final AzkarController azkarController = Get.put(AzkarController());

class _TrnaslationPageState extends State {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //appBar: simplAppbar(false),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/translate/translate.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: h(20)),
              SizedBox(
                height: h(50),
                child: Image.asset("assets/images/logo/logo_trans.png"),
              ),
              // Container(
              //   width: w(40),
              //   height: h(20),
              //   child: Image.asset(
              //     "assets/images/hasr_logo.png",
              //     width: w(40),
              //     height: h(20),
              //     //color: Colors.red,
              //   ),
              // ),
              SizedBox(height: h(5)),
              Padding(
                padding: EdgeInsets.only(right: w(10), left: w(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ), // text color

                  onPressed: () async {
                    var locale = const Locale('en', 'en');
                    Get.updateLocale(locale);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('lang', 'en');
                    azkarController.changeLanguage('en');

                    Get.to(const SubCategoryPage());
                  },
                  child: Text(
                    'English',
                    style: TextStyle(fontSize: sp(20), color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: h(2)),
              Padding(
                padding: EdgeInsets.only(left: w(10), right: w(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ), // text color
                  onPressed: () async {
                    var locale = const Locale('ar', 'ar');
                    Get.updateLocale(locale);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    await prefs.setString('lang', 'ar');
                    azkarController.changeLanguage('ar');
                    Get.to(const SubCategoryPage());
                  },
                  child: Text(
                    'عــربـى',
                    style: TextStyle(fontSize: sp(16), color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: h(10)),

              const Center(
                child: Text(
                  '@2023, Technocube, All Rights Reserved',
                  style: TextStyle(fontSize: 7, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
