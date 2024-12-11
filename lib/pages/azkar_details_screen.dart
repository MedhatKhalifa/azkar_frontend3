// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/azkar_model.dart';
// import '../utils/constants.dart';

// class AzkarDetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Azkar azkar = Get.arguments;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(azkar.category ?? 'Azkar Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(DEFAULT_PADDING),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (azkar.content != null)
//                 Text(
//                   azkar.content!,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               if (azkar.reward != null)
//                 Text("Reward: ${azkar.reward!}",
//                     style: TextStyle(fontSize: 16)),
//               if (azkar.source != null)
//                 Text("Source: ${azkar.source!}",
//                     style: TextStyle(fontSize: 16)),
//               // Add more fields as needed
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
