import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/payment/payment_page.dart';
import 'package:yaznaiver/drug_store/drug_store_cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cart;

  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get total => widget.cart.fold(0, (sum, item) => sum + (item.medicine.price * item.quantity));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cart),
        backgroundColor: const Color(0xFF29A7C0),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildWideLayout(context);
          } else {
            return _buildNarrowLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderRow(context),
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) => _buildWideCartItem(widget.cart[index]),
            ),
          ),
          _buildTotalAndCheckout(context),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) => _buildNarrowCartItem(widget.cart[index]),
            ),
          ),
          _buildTotalAndCheckout(context),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              AppLocalizations.of(context)!.item_name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              AppLocalizations.of(context)!.price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              AppLocalizations.of(context)!.qty,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildWideCartItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(item.medicine.brandName, overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Text('\$${item.medicine.price.toStringAsFixed(2)}'),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(() {
                          item.quantity--;
                        })),
                Text('${item.quantity}', textAlign: TextAlign.center),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() {
                          item.quantity++;
                        })),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => setState(() {
                          item.quantity = 0;
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowCartItem(CartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.medicine.brandName, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${item.medicine.price.toStringAsFixed(2)}'),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.remove), onPressed: () {}),
                    Text('${item.quantity}'),
                    IconButton(icon: const Icon(Icons.add), onPressed: () {}),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAndCheckout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${AppLocalizations.of(context)!.total}: \$${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF29A7C0),
            ),
            onPressed: () => _showConfirmationDialog(context),
            child: Text(
              AppLocalizations.of(context)!.go,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirm_payment),
          content: Text(AppLocalizations.of(context)!.payment_confirmation_message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => PaymentPage(totalAmount: total),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        );
      },
    );
  }
}
