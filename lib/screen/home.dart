import 'package:flutter/material.dart';
import 'package:flutter_project_remake/model/todo_group.dart';
import 'package:flutter_project_remake/screen/todo_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TodoGroup> tgList = [];
  Uuid uuid = Uuid();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.05,
                child: const Text(
                  "Hi User!",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              tgList.isEmpty
                  ? Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/image/empty_list.png'),
                              height: MediaQuery.of(context).size.height * 0.25,
                            ),
                            const Center(
                              child: Text(
                                "No Task Now",
                                style: TextStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: MasonryGridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: tgList.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: index.isOdd
                                ? MediaQuery.of(context).size.height * 0.2
                                : MediaQuery.of(context).size.height * 0.3,
                            child: Card(
                              color: Colors.amber,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TodoScreen(
                                        tList: tgList[index].tList,
                                        id: tgList[index].tgid,
                                        title: tgList[index].title,
                                        desc: tgList[index].desc,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Hero(
                                            tag: "${tgList[index].tgid}" +
                                                "${tgList[index].title}",
                                            child: Text(
                                              tgList[index].title,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          PopupMenuButton(
                                            icon: const Icon(
                                              Icons.more_vert_rounded,
                                              color: Colors.black,
                                            ),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Text(
                                                  "edit",
                                                  style: TextStyle(),
                                                ),
                                                onTap: () {
                                                  Future.delayed(
                                                    const Duration(seconds: 0),
                                                    () => showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        String initTitle =
                                                            tgList[index].title;
                                                        String initDesc =
                                                            tgList[index].desc;
                                                        titleController.text =
                                                            initTitle;
                                                        descController.text =
                                                            initDesc;
                                                        return AlertDialog(
                                                          title:
                                                              Text("Edit Todo"),
                                                          content: SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.2,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.6,
                                                            child: Column(
                                                              children: [
                                                                TextField(
                                                                  controller:
                                                                      titleController,
                                                                  cursorColor:
                                                                      Colors
                                                                          .amber,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Title",
                                                                    focusedBorder:
                                                                        UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Colors.amber),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                TextField(
                                                                  cursorColor:
                                                                      Colors
                                                                          .amber,
                                                                  controller:
                                                                      descController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Description",
                                                                    focusedBorder:
                                                                        UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .amber),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "Cancel",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .amber),
                                                              onPressed: () {
                                                                if (titleController
                                                                        .text
                                                                        .isEmpty ||
                                                                    descController
                                                                        .text
                                                                        .isEmpty) {
                                                                  return setState(
                                                                      () {
                                                                    tgList[index]
                                                                            .title =
                                                                        initTitle;
                                                                    tgList[index]
                                                                            .desc =
                                                                        initDesc;
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                } else {
                                                                  return setState(
                                                                    () {
                                                                      tgList[index]
                                                                              .title =
                                                                          titleController
                                                                              .text;
                                                                      tgList[index]
                                                                              .desc =
                                                                          descController
                                                                              .text;
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                              child: Text(
                                                                "Ok",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                              PopupMenuItem(
                                                child: const Text(
                                                  "delete",
                                                  style: TextStyle(),
                                                ),
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      tgList.removeWhere(
                                                        (element) =>
                                                            element.tgid ==
                                                            tgList[index].tgid,
                                                      );
                                                    },
                                                  );
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(tgList[index].desc),
                                    ],
                                  ),
                                ),
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
        child: Icon(Icons.add_rounded),
        onPressed: () {
          titleController.clear();
          descController.clear();
          showDialog(
            context: context,
            builder: (context) {
              return alertwidget(
                  context, titleController, descController, "Add Todo", () {
                setState(
                  () {
                    tgList.add(
                      TodoGroup(
                        tgid: uuid.v4(),
                        title: titleController.text.isEmpty
                            ? "Untitled"
                            : titleController.text,
                        desc: descController.text.isEmpty
                            ? "none"
                            : descController.text,
                        tList: [],
                      ),
                    );
                  },
                );
                Navigator.pop(context);
                titleController.clear();
                descController.clear();
              });
            },
          );
        },
      ),
    );
  }

  AlertDialog alertwidget(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController descController,
    String title,
    VoidCallback submit,
  ) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: titleController,
              cursorColor: Colors.amber,
              decoration: InputDecoration(
                hintText: "Title",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onSubmitted: (v) {
                tgList.add(
                  TodoGroup(
                      tgid: uuid.v4(), title: titleController.text, desc: v),
                );
              },
              cursorColor: Colors.amber,
              controller: descController,
              decoration: InputDecoration(
                hintText: "Description",
                focusedBorder: UnderlineInputBorder(
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
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
          ),
          onPressed: submit,
          child: Text(
            'Ok',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
