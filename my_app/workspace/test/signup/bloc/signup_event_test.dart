import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/signup/signup.dart';
import 'package:authentication_repository/auth_repo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:formz/formz.dart';

void main() {
  group('SignupBloc', () {
    late AuthRepository authRepository;
    late SignupBloc signupBloc;

    setUp(() {
      authRepository = AuthRepository();
      signupBloc = SignupBloc(authenticationRepository: authRepository);
    });

    test('initial state is correct', () {
      expect(signupBloc.state, const SignupState());
    });

    blocTest<SignupBloc, SignupState>(
      'emits correct state when SignupUsernameChanged event is added',
      build: () => signupBloc,
      act: (bloc) => bloc.add(SignupUsernameChanged('username')),
      expect: () => [
        SignupState(
          username: Username.dirty('username'),
          status:
              Formz.validate([Username.pure(), Email.pure(), Password.pure()]),
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits correct state when SignupEmailChanged event is added',
      build: () => signupBloc,
      act: (bloc) => bloc.add(SignupEmailChanged('email@example.com')),
      expect: () => [
        SignupState(
          email: Email.dirty('email@example.com'),
          status:
              Formz.validate([Username.pure(), Email.pure(), Password.pure()]),
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits correct state when SignupPasswordChanged event is added',
      build: () => signupBloc,
      act: (bloc) => bloc.add(SignupPasswordChanged('password')),
      expect: () => [
        SignupState(
          password: Password.dirty('password'),
          status:
              Formz.validate([Username.pure(), Email.pure(), Password.pure()]),
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits correct state when SignupSubmitted event is added and state is valid',
      build: () => signupBloc,
      act: (bloc) {
        bloc.add(SignupUsernameChanged('username'));
        bloc.add(SignupEmailChanged('email@example.com'));
        bloc.add(SignupPasswordChanged('password'));
        bloc.add(SignupSubmitted());
      },
      expect: () => [
        SignupState(
          status: FormzStatus.invalid,
          username: Username.dirty('username'),
          email: Email.pure(),
          password: Password.pure(),
        ),
        SignupState(
          username: Username.dirty('username'),
          email: Email.dirty('email@example.com'),
          password: Password.dirty('password'),
          status: FormzStatus.submissionInProgress,
        ),
        SignupState(
          username: Username.dirty('username'),
          email: Email.dirty('email@example.com'),
          password: Password.dirty('password'),
          status: FormzStatus.submissionSuccess,
        ),
      ],
    );
  });
}
