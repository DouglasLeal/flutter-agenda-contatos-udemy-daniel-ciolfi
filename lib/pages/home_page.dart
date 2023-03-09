import 'dart:io';
import 'dart:async';
import 'package:agenda_contatos/models/contato.dart';
import 'package:agenda_contatos/pages/form_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Contato> contatos = [
    Contato.fromMap({"nome": "Douglas", "email": "douglas@email.com",
      "telefone": "1234-5678",
      "imagem": ""
    }),
    Contato.fromMap({"nome": "Ana", "email": "ana@email.com",
      "telefone": "1234-5678",
      "imagem": "imagem"
    }),
    Contato.fromMap({"nome": "Pedro", "email": "pedro@email.com",
      "telefone": "1234-5678",
      "imagem": ""
    }),
  ];

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
            setState(() {
              contatos.add(contato);
            });
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
