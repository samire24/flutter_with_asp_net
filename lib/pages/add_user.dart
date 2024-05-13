import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/model/model.dart';
import 'package:flutter_web_api/service/api_handler.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    ApiHandler apiHandler = ApiHandler();

    void addUserData() async {
      if (_formKey.currentState!.saveAndValidate()) {
        ;
        final data = _formKey.currentState!.value;

        final user = User(
            userId: 0,
            name: data['name'],
            address: data['address']
        );
        await apiHandler.addUser(user: user);
      }
      if(!mounted) return;
      Navigator.pop(context);
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text("Add User"),
      ),
      bottomNavigationBar: MaterialButton(
        onPressed: addUserData,
        color: Colors.teal,
        textColor: Colors.white,
        padding: EdgeInsets.all(20),
        child: const Text("Add"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 5,),
              FormBuilderTextField(
                name: 'address',
                decoration: const InputDecoration(labelText: 'address'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
