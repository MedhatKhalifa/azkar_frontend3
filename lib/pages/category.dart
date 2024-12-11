// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/azkar_controller.dart';
// import '../utils/constants.dart';

// class CategoryPage extends StatefulWidget {
//   const CategoryPage({super.key});

//   @override
//   State<CategoryPage> createState() => _CategoryPageState();
// }

// final AzkarController controller = Get.put(AzkarController());

// class _CategoryPageState extends State<CategoryPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text(
//           'أذكاري',
//           style: TextStyle(
//             fontFamily: 'AmiriQuran', // Arabic font
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           DropdownButton<String>(
//             value: controller.selectedLanguage.value,
//             onChanged: (value) {
//               if (value != null) controller.changeLanguage(value);
//             },
//             underline: SizedBox(), // Removes the underline from the dropdown
//             icon: Icon(Icons.language, color: Colors.white),
//             dropdownColor: Colors.teal,
//             items: SUPPORTED_LANGUAGES.map((lang) {
//               return DropdownMenuItem(
//                 value: lang,
//                 child: Text(
//                   lang == 'ar' ? 'عربي' : 'English',
//                   style: TextStyle(
//                     fontFamily: 'AmiriQuran',
//                     fontSize: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         return ListView.builder(
//           itemCount: controller.uniqueSubCategories.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(
//                 controller.uniqueSubCategories[index],
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey[700],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
