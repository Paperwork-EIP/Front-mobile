import 'package:flutter/material.dart';

class SettingsAbout extends StatelessWidget {
  const SettingsAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: const Color.fromARGB(255, 96, 128, 118),
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: const [
               Padding(padding: EdgeInsets.all(8.0),
            child:
              Text('\n\nWhat is the purpose of your project ?', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black)),),
               Padding(padding: EdgeInsets.all(8.0),
            child:
              Text("\n\nGetting off the plane, Mr. Sandro Fernandez had put a lot of hope in his arrival in France. 5 years of studies, all his savings and all his time spent there, just to get his visa and prepare for this adventure. He told himself that after all the difficulties to get there, he could finally take full advantage of his new life. But reality caught up with him very quickly, bombarded by incessant, very time-consuming meetings and requests that seem incongruous to him, he finds himself taking days off just to take care of administrative procedures. Sandro is not an isolated case.\n\nIn France, 1.7 million households communicate only in a foreign language. According to France Bleu, 1 out of 5 French people have difficulty carrying out administrative procedures, 12% of them abandon the said procedures. One can only imagine that the dropout rate among non-French speakers is higher.\n\nThis led us to ask ourselves the following question: How to support non-French speakers through their administrative procedures, thus enabling them to access their rights?\n Pour remédier à cela, nous proposons une plateforme sous forme d'application web et mobile, accessible à tous. \n  \nD'une part, les utilisateurs souhaitant recevoir une aide, pourront s'inscrire ou se connecter et renseigner les informations nécessaires telles que la démarche qu'ils souhaitent réaliser, s'ils ont ou non les documents demandés pour compléter la procédure, à travers un questionnaire. \nL'application les informera des formulaires à remplir, des documents pour constituer le dossier et les rendez-vous à prendre, tout ça dans la langue sélectionnée. \nUne fois la procédure lancée, l'utilisateur pourra retrouver sur son profil un suivi avec un pourcentage d'accomplissement de ses différentes démarches. \nIl pourra retrouver ses rendez-vous administratifs dans un calendrier connecté, qui indiquera tout changement et sur lequel il pourra cliquer pour avoir un récapitulatif de toutes les étapes par démarche. \nD'autre part, une fois toutes ces étapes réalisées, lors d'un rendez-vous administratif, si la barrière de la langue persiste et que l'utilisateur n'arrive pas à communiquer avec la personne en face de lui, il pourra être mis en contact avec un bénévole d'association ou une personne qui a déjà vécu la même situation et parlant la même langue, à travers un appel téléphonique sur l'application. Cette tiers-personne servira d'intermédiaire/interprète pour une meilleure communication. \n\nCela économisera du temps à notre utilisateur, ainsi qu'à son interlocuteur.\n\nSur notre plateforme, il sera également possible de partager son expérience, afin d'aiguiller ceux qui passeront par ses étapes par la suite.",
              style : TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black), ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}

