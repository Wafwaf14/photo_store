class PhotoItem {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String photographer;
  final String category;

  PhotoItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.photographer,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'photographer': photographer,
      'category': category,
    };
  }

  factory PhotoItem.fromMap(Map<String, dynamic> map) {
    return PhotoItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      photographer: map['photographer'] ?? '',
      category: map['category'] ?? '',
    );
  }
}