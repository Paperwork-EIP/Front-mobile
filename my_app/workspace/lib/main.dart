import 'package:authentication_repository/auth_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/app.dart';
import 'package:user_repository/user_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(App(
    authenticationRepository: AuthRepository(),
    userRepository: UserRepository(),
  ));
}
