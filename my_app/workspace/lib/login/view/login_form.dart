import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperwork/login/login.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_localisation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Text(AppLocalizations.of(context)
                        .translate('Authentication_failure'))),
              );
          }
        },
        child: SingleChildScrollView(
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(padding: EdgeInsets.all(20)),
                _UsernameInput(),
                const Padding(padding: EdgeInsets.all(10)),
                const _PasswordInput(),
                const Padding(padding: EdgeInsets.all(40)),
                Wrap(
                  spacing: 30,
                  alignment: WrapAlignment.center,
                  children: [
                    _GoogleButton(),
                    _FacebookButton(),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(40)),
                _LoginButton(),
                const Padding(padding: EdgeInsets.all(10)),
                _ForgotButton(),
              ],
            ),
          ),
        ));
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return SizedBox(
            width: 500,
            height: 60,
            child: TextField(
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (username) =>
                  context.read<LoginBloc>().add(LoginUsernameChanged(username)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email',
                errorText: state.username.invalid
                    ? AppLocalizations.of(context).translate('Invalid_email')
                    : null,
              ),
            ));
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
            width: 500,
            height: 60,
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginBloc>().add(LoginPasswordChanged(password)),
              obscureText: _isObscure,
              decoration: InputDecoration(
                // suffix: TextButton(
                //   child: const Text("Show"),
                //   onPressed: () {_obscureText = !_obscureText;},
                //   style: TextButton.styleFrom(
                //       foregroundColor: const Color(0xFF29C9B3)),
                // ),
                suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: AppLocalizations.of(context).translate('Password'),
                errorText: state.password.invalid
                    ? AppLocalizations.of(context).translate('Invalid_password')
                    : null,
              ),
            ));
      },
    );
  }
}

class _GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      //     buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return IconButton(
            icon: Image.asset('assets/images/google_image.png'),
            iconSize: 50,
            onPressed: () {});
      },
    );
  }
}

class _FacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      //     buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return IconButton(
            icon: Image.asset('assets/images/facebook_image.png'),
            iconSize: 50,
            onPressed: () {});
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0))),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 100)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF29C9B3))),
                key: const Key('loginForm_continue_raisedButton'),
                child: Text(
                  AppLocalizations.of(context).translate('Log_in'),
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

class _ForgotButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 70)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: Text(
              AppLocalizations.of(context).translate('Forgot_password'),
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.pink),
            ),
            onPressed: () {});
      },
    );
  }
}
