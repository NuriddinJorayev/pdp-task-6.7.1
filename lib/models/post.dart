class Post {
  String userId;
  String firstName;
  String lastName;
  String content;
  String date;

  Post({required this.userId,
      required this.firstName,
      required this.lastName,
      required this.content,
      required this.date});

  Post.FromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        firstName = json["firstName"],
        lastName = json["lastName"],
        content = json["content"],
        date = json["date"];

    Post.fromJson(dynamic json) 
    : userId = json['userId'],
     firstName = json['firstName'],
     lastName = json['lastName'],
     content = json['content'],
     date =  json['date'] ;   

  Map<String, dynamic> ToJson() => {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'content': content,
        'date': date,
      };
}
