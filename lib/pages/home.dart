import 'package:flutter/material.dart';
import 'package:flutter_web_api/model/model.dart';
import 'package:flutter_web_api/pages/add_user.dart';
import 'package:flutter_web_api/pages/edit_page.dart';
import 'package:flutter_web_api/pages/find_user.dart';
import 'package:flutter_web_api/service/api_handler.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiHandler apiHandler = ApiHandler();
  late List<User> data = [];

  void getData() async {
    data = await apiHandler.getUserData();
    setState(() {});
  }
  void deleteUser(int userId) async{
     await apiHandler.deleteUser(userId: userId);
    setState(() {

    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text("Flutter WebApi"),
      ),
      bottomNavigationBar: MaterialButton(
        onPressed: getData,
        color: Colors.teal,
        textColor: Colors.white,
        padding: EdgeInsets.all(20),
        child: const Text("Refresh"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditPage(user: data[index])));
                    },
                    leading: Text("${data[index].userId}"),
                    title: Text(data[index].name),
                    subtitle: Text(data[index].address),
                    trailing: IconButton(icon:const Icon(Icons.delete_outline) ,
                      onPressed: () {
                      deleteUser(data[index].userId);
                      },),

                  );
                }),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUser()));
            },
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const FindUser()));
            },
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            child: const Icon(Icons.search_outlined),
          ),
        ],
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
