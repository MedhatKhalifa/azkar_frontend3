import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:adhan_dart/adhan_dart.dart';
import 'package:intl/intl.dart'; // Add intl package to pubspec.yaml

class PrayerTimesScreen extends StatefulWidget {
  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  Map<String, DateTime> prayerTimes = {};
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    try {
      // Initialize time zones
      tz.initializeTimeZones();
      final location = tz.getLocation('Africa/Cairo'); // Cairo timezone

      // Hardcoded coordinates for testing
      Coordinates coordinates = Coordinates(30.014907, 30.970081);

      // Current date in the specified location
      DateTime date = tz.TZDateTime.from(DateTime.now(), location);

      // Calculation parameters
      CalculationParameters params = CalculationMethod.egyptian();
      params.madhab = Madhab.shafi;
      params.adjustments = {
        'fajr': 120,
        'sunrise': 120,
        'dhuhr': 120,
        'asr': 120,
        'maghrib': 120,
        'isha': 120,
      };

      // Calculate prayer times
      PrayerTimes prayerTimesData = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
        precision: true,
      );

      // Set state to update UI
      setState(() {
        prayerTimes = {
          'Fajr': tz.TZDateTime.from(prayerTimesData.fajr!, location),
          'Sunrise': tz.TZDateTime.from(prayerTimesData.sunrise!, location),
          'Dhuhr': tz.TZDateTime.from(prayerTimesData.dhuhr!, location),
          'Asr': tz.TZDateTime.from(prayerTimesData.asr!, location),
          'Maghrib': tz.TZDateTime.from(prayerTimesData.maghrib!, location),
          'Isha': tz.TZDateTime.from(prayerTimesData.isha!, location),
        };
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Times'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: fetchPrayerTimes,
        child: errorMessage != null
            ? Center(
                child: Text(
                  'Error: $errorMessage',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              )
            : prayerTimes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: EdgeInsets.all(10),
                    children: prayerTimes.entries
                        .map((entry) => Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Icon(
                                  _getIconForPrayer(entry.key),
                                  color: Colors.blueAccent,
                                  size: 30,
                                ),
                                title: Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat.jm().format(entry.value.toLocal()),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
      ),
    );
  }

  IconData _getIconForPrayer(String prayer) {
    switch (prayer) {
      case 'Fajr':
        return Icons.brightness_5; // Sunrise icon
      case 'Sunrise':
        return Icons.wb_sunny; // Sun icon
      case 'Dhuhr':
        return Icons.wb_cloudy; // Noon icon
      case 'Asr':
        return Icons.filter_drama; // Afternoon icon
      case 'Maghrib':
        return Icons.nights_stay; // Sunset icon
      case 'Isha':
        return Icons.brightness_3; // Night icon
      default:
        return Icons.access_time; // Default icon
    }
  }
}
