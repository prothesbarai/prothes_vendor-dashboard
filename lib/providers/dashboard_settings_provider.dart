import 'package:flutter/material.dart';

class DashboardSettingsProvider with ChangeNotifier{
  bool _play = true;
  bool get isPlayOrPause => _play;

  void togglePlayPauseStatus() {
    _play = !_play;
    notifyListeners();
  }
}