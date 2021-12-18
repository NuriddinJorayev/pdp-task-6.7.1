import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:herewego/models/post.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/service/authservice.dart';
import 'package:herewego/service/prefs.dart';
import 'package:herewego/service/rtdb_service.dart';

class Home extends StatefulWidget {
  final String id = "home_page";
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Post>> futureList;

  @override
  void initState() {
    super.initState();
    futureList = RTDB_Service.LoadPost().then((value) => value);
    FirebaseDatabase.instance.ref().onChildChanged.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize futureList
    futureList = RTDB_Service.LoadPost().then((value) => value);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("home Page"),
        backgroundColor: Color.fromARGB(255, 255, 87, 32),
        actions: [
          IconButton(
              onPressed: () {
                Prefs.isExist().then((value) => _logOut(value, context));
              },
              icon: Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: futureList,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.length != 0) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, int index) {
                return _ListTite(
                    snapshot.data![index].firstName,
                    snapshot.data![index].lastName,
                    snapshot.data![index].content,
                    snapshot.data![index].date,
                    index);
              },
            );
          }else if (snapshot.hasData && snapshot.data!.length == 0){
            return Center(child: Text("There is no data on the server", style: TextStyle(color: Colors.orange[900], fontSize: 18),),);
          }
           else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 87, 32),
        onPressed: () => _openPage(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Future _openPage(BuildContext context) async {
    String data = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => Detail_page()));
    if (data.isNotEmpty && data.compareTo("data") == 0) {
      setState(() {});
    }
  }

  // listTitle builder method
  Widget _ListTite(firstname, lastname, content, date, index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lastname + ' ' + firstname,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
              SizedBox(height: 5.0),
              Text(date,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 5.0),
              Text(content,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          IconButton(
            onPressed: () {
              RTDB_Service.DeletePost(index);
              setState(() {
                
              });
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
    );
  }

  // log out method
  _logOut(bool exist, BuildContext context) {
    if (exist) {
      AuthService.Loguot(context);
    }
  }
}
