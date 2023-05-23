// import 'package:authentication_repository/auth_repo.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:my_app/app_localisation.dart';
// import 'package:my_app/login/view/login_page.dart';
// import 'package:my_app/signup/view/signup_form.dart';
// import 'package:my_app/signup/view/signup_page.dart';

// // Mock dependencies
// class MockAuthRepository extends Mock implements AuthRepository {}

// class MockAppLocalizations extends Mock implements AppLocalizations {}

// void main() {
//   late MockAppLocalizations mockAppLocalizations;

//   setUp(() {
//     mockAppLocalizations = MockAppLocalizations();

//     when(mockAppLocalizations.translate('Sign_up')).thenReturn('Sign Up');
//   });

//   testWidgets('SignupPage widget test', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Builder(
//           builder: (BuildContext context) {
//             return Localizations(
//               delegates: const [
//                 DefaultMaterialLocalizations.delegate,
//                 DefaultWidgetsLocalizations.delegate,
//               ],
//               locale: const Locale('en'),
//               child: const SignupPage(),
//             );
//           },
//         ),
//       ),
//     );

//     expect(find.byType(SignupPage), findsOneWidget);

//     expect(find.byType(AppBar), findsOneWidget);
//     expect(find.byType(Scaffold), findsOneWidget);
//     expect(find.byType(SignupForm), findsOneWidget);

//     expect(find.text('Translated Sign Up'), findsOneWidget);

//     await tester.tap(find.text('Log_in'));
//     await tester.pumpAndSettle();

//     expect(find.byType(LoginPage), findsOneWidget);
//   });
// }
