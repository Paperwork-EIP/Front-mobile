import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/signup/signup.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }
        },
        child: SingleChildScrollView(
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _UsernameInput(),
                const Padding(padding: EdgeInsets.all(10)),
                _EmailInput(),
                const Padding(padding: EdgeInsets.all(10)),
                _PasswordInput(),
                const Padding(padding: EdgeInsets.all(10)),
                _ConfirmPasswordInput(),
                const Padding(padding: EdgeInsets.all(30)),
                Wrap(
                  spacing: 50,
                  alignment: WrapAlignment.center,
                  children: [
                    _GoogleButton(),
                    _FacebookButton(),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(30)),
                _SignupButton(),
              ],
            ),
          ),
        )
      );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return SizedBox(
            width: 500,
            height: 60,
            child: TextField(
              key: const Key('signupForm_usernameInput_textField'),
              onChanged: (username) => context
                  .read<SignupBloc>()
                  .add(SignupUsernameChanged(username)),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Username',
                errorText: state.username.invalid ? 'invalid username' : null,
              ),
            ));
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SizedBox(
            width: 500,
            height: 60,
            child: TextField(
              key: const Key('signupForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<SignupBloc>().add(SignupEmailChanged(email)),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Email',
                errorText: state.email.invalid ? 'invalid email' : null,
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
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
            width: 500,
            height: 60,
            child: TextField(
              key: const Key('signupForm_passwordInput_textField'),
              onChanged: (password) => context
                  .read<SignupBloc>()
                  .add(SignupPasswordChanged(password)),
              obscureText: _isObscure,
              decoration: InputDecoration(
                // suffix: TextButton(
                //   child: const Text("Show"),
                //   onPressed: () {},
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Password',
                errorText: state.password.invalid ? 'invalid password' : null,
              ),
            ));
      },
    );
  }
}

class _ConfirmPasswordInput extends StatefulWidget {
  const _ConfirmPasswordInput({Key? key}) : super(key: key);

  @override
  State<_ConfirmPasswordInput> createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<_ConfirmPasswordInput> {
  bool _isObscure = true;
  @override
  
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
            width: 500,
            height: 60,
            child: TextField(
              key: const Key('signupForm_passwordInput_textField'),
              onChanged: (password) => context
                  .read<SignupBloc>()
                  .add(SignupPasswordChanged(password)),
              obscureText: _isObscure,
              decoration: InputDecoration(
                // suffix: TextButton(
                //   child: const Text("Show"),
                //   onPressed: () {},
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Confirm Password',
                errorText: state.password.invalid ? 'invalid password' : null,
              ),
            ));
      },
    );
  }
}

class _GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      //     buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return IconButton(
            icon: Image.asset('assets/images/google_image.png'),
            iconSize: 70,
            onPressed: () {});
      },
    );
  }
}

class _FacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      //     buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return IconButton(
            icon: Image.asset('assets/images/facebook_image.png'),
            iconSize: 70,
            onPressed: () {});
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
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
                            vertical: 20, horizontal: 120)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF29C9B3))),
                key: const Key('signupForm_continue_raisedButton'),
                child: Text(
                  'Sign up',
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<SignupBloc>().add(const SignupSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
