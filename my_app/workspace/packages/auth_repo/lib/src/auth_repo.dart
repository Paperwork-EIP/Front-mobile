import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/global.dart' as globals;
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthStatus>();

//state of auth status : used when a user signs in or out
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    var response;
    globals.email = email;
    print(json.encode({
      'email': email,
      'password': password,
    }));
    try {
      response = await http.post(
        Uri.parse("${dotenv.get('SERVER_URL')}/user/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({"email": email, "password": password}),
      );
      if (response.statusCode == 200) {
        _controller.add(AuthStatus.authenticated);
      }
    } catch (e) {
      print('r= ${response}');
      print(e);
    }
  }

  Future<void> SignUp({
    required String username,
    required String email,
    required String password,
  }) async {
    var response;
    print(json.encode({
      'username': username,
      'email': email,
      'password': password,
    }));
    try {
      response = await http.post(
        Uri.parse("${dotenv.get('SERVER_URL')}/user/register"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(
            {"email": email, "password": password, 'username': username}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        _controller.add(AuthStatus.authenticated);
      }
    } catch (e) {
      print('r= ${response}');
      print(e);
    }
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

// used to close the StreamController when it is no longer needed
  void dispose() => _controller.close();
}
