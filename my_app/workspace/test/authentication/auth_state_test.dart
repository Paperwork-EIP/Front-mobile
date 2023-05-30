// ignore_for_file: prefer_const_constructors
import 'package:paperwork/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repo.dart';

class MockUser extends Mock implements User {}

void main() {
  group('AuthState', () {
    group('AuthState.unknown', () {
      test('supports value comparisons', () {
        expect(
          AuthState.unknown(),
          AuthState.unknown(),
        );
      });
    });

    group('AuthState.authenticated', () {
      test('supports value comparisons', () {
        final user = MockUser();
        expect(
          AuthState.authenticated(user),
          AuthState.authenticated(user),
        );
      });
    });

    group('AuthState.unauthenticated', () {
      test('supports value comparisons', () {
        expect(
          AuthState.unauthenticated(),
          AuthState.unauthenticated(),
        );
      });
    });
  });
}
