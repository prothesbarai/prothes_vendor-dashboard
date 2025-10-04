class ItemModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final int stock;
  final String description;
  final String imagePath;
  bool isAvailable;

  ItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.description,
    required this.imagePath,
    this.isAvailable = true,
  });
}
