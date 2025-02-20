// import 'package:adhan/adhan.dart';
// import 'package:intl/intl.dart';

// void main() {
//   print('Kushtia Prayer Times');
//   // Replace with your location's latitude and longitude.
//   final myCoordinates = Coordinates(30.013447, 30.956787);

//   // Set the calculation method (you can change it based on your region).
//   final params = CalculationMethod.karachi.getParameters();
//   params.madhab = Madhab.hanafi; // Set madhab to Hanafi, adjust as necessary.

//   // Get today's prayer times.
//   final prayerTimes = PrayerTimes.today(myCoordinates, params);

//   // Print out the prayer times in local timezone.
//   print(
//       "---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
//   print(DateFormat.jm().format(prayerTimes.fajr));
//   print(DateFormat.jm().format(prayerTimes.sunrise));
//   print(DateFormat.jm().format(prayerTimes.dhuhr));
//   print(DateFormat.jm().format(prayerTimes.asr));
//   print(DateFormat.jm().format(prayerTimes.maghrib));
//   print(DateFormat.jm().format(prayerTimes.isha));

//   print('---');

//   // Example of calculating prayer times for a different location (New York).
//   print('New York Prayer Times');
//   final newYork = Coordinates(40.7128, -74.0060); // New York's coordinates.
//   const nyUtcOffset = Duration(hours: -4); // New York's UTC offset.

//   // Date for which you want the prayer times.
//   final nyDate = DateComponents(2024, 12, 3);
//   final nyParams = CalculationMethod.north_america.getParameters();
//   nyParams.madhab = Madhab.hanafi;

//   // Calculate prayer times for New York.
//   final nyPrayerTimes =
//       PrayerTimes(newYork, nyDate, nyParams, utcOffset: nyUtcOffset);

//   // Print New York prayer times.
//   print(nyPrayerTimes.fajr.timeZoneName);
//   print(DateFormat.jm().format(nyPrayerTimes.fajr));
//   print(DateFormat.jm().format(nyPrayerTimes.sunrise));
//   print(DateFormat.jm().format(nyPrayerTimes.dhuhr));
//   print(DateFormat.jm().format(nyPrayerTimes.asr));
//   print(DateFormat.jm().format(nyPrayerTimes.maghrib));
//   print(DateFormat.jm().format(nyPrayerTimes.isha));
// }
