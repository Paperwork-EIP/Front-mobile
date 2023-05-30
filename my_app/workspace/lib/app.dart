import 'package:authentication_repository/auth_repo.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperwork/locale_provider.dart';
import 'package:paperwork/auth/auth.dart';
import 'package:paperwork/calendar/calendar.dart';
import 'package:paperwork/profile/profile.dart';
import 'package:paperwork/home/home.dart';
import 'package:paperwork/login/login.dart';
import 'package:paperwork/signup/signup.dart';
import 'package:paperwork/splash/splash.dart';
import 'package:user_repository/user_repo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:my_app/l10n/support_locale.dart';

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
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          return Consumer<LocaleProvider>(builder: (context, provider, child) {
            return MaterialApp(
              locale: provider.locale,
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: EasyDynamicTheme.of(context).themeMode,
              supportedLocales: L10n.support,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
              ],
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
                '/profile': (context) => Profile(),
              },
            );
          });
        });
  }
}
