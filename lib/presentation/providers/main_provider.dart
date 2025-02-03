import 'package:flutter/material.dart';
import 'package:namer_app/domain/entities/temp_sessions.dart';

class MainProvider extends ChangeNotifier{

  List<TempSession> sessions = [];

  Future<void> getSessions() async {
  }
}