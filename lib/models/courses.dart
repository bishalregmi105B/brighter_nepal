class courses_modal {
  static List<course> courses = [];
}

class course {
  final String id;
  final String name;
  final String discount;
  final String price;
  final String imageUrl;
  final String entry_price;
  final String entry_discount;
  final String online_mock_price;

  final String type;

  course({
    required this.id,
    required this.name,
    required this.discount,
    required this.price,
    required this.imageUrl,
    required this.entry_discount,
    required this.entry_price,
    required this.online_mock_price,
    required this.type,
  });

  factory course.fromJson(Map<String, dynamic> json) => course(
        id: json['id'] as String,
        name: json['title'] as String,
        discount: json['discount'] as String,
        price: json['price'] as String,
        imageUrl: json['image_url'] as String,
        entry_price: json['entry_price'] as String,
        entry_discount: json['entry_discount'] as String,
        online_mock_price: json['online_mock_price'] as String,
        type: json['type'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'discount': discount,
        'price': price,
        'image_url': imageUrl,
        'entry_discount': entry_discount,
        'entry_price': entry_price,
        'online_mock_price': online_mock_price,
        'type': imageUrl,
      };
}
