abstract class Strings {
  //Toutes les pages seront comprisent dans une liste
  static List<Map> lesPages = [
    page1,
    page2,
    page3,
    page4,
    page5,
    page6,
    page7,
    page8
  ];
  //Chaque page sera comprit dans un liste conteant le titre et le texte
  static Map page1 = {
    'texte': [title1, contenu1],
    'images': ['step00.png']
  };

  //Chaque titre et chaque texte sera mit dans un String
  static String title1 = "Au préalable : ";
  static String contenu1 =
      "Vous allez avoir besoin du matériel suivant pour réaliser votre bière :\n"
      "-Une dame-jeanne\n"
      "-un barboteur\n"
      "-un thermomètre\n"
      "-un tuyau d’extraction avec un embout anti-lie\n"
      "-plusieurs casseroles\n"
      "-une cuillère percée\n"
      "-une passoire à mailles fines\n"
      "-bouteilles en verre à clapet\n"
      "Le matériel utile à la fabrication doit être propre et stérilisé. Nous vous conseillons d’utiliser un désinfectant en poudre vendu dans le commerce et de vous fier aux instruction (à diluer dans de l’eau dans laquelle il faut faire tremper le matériel quelques minutes)";

  static Map page2 = {
    'texte': [title2, contenu2],
    'images': ['step10.png', 'step11.png']
  };
  static String title2 = "1 - L'empâtage";
  static String contenu2 =
      "Note: Le malt blond peut s'utiliser seul. Les malts plus foncés ne s’utilisent qu’en petite dose pour moduler le goût de la bière.\n"
      "Si vous avez achetez du malt en grain entier, le concasser avec un moulin à céréales, un mixer ou encore un rouleau à pâtisserie.\n"
      "Définissez la quantité d’eau de brassage nécessaire, puis versez la dans une grande casserole.\n"
      "Porter cette eau à une température de 50 °C en vérifiant avec le thermomètre, puis ajouter le malt concassé.";

  static Map page3 = {
    'texte': [title3, contenu3],
    'images': ['step20.png', 'step21.png']
  };

  static String title3 = "2- Le brassage par paliers";
  static String contenu3 =
      "Brasser la mixture malt+eau, appelée maîshe, pendant 30 min, à 40°C environ.\n"
      "Remuer avec une grande cuillère percée durant la chauffe et laisser reposer une fois la température du palier atteinte.\n"
      "Monter en température la maîshe à 60-65°C et maintenir cette température environ 30 min. Augmenter la température à 68-70°C et maintenir cette température environ 30 min. Augmenter la température à 78°C et maintenir cette température environ 30 min.";

  static Map page4 = {
    'texte': [title4, contenu4],
    'images': ['step30.png', 'step31.png']
  };

  static String title4 = "3- Filtrer la maîshe";
  static String contenu4 =
      "Au dessus d’une seconde casserole, verser la maîshe dans une grande passoie (tapisser si besoin d’un linge propre) pour obtenir la drêche (résidu solide du malt).\n"
      "Pour récupérer les sucres restants dans la drêche égouttée, verser au-dessus de la drêche l’eau de rinçage préalablement montée à 80°C.\n"
      "L’eau de brassage associé à l’eau de rinçage s’appelle le moût. Les résidus de malt sont compostables.";

  static Map page5 = {
    'texte': [title5, contenu5],
    'images': ['step40.png']
  };
  static String title5 = "4- Le houblonnage";
  static String contenu5 = "Calculer la quantité de houblon à ajouter.\n"
      "Différentes recettes existent, les houblons peuvent être complétés par des épices.\n"
      "Faites bouillir le moût\n."
      "Dès que l'ébullition commence, écumer et ajouter le houblon amer\n"
      "Laisser bouillir ce mélange sans couvrir pendant 1h30 pour retirer de l’amertume.\n"
      "10-15 minutes avant la fin de cette ébullition, ajouter le houblin aromatique\n."
      "Retirer le houblon en le filtrant.\n"
      "Éviter cette étape en plaçant le houblon dans un filtre à thé en papier.\n"
      "Le choix du houblon doit être fait en fonction de son taux IBU qui est l’unité d’amertume.";

  static Map page6 = {
    'texte': [title6, contenu6],
    'images': ['step50.png', 'step51.png', 'step52.png', 'step53.png']
  };
  static String title6 = "5- La fermentation";
  static String contenu6 =
      "Le moût doit être refroidi à une température de 20-25°C pour y incorporer les levures puis transvasé dans la dame-jeanne.\n"
      "Il existe différentes levures.\n"
      "Nous vous recommandons d’utiliser des levures sèches qui sont mieux adaptées pour des petits brassins.\n"
      "Se référer à l’emballage pour déterminer au mieux la quantité appropriée.\n"
      "Il est recommandé d’utiliser pour débuter de la levure S33 qui est polyvalente.\n"
      "Incorporer la levure et remuer la bonbonne pour mélanger.\n"
      "Dans une pièce à 20°C, fermer la bonbonne et placer le barboter (qui permet d’évacuer l’oxygène)\n."
      "Durant environ une semaine, les levures vont travailler et générer du CO2 dans la bonbonne, qui va s’évacuer par le barboteur.\n"
      "Remuer de temps en temps la bonbonne pour faire évacuer le CO2.\n"
      "Lorsqu’il n’y a plus d’activité dans le barboteur, mettre la bouteille de fermentation dans une pièce plus fraîche (autour de 10-15°C, comme une cave par exemple).\n"
      "La bière peut ainsi maturer pendant 1 à 3 semaines, cette période de fermentation secondaire se nomme la garde.\n"
      "Ajouter selon recette des épices, fruits, ...";

  static Map page7 = {
    'texte': [title7, contenu7],
    'images': ['step60.png']
  };
  static String title7 = "6- Le sucrage";
  static String contenu7 =
      "Pour relancer la fermentation qui se fera en bouteille et qui permet d’obtenir de la mousse, incorporer 4 à 6 g de sucre par litre de bière.";

  static Map page8 = {
    'texte': [title8, contenu8],
    'images': ['step70.png', 'step71.png']
  };
  static String title8 = "7- La mise en bouteille";
  static String contenu8 =
      "Mettre en bouteille (stérilisées et séchées) en utilisant un tuyau d'extraction avec embout anti-lie.\n"
      "Le but est de récupérer le liquide clair et d’éliminer les précipités et dépots.\n"
      "placer l’embout anti-lie sur le fond de la bonbonne et l’autre bout au fond de la bouteille.\n"
      "La bonbonne doit être placée très en hauteur par rapport à la bouteille.\n"
      "Utiliser des bouteilles en verre teinté propres et sèches, qui ferment avec un bouchon à vis ou à clapet.\n"
      "Les bouteilles doivent être conservées verticalement.\n"
      "Pendant une semaine conserver ces bouteilles à 20°C.\n"
      "Puis pendant 4 à 8 semaines, les gardes au frais, entre 6 et 10°C.\n"
      "La bière se conserve 1 an, idéalement entre 10 et 15°C à l’abri de la lumière ou simplement au réfrigérateur.";
}
