import 'package:authentication_repository/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:formz/formz.dart';
import 'package:my_app/signup/signup.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignupBloc signupBloc;
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    signupBloc = SignupBloc(authenticationRepository: authRepository);
  });

  tearDown(() {
    signupBloc.close();
  });

  group('SignupBloc', () {
    const username = 'test_username';
    const email = 'test_email@example.com';
    const password = 'test_password';

    test('initial state is correct', () {
      expect(signupBloc.state, const SignupState());
    });

    blocTest<SignupBloc, SignupState>(
      'emits the correct state when SignupUsernameChanged event is added',
      build: () => signupBloc,
      act: (bloc) => bloc.add(const SignupUsernameChanged(username)),
      expect: () => [
        const SignupState(
          username: Username.dirty(username),
          status: FormzStatus.invalid,
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits the correct state when SignupEmailChanged event is added',
      build: () => signupBloc,
      act: (bloc) => bloc.add(const SignupEmailChanged(email)),
      expect: () => [
        const SignupState(
          email: Email.dirty(email),
          status: FormzStatus.invalid,
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits the correct state when SignupPasswordChanged event is added',
      build: () => signupBloc,
      act: (bloc) => bloc.add(const SignupPasswordChanged(password)),
      expect: () => [
        const SignupState(
          password: Password.dirty(password),
          status: FormzStatus.invalid,
        ),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits the correct states when SignupSubmitted event is added',
      setUp: () {
        when(authRepository.SignUp(
          username: username,
          email: email,
          password: password,
        )).thenAnswer((_) => Future<String>.value('user'));
      },
      build: () => signupBloc,
      act: (bloc) => bloc
        ..add(const SignupPasswordChanged(username))
        ..add(const SignupPasswordChanged(email))
        ..add(const SignupPasswordChanged(password))
        ..add(const SignupSubmitted()),
      expect: () => [
        const SignupState(
          username: Username.dirty(username),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.valid,
        ),
        const SignupState(
          username: Username.dirty(username),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionInProgress,
        ),
        const SignupState(
          username: Username.dirty(username),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionSuccess,
        ),
      ],
      verify: (_) {
        verify(authRepository.SignUp(
          username: username,
          email: email,
          password: password,
        )).called(1);
      },
    );

    blocTest<SignupBloc, SignupState>(
      'emits the correct states when SignupSubmitted event is added and fails',
      setUp: () {
        when(authRepository.SignUp(
          username: username,
          email: email,
          password: password,
        )).thenThrow(Exception('Failed to sign up'));
      },
      build: () => signupBloc,
      act: (bloc) => bloc
        ..add(const SignupPasswordChanged(username))
        ..add(const SignupPasswordChanged(email))
        ..add(const SignupPasswordChanged(password))
        ..add(const SignupSubmitted()),
      expect: () => [
        const SignupState(
          username: Username.dirty(username),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.valid,
        ),
        const SignupState(
          username: Username.dirty(username),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionInProgress,
        ),
        const SignupState(
          username: Username.dirty(username),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionFailure,
        ),
      ],
      verify: (_) {
        verify(authRepository.SignUp(
          username: username,
          email: email,
          password: password,
        )).called(1);
      },
    );
  });
}
