import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: 'https://herc-backend-core-production.up.railway.app/'
);

final client = Dio(options);