class Videos_Modal {
  static List<Videos> Videoss = [];
}

class Videos {
  final String id;
  final String name;
  final String video_url;
  final String type;
  final String description;
  final String credit;

  Videos({
    required this.id,
    required this.name,
    required this.video_url,
    required this.type,
    required this.description,
    required this.credit,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        id: json['id'] as String,
        name: json['title'] as String,
        video_url: json['video_url'] as String,
        type: json['type'] as String,
        description: json['description'] as String,
        credit: json['credit'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'discount': video_url,
        'price': type,
        'description': description,
        'credit': credit,
      };
}
