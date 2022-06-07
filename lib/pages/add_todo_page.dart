import 'package:flutter/material.dart';
import 'package:flutter_object_box/repositories/todo_repository.dart';
import 'package:provider/provider.dart';

class AddToDoPage extends StatefulWidget {
  const AddToDoPage({Key? key}) : super(key: key);

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final _form = GlobalKey<FormState>();
  final _titulo = TextEditingController();

  salvar() async {
    if (_form.currentState!.validate()) {
      context.read<ToDoRepository>().save(_titulo.text);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black87,
          title: const Text('Nova Tarefa'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Form(
                key: _form,
                child: TextFormField(
                  controller: _titulo,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    // contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                    labelText: 'Título',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o título da tarefa';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
                  onPressed: salvar,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Adicionar Tarefa',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
