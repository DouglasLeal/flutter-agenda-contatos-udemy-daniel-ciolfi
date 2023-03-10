import 'dart:io';
import 'dart:async';
import 'package:agenda_contatos/Dao/contato_dao.dart';
import 'package:agenda_contatos/models/contato.dart';
import 'package:agenda_contatos/pages/form_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          var contato = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormPage()),
          );

          if (contato != null) {
            await _dao.criar(contato);
            listarContatos();
          }
        },
      ),
      body: ListView.builder(
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onLongPress: () {
                  _opcoesContatos(context, index);
                },
                child: _cardContatos(index));
          }),
    );
  }

  _opcoesContatos(context, index) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                      onPressed: () {
                        final Uri launchUri =
                            Uri(scheme: 'tel', path: contatos[index].telefone);

                        launchUrl(launchUri);

                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Ligar",
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () async {
                        Navigator.pop(context);

                        var contato = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FormPage(contato: contatos[index])),
                        );

                        if (contato.id != null) {
                          await _dao.atualizar(contato);
                          listarContatos();
                        }
                      },
                      child: const Text(
                        "Editar",
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () {
                        _dao.excluir(contatos[index].id!);

                        setState(() {
                          listarContatos();
                        });

                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Excluir",
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _cardContatos(index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: contatos[index].imagem == ""
              ? const Icon(
                  Icons.person,
                  size: 64,
                )
              : Container(
                  width: 64,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(File(contatos[index].imagem!)),
                        fit: BoxFit.cover),
                  ),
                ),
          title: Text(contatos[index].nome!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contatos[index].email!),
              Text(contatos[index].telefone!),
            ],
          ),
        ),
      ),
    );
  }
}
