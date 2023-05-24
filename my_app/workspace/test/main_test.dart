import 'package:flutter_test/flutter_test.dart';
import 'package:authentication_repository/auth_repo.dart';
import 'package:my_app/app.dart';
import 'package:user_repository/user_repo.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  testWidgets('App initializes with correct repositories',
      (WidgetTester tester) async {
    final mockAuthRepository = MockAuthRepository();
    final mockUserRepository = MockUserRepository();

    await tester.pumpWidget(App(
      authenticationRepository: mockAuthRepository,
      userRepository: mockUserRepository,
    ));

    expect(find.byType(App), findsOneWidget);
  });
}
