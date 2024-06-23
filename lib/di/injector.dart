import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/network/api_client.dart';
import 'package:news_app/core/network/dio_interceptor.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/data/datasources/remote/auth_service.dart';
import 'package:news_app/data/datasources/remote/news_api_service.dart';
import 'package:news_app/data/repositories/auth_repository_impl.dart';
import 'package:news_app/data/repositories/news_repository_impl.dart';
import 'package:news_app/domain/repositories/auth_repository.dart';
import 'package:news_app/domain/repositories/news_repository.dart';
import 'package:news_app/domain/usecases/get_news_list.dart';
import 'package:news_app/domain/usecases/auth_usecases.dart';
import 'package:news_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:news_app/presentation/blocs/news_bloc/news_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/core/services/firebase_analytics_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => ApiClient(sl()));
  sl.registerLazySingleton(() => DioInterceptor(sl()));
  sl.registerLazySingleton(() => FirebaseAnalyticsService());

  // Services
  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl(sl()));
  sl.registerLazySingleton<NewsApiService>(() => NewsApiServiceImpl(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authService: sl()));
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(newsApiService: sl(), networkInfo: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNewsList(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(signInUseCase: sl(), signOutUseCase: sl(), analyticsService: sl()));
  sl.registerFactory(() => NewsBloc(getNewsList: sl()));
}
