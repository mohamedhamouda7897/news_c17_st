import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  // Private constructor
  InternetChecker._internal();

  // Singleton instance
  static final InternetChecker _instance = InternetChecker._internal();

  // Factory constructor
  factory InternetChecker() => _instance;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  /// Stream to listen for internet status changes
  final StreamController<bool> _internetStatusController =
      StreamController<bool>.broadcast();

  Stream<bool> get internetStatusStream => _internetStatusController.stream;

  /// Start listening to connectivity changes
  void initialize() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) async {
      final hasInternet = await _hasActualInternet();
      _internetStatusController.add(hasInternet);
    });
  }

  /// Check internet once
  Future<bool> hasInternet() async {
    return await _hasActualInternet();
  }

  /// Dispose resources (optional, usually not needed for app-wide singleton)
  void dispose() {
    _subscription?.cancel();
    _internetStatusController.close();
  }

  /// Real internet check (DNS lookup)
  Future<bool> _hasActualInternet() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
