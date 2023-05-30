import 'package:authentication_repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/login/login.dart';
import 'package:my_app/signup/signup.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../../app_localisation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(41, 201, 179, 1),
        // foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.logIn,
          style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.signUp,
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthRepository>(context),
            );
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}
