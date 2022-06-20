part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Email email;
  final Password password;

  SignupState copyWith({
    FormzStatus? status,
    Username? username,
    Email? email,
    Password? password,
  }) {
    return SignupState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, email, password];
}
