import 'package:authentication_repository/auth_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/app.dart';
import 'package:user_repository/user_repo.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthRepository(),
    userRepository: UserRepository(),
  ));
}
