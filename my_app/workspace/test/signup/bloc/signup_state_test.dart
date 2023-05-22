// ignore_for_file: prefer_const_constructors
import 'package:my_app/signup/Signup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  const username = Username.dirty('username');
  const email = Email.dirty('email');
  const password = Password.dirty('password');
  group('SignupState', () {
    test('supports value comparisons', () {
      expect(SignupState(), SignupState());
    });

    test('returns same object when no properties are passed', () {
      expect(SignupState().copyWith(), SignupState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        SignupState().copyWith(status: FormzStatus.pure),
        SignupState(status: FormzStatus.pure),
      );
    });

    test('returns object with updated username when username is passed', () {
      expect(
        SignupState().copyWith(username: username),
        SignupState(username: username),
      );
    });

    test('returns object with updated email when username is passed', () {
      expect(
        SignupState().copyWith(email: email),
        SignupState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        SignupState().copyWith(password: password),
        SignupState(password: password),
      );
    });
  });
}
