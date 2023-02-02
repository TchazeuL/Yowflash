import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:yowflash/screen/main_app_screen.dart';

class Introscreen extends StatelessWidget {
  Introscreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Nous vivons dans un monde en constante pollution",
      body: "Les objets inutilises participent a plus de 40% de la pollution",
      image: Center(
        child: Image.asset("assets/Firebse.png"),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.orange),
      ),
    ),
    PageViewModel(
      title: "Participez au changement",
      body:
          "Favoriser la reutilisation de vos anciens objets tout en les disposant au public et ainsi vous faire remunere en contrepartie",
      image: Center(
        child: Image.asset("assets/Firebse.png"),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.orange),
      ),
    ),
    PageViewModel(
      title: "Avoir des produits a bas prix",
      body:
          "Visualiser les publications de la communaute afin de vous approvisionner en produits manquant et peu couteux",
      image: Center(
        child: Image.asset("assets/Firebse.png"),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.orange),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: IntroductionScreen(
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(15, 15),
            color: Colors.grey,
            activeSize: Size.square(25),
            activeColor: Color.fromARGB(255, 4, 112, 185),
          ),
          showDoneButton: true,
          done: const Text(
            "C'est parti",
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 4, 112, 185),
            ),
          ),
          showSkipButton: true,
          skip: const Text(
            "Sauter",
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 4, 112, 185),
            ),
          ),
          showNextButton: true,
          next: const Text(
            "Suivant",
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 4, 112, 185),
            ),
          ),
          onDone: () => onDone(context),
        ),
      ),
    );
  }

  void onDone(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomMenu()));
  }
}
