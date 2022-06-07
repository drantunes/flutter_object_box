import 'package:objectbox/objectbox.dart';

@Entity()
class ToDo {
  int id = 0;
  String task;
  bool done;

  ToDo({required this.task, required this.done});
}
