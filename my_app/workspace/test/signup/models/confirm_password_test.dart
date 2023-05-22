// ignore_for_file: prefer_const_constructors
import 'package:my_app/signup/models/confirm_password.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const confirmPasswordString = 'mock-confirmPassword';
  const differentConfirmPasswordString = 'mock-differentConfirmPassword';
  group('Confirm confirmPassword', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final confirmPassword = ConfirmPassword.pure();
        expect(confirmPassword.value, '');
        expect(confirmPassword.pure, true);
      });

      test('dirty creates correct instance', () {
        final confirmPassword = ConfirmPassword.dirty(
            password: confirmPasswordString, value: confirmPasswordString);
        expect(confirmPassword.value, confirmPasswordString);
        expect(confirmPassword.pure, false);
      });
    });

    group('validator', () {
      test(
          'returns missmatch error when password and confirm password missmatch',
          () {
        expect(
          ConfirmPassword.dirty(
                  password: differentConfirmPasswordString,
                  value: confirmPasswordString)
              .error,
          ConfirmedPasswordValidationError.mismatch,
        );
      });

      test('is valid when confirmPassword is not empty', () {
        expect(
          ConfirmPassword.dirty(password: confirmPasswordString).error,
          ConfirmedPasswordValidationError.invalid,
        );
      });

      test('is valid when confirmPassword is not empty', () {
        expect(
          ConfirmPassword.dirty(
                  password: confirmPasswordString, value: confirmPasswordString)
              .error,
          isNull,
        );
      });
    });
  });
}
