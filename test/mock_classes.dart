// test/mock_classes.dart
import 'package:mockito/annotations.dart';
import 'package:news_app/domain/repositories/auth_repository.dart';
import 'package:news_app/domain/repositories/news_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/domain/usecases/auth_usecases.dart';
import 'package:news_app/domain/usecases/get_news_list.dart';

@GenerateMocks([AuthRepository, NewsRepository, User, SignInUseCase, SignOutUseCase, GetNewsList])
void main() {}
