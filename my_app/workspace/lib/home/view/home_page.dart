import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/auth/auth.dart';
import 'package:my_app/propal_add.dart';

/*class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                // final userId = context.select(
                //   (AuthenticationBloc bloc) => bloc.state.user.id,
                // );
                //Text('UserID: $userId')
                return const Profile();
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}*/

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  final String title = 'profile';
  final String username = 'Sandros';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(252, 105, 118, 1),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                // Expanded(
                // child:
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 200,
                  color: const Color.fromRGBO(252, 105, 118, 1),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(right: 40),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Settings',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(right: 40, bottom: 10),
                        child: Text(
                          username,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(AuthenticationLogoutRequested());
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // ),
                Container(
                    child: Column(children: const [
                  Text(
                    'Your current processes',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Image(image: AssetImage('assets/Bar Line.png'))
                ])),
              ],
            ),
            Positioned(
              top: 20.0,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/makima.png'),
                    fit: BoxFit.cover,
                  ),
                  // borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 300,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(252, 105, 118, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.red))),
                  onPressed: () {},
                  child: const Text(
                    'Calendar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPropal()),
              );
            },
            child: Text(
              'Add Propal',
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF29C9B3)),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
