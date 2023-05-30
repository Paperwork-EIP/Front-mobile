import 'package:flutter/material.dart';
// import '../../app_localisation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsCGU extends StatelessWidget {
  const SettingsCGU({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cgu),
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              Text(AppLocalizations.of(context)!.cguTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(AppLocalizations.of(context)!.cguText,
                  style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
