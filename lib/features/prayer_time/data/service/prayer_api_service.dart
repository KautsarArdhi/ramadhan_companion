import 'dart:async';

import 'package:dio/dio.dart';
import '../model/prayer_time_model.dart';

class PrayerApiService {
  final Dio _dio = Dio();

  Future<PrayerTimeModel> getPrayerTimes(double lat, double lng) async {
    print("Calling API with lat: $lat, lng: $lng");

    final now = DateTime.now();
    final date = "${now.day}-${now.month}-${now.year}";

    final response = await _dio.get(
      "https://api.aladhan.com/v1/timings/$date",
      queryParameters: {
        "latitude": lat,
        "longitude": lng,
        "method": 20, // Kemenag Indonesia
      },
    );
    print("FULL RESPONSE: ${response.data}");
    return PrayerTimeModel.fromJson(response.data["data"]["timings"]);
  }
}
