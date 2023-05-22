// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/signUp/bloc/signup_bloc.dart';

void main() {
  const username = 'mock-username';
  const password = 'mock-password';
  group('SignUpEvent', () {
    group('SignUpUsernameChanged', () {
      test('supports value comparisons', () {
        expect(
            SignupUsernameChanged(username), SignupUsernameChanged(username));
      });
    });

    group('SignUpPasswordChanged', () {
      test('supports value comparisons', () {
        expect(
            SignupPasswordChanged(password), SignupPasswordChanged(password));
      });
    });

    group('SignUpSubmitted', () {
      test('supports value comparisons', () {
        expect(SignupSubmitted(), SignupSubmitted());
      });
    });
  });
}
