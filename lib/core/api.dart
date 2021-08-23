import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/app_repository.dart';
import 'package:hava/models/user_model.dart';

class ApiNew {
  final BuildContext context;

  ApiNew(this.context);

  UserRepository get userRep => RepositoryProvider.of<UserRepository>(context);

  UserModel? get user => userRep.user;
  final _dio = Dio();

  Future requestApi(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      required Options options,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    debugPrint('path $path');
    debugPrint('data $data');
    debugPrint('queryParameters $queryParameters');
    try {
      if (user != null && user!.userToken.isNotEmpty) {
        options.headers = {'Authorization': 'Bearer ${user!.userToken}'};
        debugPrint('accessToken ${options.headers}');
      }
      if (userRep.tokenRaw.isNotEmpty) {
        options.headers = {'Authorization': 'Bearer ${userRep.tokenRaw}'};
        debugPrint('accessTokenRaw ${options.headers}');
      }

      Response response = await _dio.request(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      //check ?
      final res = response.data;
      return res;
    } catch (e, stack) {
      debugPrint('Exception: $e - $stack');
    }
  }

  Future methodGet({required String api, Map<String, dynamic>? queries}) {
    return requestApi(
      api,
      queryParameters: queries,
      options: Options(method: 'GET', responseType: ResponseType.json),
    );
  }

  Future methodPost(
      {required String api, Object? body, Function(int, int)? onSendProgress}) {
    return requestApi(
      api,
      data: body,
      options: Options(method: 'POST', responseType: ResponseType.json),
      onSendProgress: onSendProgress,
    );
  }

  Future methodPut(
      {required String api, Object? body, Function(int, int)? onSendProgress}) {
    return requestApi(
      api,
      data: body,
      options: Options(method: 'PUT', responseType: ResponseType.json),
      onSendProgress: onSendProgress,
    );
  }

  Future methodDel(
      {required String api, Map<String, dynamic>? query, Object? body}) {
    return requestApi(
      api,
      data: body,
      queryParameters: query,
      options: Options(method: 'DELETE', responseType: ResponseType.json),
    );
  }
}
