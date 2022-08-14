// ignore_for_file: prefer_const_constructors

import 'package:bytebank/screens/central_ajuda.dart';
import 'package:bytebank/screens/contatos.dart';
import 'package:bytebank/screens/historico_tranferencias.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Dashboard')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('images/bytebank_logo.png'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FeatureItem(
                    itemIcon: Icons.monetization_on,
                    itemName: 'Transferências',
                    buttonClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ContatosLista()));
                    },
                  ),
                  _FeatureItem(
                    itemIcon: Icons.list,
                    itemName: 'Histórico de Transferências',
                    buttonClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TransferenciasLista()));
                    },
                  ),
                  _FeatureItem(
                    itemIcon: Icons.help,
                    itemName: 'Central de Ajuda',
                    buttonClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CentralAjuda()));
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem(
      {Key? key,
      required this.itemIcon,
      required this.itemName,
      required this.buttonClick})
      : super(key: key);

  final IconData itemIcon;
  final String itemName;
  final Function buttonClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
            child: InkWell(
                onTap: () => buttonClick(),
                child: Container(
                  height: 100,
                  width: 150,
                  color: Colors.green,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(itemIcon),
                            Text(
                              itemName,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            )
                          ])),
                ))));
  }
}
