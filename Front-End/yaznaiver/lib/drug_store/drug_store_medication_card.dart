import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/drug_store/drug_store_medicine.dart';
import 'package:yaznaiver/drug_store/drug_store_detail_page.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final void Function(int) onAddToCart;

  const MedicineCard(
      {super.key, required this.medicine, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedicineDetailPage(
              medicine: medicine,
              onAddToCart: onAddToCart,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        elevation: 6,
        shadowColor: const Color(0xFF29A7C0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  medicine.imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported,
                        color: Colors.grey[600]),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.genericName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF29A7C0),
                      ),
                    ),
                    const SizedBox(height: 5),
                    medicine.buy == true
                        ? Text(
                            '\$${medicine.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green[700],
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)!.cannot_buy,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
