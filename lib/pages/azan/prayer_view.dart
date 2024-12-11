import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  List<String> prayerTimesList = [];

  @override
  void initState() {
    super.initState();
    _getPrayerTimes();
  }

  void _getPrayerTimes() async {
    // Replace with your own coordinates
    final coordinates = Coordinates(23.9088, 89.1220);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    // Get today's prayer times
    final prayerTimes = PrayerTimes.today(coordinates, params);

    // Format the prayer times and update the UI
    setState(() {
      prayerTimesList = [
        DateFormat.jm().format(prayerTimes.fajr),
        DateFormat.jm().format(prayerTimes.sunrise),
        DateFormat.jm().format(prayerTimes.dhuhr),
        DateFormat.jm().format(prayerTimes.asr),
        DateFormat.jm().format(prayerTimes.maghrib),
        DateFormat.jm().format(prayerTimes.isha),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prayer Times')),
      body: prayerTimesList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: prayerTimesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(prayerNames[index]),
                  subtitle: Text(prayerTimesList[index]),
                );
              },
            ),
    );
  }

  final List<String> prayerNames = [
    'Fajr',
    'Sunrise',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha'
  ];
}
