// ignore_for_file: avoid_returning_null_for_void

import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

import 'package:my_app/global.dart' as globals;
import '../../Settings/settings.dart';
import '../../lexique.dart';
import '../../propal_add.dart';
import '../../quizz/process/process.dart';
import '../../help/help.dart';
// import '../../app_localisation.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Header extends StatelessWidget {
  final void Function() closeDrawer;

  final void Function() openDrawer;

  const Header(
      {super.key, required this.closeDrawer, required this.openDrawer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu, size: 35.0),
          color: const Color.fromARGB(255, 96, 128, 118),
          onPressed: openDrawer,
        ),
        IconButton(
          icon: const Icon(Icons.phone, size: 35.0),
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

  imageDefault() {
    if (globals.globalUserPicture == null) {
      return const AssetImage('assets/avatar/NoAvatar.png');
    } else {
      return AssetImage(globals.globalUserPicture);
    }
  }

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
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: closeDrawer,
                      color: Color.fromARGB(185, 41, 41, 41),
                    ),
                  ],
                ),
                Material(
                    color: Colors.white,
                    elevation: 8,
                    shape: const CircleBorder(),
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
                            image: imageDefault(),
                            height: 75,
                            width: 75,
                            fit: BoxFit.cover,
                          ),
                        ))),
              ])),
          ListTile(
            leading: const Icon(Icons.create),
            title: Text(AppLocalizations.of(context)!.startNewProcess),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Quizz()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(AppLocalizations.of(context)!.profile),
            onTap: () {
              globals.tentativeLink = globals.globalUserPicture;
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: Text(AppLocalizations.of(context)!.calendar),
            onTap: () {
              Navigator.pushNamed(
                context,
                "/calendar",
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(AppLocalizations.of(context)!.lexique),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Lexique()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_upload_outlined),
            title: Text(AppLocalizations.of(context)!.suggestProcess),
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
                title: Text(AppLocalizations.of(context)!.help),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Help()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(AppLocalizations.of(context)!.settings),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage1()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: Text(AppLocalizations.of(context)!.logout),
                onTap: () {
                  Restart.restartApp();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
