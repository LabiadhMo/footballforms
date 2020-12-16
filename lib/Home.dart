import 'package:flutter/material.dart';
import 'package:football_formations/constants/constants.dart';
import 'package:trotter/trotter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<int>> formations = [];
  bool formationDone = false;

  @override
  void initState() {
    super.initState();
    fetchFormations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FOOTBAR'),
      ),
      body: formationDone ? buildFormations(context) : Container(),
    );
  }

  Container buildFormations(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          physics: PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: formations.length,
          itemBuilder: (ctx, index) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  buildFormationTitle(index),
                  buildTeam(context, index),
                ],
              ),
            );
          }),
    );
  }

  Center buildFormationTitle(int index) {
    return Center(
      child: Text(
        'Formation : ${index + 1} sur ${formations.length}',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Container buildTeam(BuildContext context, int index) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: 11,
        itemBuilder: (context, i) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                listeDesJoueurs[formations[index][i]].nom +
                    ' ' +
                    listeDesJoueurs[formations[index][i]].numero.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }

  fetchFormations() {
    var combos =
        Combinations(11, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]);

    for (var combo in combos()) {
      formations.add(combo.toList());
    }
    setState(() {
      formationDone = true;
    });
  }
}
