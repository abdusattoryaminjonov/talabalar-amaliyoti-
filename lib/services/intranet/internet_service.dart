import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tap/languages/app_localizations.dart';

class InternetService {
  InternetService._();
  static final InternetService instance = InternetService._();

  final Connectivity _connectivity = Connectivity();

  StreamSubscription? _connectivitySub;
  StreamSubscription? _internetSub;
  OverlaySupportEntry? _overlayEntry;

  bool isOffline = false;

  Future<void> initialize() async {
    _connectivitySub =
        _connectivity.onConnectivityChanged.listen((_) {
          _checkNow();
        });

    _internetSub =
        InternetConnectionChecker().onStatusChange.listen((status) {
          _update(status == InternetConnectionStatus.connected);
        });

    await _checkNow();
  }

  Future<void> _checkNow() async {
    final hasInternet =
    await InternetConnectionChecker().hasConnection;
    _update(hasInternet);
  }

  // 🎯 update
  void _update(bool hasInternet) {
    final newOffline = !hasInternet;

    if (newOffline == isOffline) return;

    isOffline = newOffline;

    if (isOffline) {
      _showBanner();
    } else {
      _hideBanner();
    }
  }

  void _showBanner() {
    _overlayEntry?.dismiss();

    _overlayEntry = showSimpleNotification(
      Row(
        children:  const [
          Icon(Icons.wifi_off, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "You're offline. Check your internet connection.",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      background: Colors.red,
      position: NotificationPosition.top,
      duration: const Duration(days: 1),
      slideDismissDirection: DismissDirection.up,
    );
  }

  void _hideBanner() {
    _overlayEntry?.dismiss();
    _overlayEntry = null;
  }

  void dispose() {
    _connectivitySub?.cancel();
    _internetSub?.cancel();
  }
}