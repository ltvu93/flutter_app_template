import 'dart:math';

import 'package:flutter_app_template/data/remote/app_dio.dart';
import 'package:flutter_app_template/data/remote/base_service.dart';
import 'package:flutter_app_template/models/api_error.dart';
import 'package:flutter_app_template/models/paging_data.dart';
import 'package:flutter_app_template/models/user.dart';

class UserEndpoints {
  static const String getProfile = '/user';
}

class UserService extends BaseService {
  final AppDio appDio;

  UserService(this.appDio);

  Future<String> login(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return 'fakeToken';
  }

  Future<User> getUser() async {
//    final data = await transformResponse(
//      () => appDio.get(
//        UserEndpoints.getProfile,
//        queryParameters: {
//          'userId': userId,
//        },
//      ),
//    );

    final headers = await appDio.getAuthHeader();
    if (headers['token'] == null) {
      throw UnAuthenticateError();
    }

    await Future.delayed(const Duration(seconds: 2));

    if (Random().nextInt(5) == 0) {
      throw UnknownError();
    }

    final fakeResponse = {
      'firstName': 'John',
      'lastName': 'Doe',
    };

    return User.fromJson(fakeResponse);
  }

  Future<PagingData<User>> getPagingUsers({
    int page = 1,
    int itemsPerPage = 30,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final Map<String, dynamic> fakeResponse = {
      'data': List.generate(
        itemsPerPage,
        (index) => {
          'firstName': 'user ${index + (page - 1) * itemsPerPage}',
        },
      ),
      'meta': {
        'current_page': page,
        'last_page': 5,
      },
    };

//    final response = await wrapE(() => dio.get(https://example.com/api/users?page=$page&per_page=$perPage));
    final response = fakeResponse;

    final users = response['data'] == null
        ? []
        : (response['data'] as List)
            .map((json) => User.fromJson(json))
            .toList();

    final currentPage = response["meta"]["current_page"] as int? ?? -1;
    final lastPage = response["meta"]["last_page"] as int? ?? -1;

    return PagingData<User>(
      items: users as List<User>,
      currentPage: currentPage,
      lastPage: lastPage,
    );
  }
}
