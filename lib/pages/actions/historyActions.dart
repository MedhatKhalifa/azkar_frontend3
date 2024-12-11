import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'database_helper.dart';
import 'viewTodayActions.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDate;
  DateTime? _selectedDate;
  List<String> _highlightedDates = [];

  @override
  void initState() {
    super.initState();
    _focusedDate = DateTime.now();
    _fetchHighlightedDates();
  }

  Future<void> _fetchHighlightedDates() async {
    final db = await DBHelper.instance.database;
    final results = await db.rawQuery('SELECT DISTINCT date FROM form_data');
    setState(() {
      _highlightedDates = results.map((row) => row['date'] as String).toList();
    });
  }

  bool _isHighlighted(DateTime date) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return _highlightedDates.contains(formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDate,
            firstDay: DateTime(2020),
            lastDay: DateTime(2100),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });

              // Navigate to LargeFormScreen with the selected date
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LargeFormScreen(selectedDate: selectedDay),
                ),
              );
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_isHighlighted(day)) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                return null;
              },
              todayBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          if (_selectedDate != null)
            ElevatedButton(
              onPressed: () {
                // Navigate to LargeFormScreen with the selected date
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LargeFormScreen(selectedDate: _selectedDate!),
                  ),
                );
              },
              child: Text(
                  'Go to Form for ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
            ),
        ],
      ),
    );
  }
}
