import 'package:agenda_contatos/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  var imagem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          var contato = Contato.fromMap({
            "nome": _nomeController.text,
            "email": _emailController.text,
            "telefone": _telefoneController.text,
            "imagem": imagem
          });

          Navigator.pop(context, contato);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _imagem(),
            _txtField(label: "Nome", controller: _nomeController),
            _txtField(label: "Email", controller: _emailController),
            _txtField(label: "Telefone", controller: _telefoneController),
          ],
        ),
      ),
    );
  }

  _imagem(){
    return GestureDetector(
      child: imagem == "" ? const Icon(Icons.person, size: 128,) : Container(
          width: 140.0,
          height: 140.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: FileImage(File(imagem)),
                fit: BoxFit.cover
            ),
          ),),
      onTap: () async{
        print("testando...");
        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
        if(photo == null) return;
        setState(() {
          imagem = photo.path;
        });
      },
    );
  }

  _txtField({label, controller}){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label
    ),);
  }

}
