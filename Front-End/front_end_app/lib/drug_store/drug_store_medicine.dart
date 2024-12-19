class Medicine {
  final int id;
  final String brandName;
  final String genericName;
  final String description;
  final String activeIngredient;
  final List<String> inactiveIngredients;
  final String indicationsAndUsage;
  final String warnings;
  final List<String> adverseReactions;
  final String dosageAndAdministration;
  final String manufacturerName;
  final String storageAndHandling;
  final String productNdc;
  final String route;
  final String doNotUse;
  final double price;
  final String imageUrl;
  // ignore: non_constant_identifier_names
  final bool? buy;

  Medicine({
    required this.id,
    required this.brandName,
    required this.genericName,
    required this.description,
    required this.activeIngredient,
    required this.inactiveIngredients,
    required this.indicationsAndUsage,
    required this.warnings,
    required this.adverseReactions,
    required this.dosageAndAdministration,
    required this.manufacturerName,
    required this.storageAndHandling,
    required this.productNdc,
    required this.route,
    required this.doNotUse,
    required this.price,
    required this.imageUrl,
    // ignore: non_constant_identifier_names
    required this.buy,
  });
}
