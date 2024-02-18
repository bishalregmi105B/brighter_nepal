class mock_text_modal {
  static List<mock_test> mock_tests = [];
}

class mock_test {
  final int id;
  final String name;
  final String discount;
  final String price;
  final String imageUrl;

  mock_test({
    required this.id,
    required this.name,
    required this.discount,
    required this.price,
    required this.imageUrl,
  });

  factory mock_test.fromJson(Map<String, dynamic> json) => mock_test(
        id: json['id'] as int,
        name: json['name'] as String,
        discount: json['discount'] as String,
        price: json['price'] as String,
        imageUrl: json['image_url'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'discount': discount,
        'price': price,
        'image_url': imageUrl,
      };
}
