import 'package:flutter/material.dart';

class Lexique extends StatelessWidget {
  const Lexique({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lexique"),
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView.builder(
            itemCount: _articles.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _articles[index];
              return Container(
                height: 150,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.author,
                          style: Theme.of(context).textTheme.labelSmall,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(mainAxisSize: MainAxisSize.min, children: const [
                          Icon(
                            Icons.add_link,
                          ),
                        ])
                      ],
                    )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String author;

  Article({
    required this.title,
    required this.author,
  });
}

final List<Article> _articles = [
  Article(
    title: "Vital card",
    author:
        "Health insurance policies typically cover a wide range of medical expenses, such as hospitalization, surgical procedures, prescription drugs, laboratory tests, and doctor visits. Some policies may also cover specialized treatments such as dental, vision, or mental health care.",
  ),
  Article(
    title: "Passeport",
    author:
        "A passport is a travel document that is issued by a government to its citizens for the purpose of international travel. It is an official proof of identity and citizenship that allows the passport holder to enter and exit foreign countries, and to request assistance and protection from their government while abroad.",
  ),
  Article(
    title: "Visa",
    author:
        "A visa is an official document or endorsement placed in a passport that allows the passport holder to enter, stay, or exit a foreign country for a specific period of time and for a specific purpose. The purpose of a visa is to regulate and control the entry and stay of foreign visitors in a country.",
  ),
  Article(
    title: "Proof of residence",
    author:
        "A proof of address is a document that verifies where you live. It is often required as a form of identification when you need to open a bank account, apply for credit, or get a government-issued ID card. A proof of address can take many forms, but it typically includes your name, your address, and a date",
  ),
];
