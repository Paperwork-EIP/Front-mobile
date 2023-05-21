import 'package:authentication_repository/auth_repo.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/auth/auth.dart';
import 'package:my_app/calendar.dart';
import 'package:my_app/profile/profile.dart';
import 'package:my_app/home/home.dart';
import 'package:my_app/login/login.dart';
import 'package:my_app/signup/signup.dart';
import 'package:my_app/splash/splash.dart';
import 'package:user_repository/user_repo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localisation.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: EasyDynamicThemeWidget(
            child: const AppView(),
          ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), 
      darkTheme: ThemeData.dark(), 
      themeMode: EasyDynamicTheme.of(context).themeMode,
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('fr', 'FR'), // French
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      //   // DefaultCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: HomePage(),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                _navigator.pushAndRemoveUntil<void>(
                  SignupPage.route(),
                  (route) => false,
                );
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
      routes: {
        '/calendar': (context) => const CalendarPage(),
        '/profile' : (context) => Profile(),
      },
    );
  }
}
