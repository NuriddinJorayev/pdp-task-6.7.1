
import 'package:firebase_database/firebase_database.dart';
import 'package:herewego/models/post.dart';

class RTDB_Service {
  static final _database = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> StorePost(Post post) async {
    _database.child("posts").push().set(post.ToJson());
    return _database.onChildAdded;
  }
  // friend with _FromObjectToList method
  static Future<List<Post>> LoadPost() async {
    List<Post> item = [];
   return _database.ref.child("posts").get().then((value) => item = _FromObjectToList(value.value));     
  }
//  friend with LoadPost method
  static List<Post> _FromObjectToList(v) {
    List<Post> item = [];
    if(v != null){
      Map map = v as Map;
    map.forEach((key, value) {
      item.add(Post.fromJson(value));
    });
    return item;
    }
    return [];
  }

  //  {-Mr72CKEl9HMEjyWp3cB: {date: date, firstName: nurik, lastName: lastName, userId: vwLmQH8h1ehYghuNtTlZFIflBqq2, content: content}, -Mr72diDXIvHWMPupXMu: {date: date, firstName: nurik, lastName: lastName, userId: vwLmQH8h1ehYghuNtTlZFIflBqq2, content: content}}

  static  DeletePost(int index){
    _database.ref.child("posts").get().then((value) =>DeleteChacker(value.value, index));  

  }

  static DeleteChacker(v, int index){
   if(v != null){ 
     Map map = v as Map;   
      List templist =[];
     map.forEach((key, value) => templist.add(key));
      _database.ref.child("posts").child(templist[index]).remove();
  
   }

  }
}
