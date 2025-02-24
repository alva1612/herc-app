import 'package:dio/dio.dart';
import 'package:namer_app/config/env.dart';

final options = BaseOptions(
  baseUrl: const String.fromEnvironment(EnvironmentKey.baseUrl)
);

final client = Dio(options);