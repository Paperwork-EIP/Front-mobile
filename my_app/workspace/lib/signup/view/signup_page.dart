import 'package:authentication_repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperwork/login/login.dart';
import 'package:paperwork/signup/signup.dart';
import 'package:google_fonts/google_fonts.dart';
// import '../../app_localisation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(41, 201, 179, 1),
        elevation: 0,
        title: Center(
            child: Text(
          AppLocalizations.of(context)!.signUp,
          style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700),
        )),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.logIn,
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
            return SignupBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthRepository>(context),
            );
          },
          child: const SignupForm(),
        ),
      ),
    );
  }
}
