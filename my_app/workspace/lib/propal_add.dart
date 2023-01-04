import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
SizedBox CreateInput(String name, String type, bool outline, double width,
    double height, TextEditingController _controller) {
  return SizedBox(
    width: width,
    height: height,
    child: TextField(
      controller: _controller,
      obscureText: (type == 'password') ? true : false,
      decoration: InputDecoration(
        border: outline ? const OutlineInputBorder() : null,
        labelText: name,
      ),
      style: const TextStyle(fontSize: 14),
    ),
  );
}

// ignore: use_key_in_widget_constructors
class AddPropal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controllerEmail = TextEditingController();
    final _controllerPassword = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 700,
                width: 420,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(33, 124, 204, 160),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Submit a new process idea',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    CreateInput('Title', 'title', true, 335, 60,
                        _controllerEmail),
                    CreateInput('Description', 'description', true, 335, 60,
                        _controllerPassword),
                    // CreateInput('Explain why this approach would be useful?', 'content', true, 335, 170,
                    //     _controllerPassword),
                    const SizedBox(
                    width: 335,
                    // height: height,
                      child: TextField(
                        // controller: _controller,
                        // obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Content',
                        ),
                        minLines: 10, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(130, 40), backgroundColor: const Color.fromARGB(255, 82, 185, 137)),
                      // ),
                      onPressed: () {},
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}