import 'dart:io';
import 'dart:async';
import 'package:agenda_contatos/Dao/contato_dao.dart';
import 'package:agenda_contatos/models/contato.dart';
import 'package:agenda_contatos/pages/form_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ContatoDao _dao = ContatoDao();

  List<Contato> contatos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listarContatos();
  }

  listarContatos() async {
    var c = await _dao.listar();
    setState(() {
      contatos = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var contato = await Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage()),);

          if(contato != null){
            await _dao.criar(contato);
            listarContatos();
          }
        },
      ),
      body: ListView.builder(
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  leading: contatos[index].imagem == "" ? const Icon(Icons.person, size: 64,) : Container(
                    width: 64,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(File(contatos[index].imagem!)),
                          fit: BoxFit.cover
                      ),
                    ),),
                  title: Text(contatos[index].nome!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contatos[index].email!),
                      Text(contatos[index].telefone!),
                  ],),
                ),
              ),
            );
      }),
    );

  }
}
