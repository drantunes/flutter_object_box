import 'package:flutter/material.dart';
import 'package:flutter_object_box/pages/add_todo_page.dart';
import 'package:flutter_object_box/repositories/todo_repository.dart';
import 'package:provider/provider.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final loading = ValueNotifier(true);
  final showTodosNotDone = ValueNotifier(false);
  final showFilter = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getFilterTodos();
      loading.value = false;
    });
    showTodosNotDone.addListener(getFilterTodos);
  }

  @override
  void dispose() {
    showTodosNotDone.removeListener(getFilterTodos);
    super.dispose();
  }

  getFilterTodos() async {
    showTodosNotDone.value
        ? await context.read<ToDoRepository>().getTodosNotDone()
        : await context.read<ToDoRepository>().getAll();
  }

  openAddSheet() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => const AddToDoPage(),
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.35,
      ),
    );
  }

  refresh() async {
    await getFilterTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: openAddSheet,
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => showFilter.value = !showFilter.value,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => refresh(),
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: showFilter,
              builder: (context, show, _) => !show
                  ? const SizedBox.shrink()
                  : Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Card(
                          color: Colors.grey[200],
                          child: ListTile(
                            title: const Text('Mostrar Apenas não Finalizados'),
                            trailing: ValueListenableBuilder(
                              valueListenable: showTodosNotDone,
                              builder: (context, _, __) => Switch(
                                value: showTodosNotDone.value,
                                onChanged: (val) => showTodosNotDone.value = val,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Flexible(
              flex: 8,
              child: ValueListenableBuilder<bool>(
                valueListenable: loading,
                builder: (context, load, _) => Consumer<ToDoRepository>(
                  builder: (context, repository, child) {
                    final todos = repository.todos;

                    if (load) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (todos.isEmpty) {
                      return const Center(
                        child: Text('A lista de tarefas está vazia :('),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        leading: Checkbox(
                          value: todos[index].done,
                          onChanged: (newVal) {
                            todos[index].done = newVal!;
                            repository.update(todos[index]);
                            getFilterTodos();
                          },
                        ),
                        title: Text(todos[index].task),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => repository.remove(todos[index]),
                        ),
                      ),
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: repository.todos.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
