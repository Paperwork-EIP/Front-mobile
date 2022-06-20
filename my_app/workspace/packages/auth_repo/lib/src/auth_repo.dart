import 'dart:async';
import 'dart:convert';

//import 'package:http/http.dart';

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
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthStatus.authenticated),
    );
  }

/*
  static Future<LoginResponse> _sendLoginInfo(
      String email, String password, String logType) async {
    String uri = Env.hostIp + logType;
    final response = await http.post(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode({
        'mail': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      await FlutterSession()
          .set('token', jsonDecode(response.body)['accessToken']);
      return LoginResponse(
          name: jsonDecode(response.body)['name'],
          accessToken: jsonDecode(response.body)['accessToken']);
    } else {
      throw Exception("Can't send login info to server");
    }
  }
}
*/
  Future<void> SignUp({
    required String username,
    required String email,
    required String password,
  }) async {
/*    String uri = "host/path/...";
    final response = await http.post(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode({
        'username': username,
        'mail': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);*/
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller
            .add(AuthStatus.authenticated), // TODO : save session token here
      );
/*    } else {
      throw Exception("Can't send login info to server");
    }*/
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

// used to close the StreamController when it is no longer needed
  void dispose() => _controller.close();
}
