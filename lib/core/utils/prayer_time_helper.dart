import 'package:intl/intl.dart';
import '../../features/prayer_time/data/model/prayer_time_model.dart';

class PrayerTimeHelper {
  static Map<String, DateTime> buildPrayerDateTimes(PrayerTimeModel model) {
    final now = DateTime.now();

    DateTime parse(String time) {
      final clean = time.split(' ')[0]; // buang "(WIB)" kalau ada
      final format = DateFormat("HH:mm");
      final parsed = format.parse(clean);

      return DateTime(now.year, now.month, now.day, parsed.hour, parsed.minute);
    }

    return {
      "Fajr": parse(model.fajr),
      "Dhuhr": parse(model.dhuhr),
      "Asr": parse(model.asr),
      "Maghrib": parse(model.maghrib),
      "Isha": parse(model.isha),
    };
  }

  static MapEntry<String, DateTime>? getNextPrayer(PrayerTimeModel model) {
    final now = DateTime.now();
    final prayers = buildPrayerDateTimes(model);

    for (var entry in prayers.entries) {
      if (entry.value.isAfter(now)) {
        return entry;
      }
    }

    // kalau semua sudah lewat → besok Fajr
    final fajrTomorrow = prayers["Fajr"]!.add(const Duration(days: 1));
    return MapEntry("Fajr", fajrTomorrow);
  }

  static Duration getRemainingTime(DateTime target) {
    return target.difference(DateTime.now());
  }
}
