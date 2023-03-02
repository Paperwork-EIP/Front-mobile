import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../support.dart';
import 'Content/condition.dart';
import 'Content/log.dart';
import 'Content/policy.dart';
import 'Content/about.dart';

class SettingsPage1 extends StatelessWidget {
  const SettingsPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  _CustomListTile(
                      title: "Dark Mode",
                      icon: CupertinoIcons.moon,
                      trailing:
                          CupertinoSwitch(value: false, onChanged: (value) {})),
                  const _CustomListTile(
                    title: "Version",
                    icon: CupertinoIcons.device_phone_portrait,
                    trailing: Text("1.0"),
                  ),
                  const _CustomListTile(
                      title: "Change Log", icon: CupertinoIcons.cloud_download, widget: SettingsLog(),),
                  _CustomListTile(
                      title: "Suport", icon: CupertinoIcons.lock_shield, widget: Support(),),
                  const _CustomListTile(
                      title: "About", icon: CupertinoIcons.person_2, widget: SettingsAbout(),),
                ],
              ),
              const _SingleSection(
                title: "Privacy and Security",
                children: [
                  _CustomListTile(
                      title: "Condition générale d'utilisation",
                      icon: CupertinoIcons.lock),
                  _CustomListTile(
                      title: "Politique de confidentialité",
                      icon: CupertinoIcons.lock,
                      widget: SettingsPolicy(),),
                  _CustomListTile(
                      title: "Terms et condition",
                      icon: CupertinoIcons.lock,
                      widget: SettingsTandC()),
                  _CustomListTile(
                      title: "Supprimer le compte", 
                      icon: CupertinoIcons.delete),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Widget? widget;
  const _CustomListTile(
      {Key? key,
      required this.title,
      required this.icon,
      this.trailing,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: () {
        if (widget != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget!),
          );
        }
      },
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
