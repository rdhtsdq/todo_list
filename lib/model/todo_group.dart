import 'package:flutter_project_remake/model/todo.dart';

class TodoGroup {
  final String tgid;
  String title;
  String desc;
  List<Todo> tList = [];

  TodoGroup(
      {required this.tgid,
      this.tList = const [],
      this.title = 'untitled',
      this.desc = 'none'});
}
