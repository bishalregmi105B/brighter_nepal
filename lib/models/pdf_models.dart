class PdfModal {
  static List<Pdf> PdfList = [];
}

class Pdf {
  final String id;
  final String name;
  final String type;
  final String url;
  final String imageUrl;

  Pdf({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    required this.imageUrl,
  });

  factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
        id: json['id'] as String,
        name: json['title'] as String,
        type: json['type'] as String,
        url: json['link'] as String,
        imageUrl: json['img_url'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'type': type,
        'link': url,
        'img_url': imageUrl,
      };
}
