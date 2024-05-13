import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/service/api_handler.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class EditPage extends StatefulWidget {
  final User user;

  const EditPage({Key? key, required this.user}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();
  late http.Response response;

  void updateData() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      final user = User(
          userId: widget.user.userId,
          name: widget.user.name,
          address: widget.user.address
      );
      response = await apiHandler.updateUser(
          userId: widget.user.userId,
          user: user
      );
    }
    if(!mounted) return;
    Navigator.pop(context);
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
        onPressed: updateData,
        color: Colors.teal,
        textColor: Colors.white,
        padding: EdgeInsets.all(20),
        child: const Text("Update"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          initialValue: {
            'name': widget.user.name,
            'address': widget.user.address
          },
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
