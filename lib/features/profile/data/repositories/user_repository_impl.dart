import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/features/profile/data/datasources/user_api_datasource.dart';
import 'package:vou/features/profile/domain/entities/user_model.dart';
import 'package:vou/features/profile/domain/repositories/user_repository.dart';

import '../models/user_dto.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiDataSource _dataSource;

  UserRepositoryImpl({required UserApiDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<User> getUserDetail() async {
    Response response = await _dataSource.getUserDetail();
    debugPrint(response.data.toString());
    if (response.statusCode == 200) {
      User user = UserDto.fromJson(response.data).toDomain();

      return user;
    } else {
      throw("Get user failed with status code: ${response.statusCode}");
    }
  }

  @override
  Future<void> updateUser({String? firstName, String? lastName, String? email, String? avatar, String? phoneNumber}) async {
    final data = {
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (email != null) "email": email,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (avatar != null) "avatar": avatar
    };

    if (data.isEmpty) {
      throw("Empty data");
    }

    Response response = await _dataSource.updateUser(data);
    debugPrint(response.data.toString());
    if (response.statusCode == 201) {
      return;
    } else {
      throw("Update user failed with status code: ${response.statusCode}");
    }
  }
}