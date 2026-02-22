import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../data/service/location_service.dart';
import 'location_state.dart';
import '../data/service/prayer_api_service.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) => LocationNotifier(),
);

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(const LocationState());

  final _service = LocationService();
  final _prayerService = PrayerApiService();

  Future<void> loadLocation() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      Position position = await _service.getCurrentLocation();
      print("POSITION OK");

      final prayerTimes = await _prayerService.getPrayerTimes(
        position.latitude,
        position.longitude,
      );
      print("prayerTimes: ${prayerTimes.fajr}");

      state = state.copyWith(
        isLoading: false,
        latitude: position.latitude,
        longitude: position.longitude,
        prayerTimeModel: prayerTimes,
      );
      // } catch (e) {
      //   state = state.copyWith(isLoading: false, errorMessage: e.toString());
      // }
      print("STATUE UPDATED");
    } catch (e) {
      print("error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
