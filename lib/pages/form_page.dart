import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.person, size: 128,),
            TextField(decoration: InputDecoration(
              labelText: "Nome"
            ),),
            TextField(decoration: InputDecoration(
                labelText: "Email"
            ),),
            TextField(decoration: InputDecoration(
                labelText: "Phone"
            ),),
          ],
        ),
      ),
    );
  }
}
