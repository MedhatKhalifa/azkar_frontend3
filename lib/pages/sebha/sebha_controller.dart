import 'package:get/get.dart';
import 'db_helper.dart';

class SebhaController extends GetxController {
  final SebhaDatabaseHelper _dbHelper = SebhaDatabaseHelper();

  var azkar = <Map<String, dynamic>>[].obs;
  var selectedZekr = Rxn<Map<String, dynamic>>();
  var currentCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAzkar(); // Fetch Azkar on initialization
  }

  void fetchAzkar() async {
    // Fetch azkar from the database
    final fetchedAzkar = await _dbHelper.fetchAllAzkar();

    // Create a mutable copy and sort it
    final sortedAzkar = List<Map<String, dynamic>>.from(fetchedAzkar)
      ..sort(
          (a, b) => b['accumulativeCount'].compareTo(a['accumulativeCount']));

    // Update the reactive azkar list
    azkar.value = sortedAzkar;
  }

  void selectZekr(Map<String, dynamic> zekr) {
    selectedZekr.value = zekr;
    currentCount.value = 0;
  }

  void incrementCount() {
    // Create a mutable copy of the selected Zekr
    final updatedZekr = Map<String, dynamic>.from(selectedZekr.value!);

    // Update the accumulative count
    updatedZekr['accumulativeCount']++;

    // Save the updated count to the database
    _dbHelper.updateAccumulativeCount(
      updatedZekr['id'],
      updatedZekr['accumulativeCount'],
    );

    // Update the selected Zekr with the new values
    selectedZekr.value = updatedZekr;

    // Increment the current count
    currentCount.value++;
  }

  void resetCurrentCount() {
    currentCount.value = 0;
  }

  Future<void> addZekr(String name, String fadl) async {
    await _dbHelper.insertZekr(name, fadl);
    fetchAzkar();
  }
}
