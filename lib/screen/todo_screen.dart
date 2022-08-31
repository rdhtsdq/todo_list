import 'package:flutter/material.dart';
import 'package:flutter_project_remake/model/todo.dart';
import 'package:uuid/uuid.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    Key? key,
    required this.tList,
    required this.desc,
    required this.id,
    required this.title,
  }) : super(key: key);
  final List<Todo> tList;
  final String title;
  final String desc;
  final String id;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Uuid uuid = Uuid();
  TextEditingController textEditingController = TextEditingController();
  bool validate = false;

  @override
  void initState() {
    var list = widget.tList.isEmpty;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  SnackBar notifbar(Widget Content) {
    return SnackBar(content: Content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            top: 18,
            left: 18,
            right: 18,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.id,
                        child: Text(
                          "${widget.title}",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.desc}",
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              widget.tList.isEmpty
                  ? Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/image/empty.png'),
                              height: MediaQuery.of(context).size.height * 0.25,
                            ),
                            const Center(
                              child: Text(
                                "No Todo now",
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: widget.tList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            onDismissed: (direction) {
                              setState(
                                () {
                                  widget.tList.removeWhere(
                                    (element) =>
                                        element.id == widget.tList[index].id,
                                  );
                                },
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                notifbar(
                                  Text("Deleted "),
                                ),
                              );
                            },
                            background: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.red,
                              ),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 20,
                              ),
                              child: const Text(
                                "Delete ?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            key: Key(widget.tList[index].id),
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  child: Text(
                                    widget.tList[index].todo[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  widget.tList[index].todo,
                                ),
                                trailing: Checkbox(
                                    fillColor: MaterialStateProperty.all(
                                        Colors.amber.shade800),
                                    value: widget.tList[index].isChecked,
                                    onChanged: (v) => setState(() {
                                          widget.tList[index].isChecked = v!;
                                        })),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade800,
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Add Todo",
                style: TextStyle(),
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  children: [
                    TextField(
                      controller: textEditingController,
                      autofocus: true,
                      cursorColor: Colors.amber.shade800,
                      decoration: InputDecoration(
                        hintText: "Todo..",
                        errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.red,
                        )),
                        errorText: validate ? "todo can not empty" : null,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    textEditingController.clear();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                  onPressed: () {
                    if (textEditingController.text.isEmpty) {
                      return setState(() {
                        validate = true;
                      });
                    } else {
                      setState(
                        () {
                          widget.tList.add(
                            Todo(
                              id: uuid.v4(),
                              todo: textEditingController.text,
                              isChecked: false,
                            ),
                          );
                        },
                      );
                      Navigator.pop(context);
                      textEditingController.clear();
                    }
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
