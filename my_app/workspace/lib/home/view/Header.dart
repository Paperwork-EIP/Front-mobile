// ignore_for_file: avoid_returning_null_for_void

import 'package:flutter/material.dart';

import '../../propal_add.dart';
import '../../quizz/process/process.dart';

class Header extends StatelessWidget {
  final void Function() closeDrawer;

  final void Function() openDrawer;

  const Header(
      {super.key, required this.closeDrawer, required this.openDrawer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu),
          color: const Color(0xFF29C9B3),
          onPressed: openDrawer,
        ),
        IconButton(
          icon: const Icon(Icons.phone),
          color: const Color(0xFFFC6976),
          onPressed: () {},
        ),
      ],
    );
  }
}

class NavBar extends StatelessWidget {
  final void Function() closeDrawer;

  const NavBar({super.key, required this.closeDrawer});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: closeDrawer,
                    ),
                  ],
                ),
                Container(
                  child: Material(
                      color: Colors.blue,
                      elevation: 8,
                      shape: const CircleBorder(),
                      // borderRadius: BorderRadius.circular(1000),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                          splashColor: Colors.black26,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white, width: 3),
                              shape: BoxShape.circle,
                            ),
                            child: Ink.image(
                              image: AssetImage('assets/makima.png'),
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                            ),
                          ))),
                )
                //   margin: const EdgeInsets.only(top: 10),
                //   height: 80,
                //   width: 80,
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage('assets/makima.png'),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.create),
            title: const Text('Start a new Process'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Process()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Calendar'),
            onTap: () {
              Navigator.pushNamed(
                context,
                "/calendar",
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_upload_outlined),
            title: const Text('Suggest a process'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPropal()),
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help'),
                onTap: () => null,
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => null,
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Logout'),
                onTap: () => null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
