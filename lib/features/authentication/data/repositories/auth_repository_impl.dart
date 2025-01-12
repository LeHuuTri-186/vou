import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/authentication/data/datasources/auth_api_datasource.dart';
import 'package:vou/features/authentication/data/models/sign_up_data_dto.dart';
import 'package:vou/features/authentication/domain/entities/sign_up_data_model.dart';

import '../../domain/repositories/auth_repository.dart';
import '../hive_keys.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDatasource _datasource;
  final HiveService _hiveService;

  AuthRepositoryImpl({required AuthApiDatasource datasource, required HiveService hiveService}) : _datasource = datasource, _hiveService = hiveService;

  @override
  Future<String?> getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> login({required String username, required String password}) async {
    Response response = await _datasource.login(username, password);
    if (response.statusCode == 201) {
      await _hiveService.save(HiveKeys.accessToken, response.data['accessToken']);
      await _hiveService.save(HiveKeys.refreshToken, response.data['refreshToken']);
      await _hiveService.save(HiveKeys.userId, response.data['userId']);

      return;
    } else {
      throw Exception(response.statusMessage??'Failed to sign in account: ${response.statusCode}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _hiveService.delete(HiveKeys.accessToken);
      await _hiveService.delete(HiveKeys.refreshToken);
      await _hiveService.delete(HiveKeys.userId);
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<bool> refreshToken() {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> requestOtp({required String email}) async {
    Response response = await _datasource.getOtp(email);

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.statusMessage??'Failed to fetch Otp: ${response.statusCode}');
    }
  }

  @override
  Future<void> signUp({required SignUpDataModel model}) async {
    Response response = await _datasource.signUp(SignUpDataDto.fromDomain(model));

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.statusMessage??'Failed to register account: ${response.statusCode}');
    }
  }
}