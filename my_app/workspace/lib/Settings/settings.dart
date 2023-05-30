import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../../app_localisation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../support.dart';
import 'Content/condition.dart';
import 'Content/log.dart';
import 'Content/policy.dart';
import 'Content/about.dart';

class SettingsPage1 extends StatefulWidget {
  const SettingsPage1({Key? key}) : super(key: key);

  @override
  State<SettingsPage1> createState() => _SettingsPage1State();
}

class _SettingsPage1State extends State<SettingsPage1> {
  // late bool mode = Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings,),
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: AppLocalizations.of(context)!.general,
                children: [
                  _CustomListTile(
                      title: AppLocalizations.of(context)!.darkMode,
                      icon: CupertinoIcons.moon,
                      trailing: CupertinoSwitch(
                          value:
                              Theme.of(context).brightness == Brightness.dark,
                          onChanged: (value) {
                            EasyDynamicTheme.of(context).changeTheme();
                            // mode = !mode;
                          })),
                  _CustomListTile(
                    title: AppLocalizations.of(context)!.version,
                    icon: CupertinoIcons.device_phone_portrait,
                    trailing: const Text("1.0"),
                  ),
                  _CustomListTile(
                    title: AppLocalizations.of(context)!.changeLog,
                    icon: CupertinoIcons.cloud_download,
                    widget: const SettingsLog(),
                  ),
                  _CustomListTile(
                    title: AppLocalizations.of(context)!.support,
                    icon: CupertinoIcons.lock_shield,
                    widget: Support(),
                  ),
                  _CustomListTile(
                    title: AppLocalizations.of(context)!.about,
                    icon: CupertinoIcons.person_2,
                    widget: const SettingsAbout(),
                  ),
                ],
              ),
              _SingleSection(
                title: AppLocalizations.of(context)!.privacyAndSecurity,
                children: [
                  _CustomListTile(
                      title: AppLocalizations.of(context)!.generalTermsAndConditionsOfUse,
                      icon: CupertinoIcons.lock),
                  _CustomListTile(
                    title: AppLocalizations.of(context)!.privacyPolicy,
                    icon: CupertinoIcons.lock,
                    widget: const SettingsPolicy(),
                  ),
                  _CustomListTile(
                      title: AppLocalizations.of(context)!.termsAndProcedures,
                      icon: CupertinoIcons.lock,
                      widget: const SettingsTandC()),
                  _CustomListTile(
                      title: AppLocalizations.of(context)!.deleteAccount,
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

  Color setColor(bool value) {
    if (value) {
      return Color.fromARGB(166, 78, 80, 79);
    } else {
      return Colors.white;
    }
  }

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
          color: setColor(Theme.of(context).brightness == Brightness.dark),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
