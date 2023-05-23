import 'package:flutter/material.dart';

class SettingsLog extends StatelessWidget {
  const SettingsLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log"),
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('\n\nPaperwork Log',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "\n\nBe aware of the latest updates and new features implemented. Here's what's changed since the last update:\n\n\n                   Account Verification\n                   Privacy Policy\n                   Adding the datepicker in the calendar\n",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
