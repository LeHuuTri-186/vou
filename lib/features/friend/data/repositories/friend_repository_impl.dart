import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/features/authentication/data/hive_keys.dart';
import 'package:vou/features/friend/data/datasources/friend_api_datasource.dart';
import 'package:vou/features/friend/domain/entities/friend.dart';
import 'package:vou/features/friend/domain/repositories/friend_repository.dart';

import '../../../../core/storage/hive_service.dart';
import '../models/friend_dto.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FriendApiDatasource _datasource;
  final HiveService _hiveService;

  FriendRepositoryImpl({required FriendApiDatasource datasource, required HiveService hiveService})
      : _datasource = datasource, _hiveService = hiveService;

  @override
  Future<Friend> findFriendByPhoneNum({required String phoneNum}) async {
    Response response =
        await _datasource.getUserByPhoneNum({"phoneNumber": phoneNum});

    if (response.statusCode == 201) {
      final friendDto = FriendDto(
        accountId: response.data["account"]["id"],
        firstName: response.data["firstName"],
        lastName: response.data["lastName"],
        phone: response.data["phone"],
        email: response.data["email"],
        facebook: response.data["facebook"],
        avatar: response.data["avatar"],
      );

      debugPrint(friendDto.toJson().toString());

      return friendDto.toDomain();
    } else {
      throw ("Failed to find friend with status code: ${response.statusCode}");
    }
  }

  @override
  Future<List<Friend>> getFriendList() async {
    Response response = await _datasource.getUserFriendList();

    if (response.statusCode == 200) {
      final List<dynamic> eventJsonList = response.data;

      final List<Friend> friendModels = eventJsonList
          .map((eventJson) => FriendDto.fromJson(eventJson).toDomain())
          .toList();

      return friendModels;
    } else {
      throw ("Failed to load friend list with status code: ${response.statusCode}");
    }
  }

  @override
  Future<void> addFriend({required String userId}) async {
    Response response = await _datasource.addFriend({"friendId":userId});

    if (response.statusCode == 201) {
      return;
    } else {
      throw ("Failed to add friend with status code: ${response.statusCode}");
    }
  }

  @override
  Future<void> unFriend({required String userId}) async {
    debugPrint("friendId: $userId");
    Response response = await _datasource.unFriend({"friendId": userId});

    if (response.statusCode == 200) {
      return;
    } else {
      throw ("Failed to add friend with status code: ${response.statusCode}");
    }
  }


  @override
  Future<void> shareTurn({required String userId, required String eventId}) async {

    final data = {
      "userId": _hiveService.get(HiveKeys.userId),
      "userTakeId": userId,
      "eventId": eventId,
      "turn": 1,
    };

    debugPrint(data.toString());

    Response response = await _datasource.shareTurn(data);

    if (response.statusCode == 201) {
      return;
    } else {
      throw ("Failed to add friend with status code: ${response.statusCode}");
    }
  }
}
