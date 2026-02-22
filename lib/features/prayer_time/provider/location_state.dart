import '../data/model/prayer_time_model.dart';

class LocationState {
  final bool isLoading;
  final double? latitude;
  final double? longitude;
  final PrayerTimeModel? prayerTimeModel;
  final String? errorMessage;

  const LocationState({
    this.isLoading = false,
    this.latitude,
    this.longitude,
    this.prayerTimeModel,
    this.errorMessage,
  });

  LocationState copyWith({
    bool? isLoading,
    double? latitude,
    double? longitude,
    PrayerTimeModel? prayerTimeModel,
    String? errorMessage,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      prayerTimeModel: prayerTimeModel ?? this.prayerTimeModel,
      errorMessage: errorMessage,
    );
  }
}
