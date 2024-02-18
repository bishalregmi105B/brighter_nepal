class ChatsModal {
  static List<Chats> chatList = [];
}

class Chats {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String todo;
  final String sender_name;
  final String course_id;
  final String url;
  final String act_name;

  Chats({
    required this.act_name,
    required this.sender_name,
    required this.course_id,
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.todo,
    required this.url,
  });

  factory Chats.fromJson(Map<String, dynamic> json) {
    return Chats(
      id: json['id'].toString(),
      name: json['title'] as String,
      act_name: json['act_name'] as String,
      description: json['description'] as String,
      sender_name: json['sender_name'] as String,
      course_id: json['course_id'] as String,
      imageUrl: json['image_url'] as String,
      todo: json['todo'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'act_name': act_name,
      'description': description,
      'image_url': imageUrl,
      'todo': todo,
      'sender_name': sender_name,
      'course_id': course_id,
      'url': url,
    };
  }
}
