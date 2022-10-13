import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/model/api.dart';
import 'package:flutter_beer_maker/model/recette.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShowBeer extends StatelessWidget {
  final Recette recette;
  final int id;
  const ShowBeer({super.key, required this.recette, required this.id});

  Future<void> _supprimeRecipe(Recette recette) async {
    print('azd');
    await API.deleteUneRecipe(recette);
  }

  Future<void> _showInformationBeer(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Information sur la bière'),
              content: Container(
                color: Color.fromARGB(90, 216, 216, 216),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Quantité à prévoir',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Quantité de malt : ${recette.calculQteMaltKg()} Kg',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                          'Volume eau de brassage : ${recette.calculQteEauBrassageL()} L '),
                      Text(
                          'Volume eau de rinçage : ${recette.calculQteEauRincageL()} L'),
                      Text(
                          'Quantité de houblon amérisant : ${recette.calculQteHoublonAmerisantG()} G'),
                      Text(
                          'Quantité de houblon aromatique: ${recette.calculQteHoublonAromatiqueG()} G'),
                      Text(
                          'Quantité de levure : ${recette.calculQteLevureG()} G'),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Colorimétrie',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('MCU = ${recette.calculMCU()}'),
                                  Text('EBC = ${recette.calculEBC()}'),
                                  Text('SRM = ${recette.calculSRM()}'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: 150,
                                height: 70,
                                color: Color(
                                    recette.srmToRGB(recette.calculSRM())),
                                child: Center(
                                    child: Text(
                                        '#${recette.srmToRGB(recette.calculSRM()).toRadixString(16).substring(2)}')),
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                autoClose: true,
                icon: Icons.info,
                label: 'Information',
                onPressed: _showInformationBeer,
                backgroundColor: Color.fromARGB(255, 227, 205, 2),
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              SlidableAction(
                autoClose: true,
                icon: Icons.delete,
                label: 'Supprimer',
                onPressed: ((context) => _supprimeRecipe(recette)),
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(9),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(recette.srmToRGB(recette.calculSRM())),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          recette.getNom(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${recette.getVolumeLitre()} L'),
                        Text('${recette.getDegreAlcool()} degrès')
                      ],
                    )
                  ]),
            ),
          ),
        )

        /*

      Old


      InkWell(
        onTap: () => _showInformationBeer(context),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(1, 1),
                    blurRadius: 5,
                    spreadRadius: 0)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Nom de la bière'),
                  Text('10L'),
                  Text('9 degrès')
                ]),
          ),
        ),
      ),

      */
        );
  }
}
