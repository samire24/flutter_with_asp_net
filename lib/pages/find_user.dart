import 'package:flutter/material.dart';
import 'package:flutter_web_api/service/api_handler.dart';

import '../model/model.dart';

class FindUser extends StatefulWidget {
  const FindUser({Key? key}) : super(key: key);

  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {
  ApiHandler  apiHandler = ApiHandler();
  TextEditingController textEditingController = TextEditingController();
  User user = const User.empty();

  void findUser(int userId) async{
    user = await apiHandler.findUserById(userId: userId);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text("Find User"),
      ),
      bottomNavigationBar: MaterialButton(
        onPressed:( ){
          findUser(int.parse(textEditingController.text));
        },
        color: Colors.teal,
        textColor: Colors.white,
        padding: EdgeInsets.all(20),
        child: const Text("Find"),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
          ),
          const SizedBox(height: 10,),
          ListTile(
            leading: Text('${user.userId}'),
            title: Text(user.name),
            subtitle: Text(user.address),
          )
        ],
      ),
    );
  }
}
