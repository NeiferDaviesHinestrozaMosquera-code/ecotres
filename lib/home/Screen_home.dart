import 'package:concentric_transition/page_view.dart';
import 'package:ecoresiduos/home/card_eco.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final data = [
    CardPlanetData(
      title: "Reciclar",
      subtitle:
          "Por ti, por mi , por el futuro ¡¡¡Recicla!!!.",
      image: const AssetImage("assets/images/reciclajeloco.png"),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      
      background: LottieBuilder.asset("assets/animation/bg-1.json"),
    ),
    CardPlanetData(
      title: "Reducir",
      subtitle: "Recicla porque el planeta lo vale.",
      image: const AssetImage("assets/images/img-2.png"),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      background: LottieBuilder.asset("assets/animation/bg-2.json"),
    ),
    CardPlanetData(
      title: "Reutilizar",
      subtitle: "No lo arruines; los buenos planetas son dificiles de encontrar.",
      image: const AssetImage("assets/images/img-3.png"),
      backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      
      background: LottieBuilder.asset("assets/animation/bg-3.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index, double value) {
          return CardPlanet(data: data[index]);
        },
      ),
    );
  }
}
