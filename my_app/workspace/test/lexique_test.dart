import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/lexique.dart';

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
];

void main() {
  testWidgets('Lexique widget displays articles correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Lexique(),
    ));

    expect(find.text('Lexique'), findsWidgets);

    for (var article in _articles) {
      expect(find.text(article.title), findsWidgets);
      expect(find.text(article.author), findsWidgets);
      expect(find.byIcon(Icons.add_link), findsWidgets);
    }
  });
}
