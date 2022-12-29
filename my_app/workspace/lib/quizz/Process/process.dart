import 'package:flutter/material.dart';

var processList = [
  'Vital card',
  'Driver license',
  'Visa',
];

class Process extends StatelessWidget {
  const Process({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 450,
              height: 300,
              child:  Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 8.0,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Colors.grey.shade200,
                  child: const StartProcess(),
                ),
          ),
        ],
      );
  }
}

class QuizzProcess extends StatefulWidget {
  const QuizzProcess({
    Key? key,
  }) : super(key: key);

  @override
  State<QuizzProcess> createState() => _QuizzProcessState();
}

class _QuizzProcessState extends State<QuizzProcess> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
         IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
        // ignore: prefer_const_constructors
        ListTile(
          title: const Text('Card title 1', style: TextStyle(fontSize: 22), textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
            style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 18), textAlign: TextAlign.center,
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(153, 252, 105, 117),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      )),
              onPressed: () {},
              child: const Text(
                'No',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(178, 41, 201, 180),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
              onPressed: () {},
              child: const Text(
                'Yes',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StartProcess extends StatefulWidget {
  const StartProcess({
    Key? key,
  }) : super(key: key);

  @override
  State<StartProcess> createState() => _StartProcessState();
}

class _StartProcessState extends State<StartProcess> {
  late String dropdownvalue = 'Select';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
         IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
        // ignore: prefer_const_constructors
        ListTile(
          title: const Text('Card title 1', style: TextStyle(fontSize: 22), textAlign: TextAlign.center),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                    width: 200,
                    child: dropDown(context, processList, dropdownvalue)
              ),
            ),
            Center(
              child: TextButton(
                
          style: TextButton.styleFrom(
                padding: const EdgeInsets.all(18.0),
                backgroundColor: const Color.fromARGB(178, 41, 201, 180),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  )),
          onPressed: () {},
          child: const Text(
              'Start',
              style: TextStyle(fontSize: 22, color: Colors.white),
              textAlign: TextAlign.center,
          ),
        ),
            ),
          ],
        ),
      ],
    );
  }
}


Widget dropDown(BuildContext context, final List<String> items, String dropDownValue) {
  return (DropdownButton<String>(
    value: null,
    hint: const Text('Select Process'),
    icon: const Icon(
      Icons.arrow_downward,
      size: 20,
      color: Color.fromARGB(232, 25, 228, 150),
    ),
    underline: Container(
      height: 1,
      color: Colors.deepPurpleAccent,
    ),
    items: items.map((String item) {
      return DropdownMenuItem(
        value: item,
        child: Text(item),
      );
    }).toList(),
    onChanged: (_) {},
    //  (String? newValue) {
      // setState() {
      // dropDownValue = newValue!;
      // }
    // },
    disabledHint: const Text("Disabled"),
    elevation: 4,
    style: const TextStyle(color: Color.fromARGB(190, 158, 55, 144), fontSize: 18),
    iconDisabledColor: Colors.grey[350],
    iconEnabledColor: Colors.green,
    isExpanded: true,
  ));
}
