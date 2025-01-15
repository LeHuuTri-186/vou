import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:vou/core/storage/hive_service.dart';

import '../../authentication/data/hive_keys.dart';

class QuizGameSocketService with WidgetsBindingObserver {
  late IO.Socket _socket;

  final HiveService _hiveService;

  QuizGameSocketService({required HiveService hiveService}) : _hiveService = hiveService;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _socket.disconnect(); // Disconnect when app goes to background
    } else if (state == AppLifecycleState.resumed) {
      _socket.connect(); // Reconnect when app resumes
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _socket.close();
    _socket.dispose(); // Clean up socket
  }

  void connect() {
    _socket = IO.io(
      'http://localhost:1001',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionDelay(1000)
          .build(),
    );
    WidgetsBinding.instance.addObserver(this);
    _socket.onConnectError((data) => debugPrint("Socket connection error: $data"));
    _socket.onConnect((_) => debugPrint("Socket connected"));
    _socket.onDisconnect((_) => debugPrint("Socket disconnected"));
  }

  void joinGame({required String gameOfEventId}) {
    _socket.emit('join', {'userId': _hiveService.get(HiveKeys.userId), 'gameOfEventId': gameOfEventId});
  }

  void leaveGame() {
    _socket.emit('leave', {'userId': _hiveService.get(HiveKeys.userId)});
  }

  void submitAnswer({
    required String questionId,
    required String choice,
    required String gameOfEventId,
  }) {
    _socket.emit('submit', {
      'questionId': questionId,
      'choice': choice,
      'gameOfEventId': gameOfEventId,
      'userId': _hiveService.get(HiveKeys.userId),
    });
  }

  void listenToEvent(String eventName, Function(dynamic) callback) {
    _socket.on(eventName, callback);
  }

  void disconnect() {
    _socket.disconnect();
  }
}
