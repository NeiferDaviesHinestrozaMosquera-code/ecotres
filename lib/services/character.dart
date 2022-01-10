class Character {
  final String? avatar;
  final String? title;
  final String? description;
  final int? color;

  Character({
    this.avatar,
    this.title,
    this.description,
    this.color,
  });
}



final characters = <Character>[
  Character(
    title: "Residuos organicos",
    description:
        " Los residuos orgánicos o residuos domésticos biológicos son residuos biodegradables de origen vegetal o animal, que son susceptibles de biodegradación en entornos domésticos y comerciales.La parte orgánica está compuesta principalmente por residuos de alimentos y huertos producidos diariamente por hogares e instituciones comerciales, como pieles de frutas y verduras, residuos de alimentos, estiércol de pescado, restos de huesos y carne, servilletas o manteles. Materia orgánica, restos de café, huesos de animales, pequeños restos recortados, corcho natural, palillos, conchas o bolsitas de té, etc.",
    avatar: "assets/images/colorverde.png",
    color: 0xFF008f39,
  ),
  /*
  Character(
    title: "Residuo inorganico",
    description:
        "Los residuos inorgánicos son los residuos no biodegradables, incluyendo papel (orgánico),metal, vidrio, cartón, plástico, cuero, hule, fibras, cerámica, madera, ropa y textiles, que son materiales que pueden reciclarse (34% de los desperdicios son materiales reciclables) .",
    avatar: "assets/images/cesblanco.png",
    color: 0xFF238BD0,
  ),*/
  Character(
    title: "Residuos sanitarios",
    description:
        "Los desechos médicos se refieren a todos los desechos generados por las instalaciones médicas, los laboratorios médicos y las instalaciones de investigación biomédica, así como los desechos de fuentes secundarias o dispersas. Aunque los hospitales producen la mayoría de ellos, solo constituyen una pequeña parte del número total de fuentes.",
    avatar: "assets/images/colornegro.png",
    color: 0xFF000000,
  ),
  Character(
    title: "Residuos especiales",
    description:
        "Es decir que se denomina residuo especial a aquellos residuos que contengan alguna característica de peligrosidad o riesgo para la salud humana, o del ambiente en general.",
    avatar: "assets/images/colorblanco.png",
    color: 0xFF3593e9,
  ),
];