// ignore_for_file: prefer_const_constructors
import 'package:my_app/signup/signup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const emailString = 'mock-email@test.com';
  const invalidEmailString = 'mock-email';

  group('Email', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final email = Email.pure();
        expect(email.value, '');
        expect(email.pure, true);
      });

      test('dirty creates correct instance', () {
        final email = Email.dirty(emailString);
        expect(email.value, emailString);
        expect(email.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when email is empty', () {
        expect(
          Email.dirty('').error,
          EmailValidationError.empty,
        );
      });

      test('is valid when email is not empty', () {
        expect(
          Email.dirty(emailString).error,
          isNull,
        );
      });

      test('is valid when email is invalid', () {
        expect(
          Email.dirty(invalidEmailString).error,
          EmailValidationError.invalid,
        );
      });
    });
  });
}
