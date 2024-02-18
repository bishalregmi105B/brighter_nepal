class books_modal {
  static List<books> books_list = [];
}

class books {
  final String id;
  final String name;
  final String discount;
  final String price;
  final String imageUrl;
  final String type;

  books({
    required this.id,
    required this.name,
    required this.discount,
    required this.price,
    required this.imageUrl,
    required this.type,
  });

  factory books.fromJson(Map<String, dynamic> json) => books(
        id: json['id'] as String,
        name: json['title'] as String,
        discount: json['discount'] as String,
        price: json['price'] as String,
        imageUrl: json['image_url'] as String,
        type: json['type'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'discount': discount,
        'price': price,
        'image_url': imageUrl,
        'type': imageUrl,
      };
}
