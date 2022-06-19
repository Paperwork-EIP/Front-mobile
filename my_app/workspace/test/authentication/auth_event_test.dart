// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/auth_repo.dart';
import 'package:my_app/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationEvent', () {
    group('LoggedOut', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationLogoutRequested(),
          AuthenticationLogoutRequested(),
        );
      });
    });

    group('AuthStatusChanged', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationStatusChanged(AuthStatus.unknown),
          AuthenticationStatusChanged(AuthStatus.unknown),
        );
      });
    });
  });
}
