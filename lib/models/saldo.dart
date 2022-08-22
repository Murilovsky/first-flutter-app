import 'package:flutter/widgets.dart';

class Saldo extends ChangeNotifier {
  double valor;

  Saldo(this.valor);

  void adiciona(double value) {
    this.valor += value;

    notifyListeners();
  }

  void gasta(double value) {
    this.valor -= value;

    notifyListeners();
  }

  @override
  String toString() {
    return 'Saldo: R\$ $valor';
  }
}
