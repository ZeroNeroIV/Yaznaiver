import 'package:yaznaiver/drug_store/drug_store_medicine.dart';

class CartItem {
  final Medicine medicine;
  int quantity;

  CartItem({required this.medicine, this.quantity = 1});
}
