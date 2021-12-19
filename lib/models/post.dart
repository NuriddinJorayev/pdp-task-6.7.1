class Post {
  String userId;
  String firstName;
  String lastName;
  String content;
  String date;
  String image;

  Post({required this.userId,
      required this.firstName,
      required this.lastName,
      required this.content,
      required this.date,
      required this.image});

  Post.FromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        firstName = json["firstName"],
        lastName = json["lastName"],
        content = json["content"],
        date = json["date"],
        image = json['image'];

    Post.fromJson(dynamic json) 
    : userId = json['userId'],
     firstName = json['firstName'],
     lastName = json['lastName'],
     content = json['content'],
     date =  json['date'] ,   
     image = json['image'];

  Map<String, String> ToJson()  => {    
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'content': content,
        'date': date,
        'image': image,
      };
}
