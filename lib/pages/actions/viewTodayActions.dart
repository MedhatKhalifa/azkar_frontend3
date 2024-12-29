import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'actions_predefine.dart';
import 'database_helper.dart';

class LargeFormScreen extends StatefulWidget {
  final DateTime selectedDate;

  const LargeFormScreen({super.key, required this.selectedDate});

  @override
  _LargeFormScreenState createState() => _LargeFormScreenState();
}

class _LargeFormScreenState extends State<LargeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String formattedDate;
  late String dayName;
  final List<Map<String, dynamic>> categories = predefinedActions;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _doneStates = {}; // Map to store "done" states

  @override
  void initState() {
    super.initState();
    _initializeScreenState();
  }

  void _initializeScreenState() {
    formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    dayName = DateFormat('EEEE', 'ar').format(widget.selectedDate);
    _clearState(); // Clear old state
    _initializeControllers();
    _loadFormData();
  }

  @override
  void didUpdateWidget(covariant LargeFormScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _initializeScreenState(); // Reinitialize for new date
      setState(() {}); // Trigger rebuild
    }
  }

  void _clearState() {
    _controllers.clear(); // Clear controllers
    _doneStates.clear(); // Clear done states
  }

  void _initializeControllers() {
    for (var category in categories) {
      for (var subcategory in category["subcategories"]) {
        String key = '${category["category"]}_${subcategory["name"]}';
        _controllers[key] = TextEditingController();
        _doneStates[key] = false; // Initialize done state to false
      }
    }
  }

  Future<void> _loadFormData() async {
    final data = await DBHelper.instance.fetchFormData(formattedDate);

    // Reset done states to default (false) before applying fetched data
    for (var key in _doneStates.keys) {
      _doneStates[key] = false;
    }

    for (var entry in data) {
      final categoryName = entry['category'];
      final subcategoryName = entry['subcategory'];
      final done = entry['done'] == 1;
      final comment = entry['comment'];

      String key = '${categoryName}_$subcategoryName';

      if (_controllers.containsKey(key)) {
        _controllers[key]?.text = comment; // Apply comment to controller
      }
      if (_doneStates.containsKey(key)) {
        _doneStates[key] = done; // Update done state
      }
    }

    setState(() {});
  }

  Future<void> _saveForm() async {
    for (var category in categories) {
      for (var subcategory in category["subcategories"]) {
        String key = '${category["category"]}_${subcategory["name"]}';
        final entry = {
          "category": category["category"],
          "subcategory": subcategory["name"],
          "done": _doneStates[key]! ? 1 : 0,
          "comment": _controllers[key]?.text ?? "",
          "date": formattedDate,
        };

        await DBHelper.instance.updateFormEntry(entry).then((rowsAffected) {
          if (rowsAffected == 0) {
            DBHelper.instance.insertFormEntry(entry);
          }
        });
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('save_done'.tr)),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$dayName, $formattedDate'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ...categories.map((category) {
                return ExpansionTile(
                  title: Text(
                    category["category"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  children:
                      category["subcategories"].map<Widget>((subcategory) {
                    String key =
                        '${category["category"]}_${subcategory["name"]}';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _controllers[key],
                              decoration: InputDecoration(
                                labelText: subcategory["name"],
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Checkbox(
                            value: _doneStates[key],
                            onChanged: (value) {
                              setState(() {
                                _doneStates[key] = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('save'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
