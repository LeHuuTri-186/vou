// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vou/features/authentication/bloc/auth_cubit.dart';
import 'package:vou/features/authentication/bloc/auth_state.dart';

import 'package:vou/main.dart';

void main() {
  group('Authentication', () {
    late AuthCubit authCubit;

    setUp(() async {
      final storage = await HydratedStorage.build(
          storageDirectory: UniversalPlatform.isWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory()
      );
      HydratedBloc.storage = storage;
      authCubit = AuthCubit();
    });

    tearDown(() {
      authCubit.close();
    });

    test('initial state is AuthLoading', () {
      // Assert the initial state is AuthLoading
      expect(authCubit.state.runtimeType, AuthLoading);
    });
  });
}
