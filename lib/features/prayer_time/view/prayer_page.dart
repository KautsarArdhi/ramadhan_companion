import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/location_provider.dart';
import 'dart:async';
import 'package:ramadhan_companion/core/utils/prayer_time_helper.dart';
import 'package:ramadhan_companion/features/prayer_time/data/model/prayer_time_model.dart';

class PrayerPage extends ConsumerStatefulWidget {
  const PrayerPage({super.key});

  @override
  ConsumerState<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends ConsumerState<PrayerPage> {
  Timer? _timer;
  String? _nextPrayerName;
  Duration? _remaining;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(locationProvider.notifier).loadLocation();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown(PrayerTimeModel model) {
    final next = PrayerTimeHelper.getNextPrayer(model);
    if (next == null) return;

    _nextPrayerName = next.key;
    _remaining = PrayerTimeHelper.getRemainingTime(next.value);
    print('[_startCountdown] next=$_nextPrayerName remaining=$_remaining');

    // update UI immediately with computed next prayer + remaining
    setState(() {});

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        _timer?.cancel();
        return;
      }

      setState(() {
        _remaining = PrayerTimeHelper.getRemainingTime(next.value);
        // debug print to verify timer ticks
        // ignore: avoid_print
        print('[timer tick] remaining=${_remaining?.inSeconds}');

        // if time passed, restart to compute next prayer
        if (_remaining != null && _remaining!.inSeconds <= 0) {
          print('[timer] reached zero, advancing to next prayer');
          _startCountdown(model);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(locationProvider);

    // Start countdown once data available
    if (state.prayerTimeModel != null && _timer == null) {
      _startCountdown(state.prayerTimeModel!);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Ramadhan Companion")),
      body: Center(
        child: state.isLoading
            ? const CircularProgressIndicator()
            : state.errorMessage != null
            ? Text(state.errorMessage!)
            : state.prayerTimeModel == null
            ? const Text("Data tidak tersedia")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_nextPrayerName != null && _remaining != null)
                    Column(
                      children: [
                        Text(
                          "Next Prayer: $_nextPrayerName",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatDuration(_remaining!),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),

                  Text("Fajr: ${state.prayerTimeModel!.fajr}"),
                  Text("Dhuhr: ${state.prayerTimeModel!.dhuhr}"),
                  Text("Asr: ${state.prayerTimeModel!.asr}"),
                  Text("Maghrib: ${state.prayerTimeModel!.maghrib}"),
                  Text("Isha: ${state.prayerTimeModel!.isha}"),
                ],
              ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }
}
