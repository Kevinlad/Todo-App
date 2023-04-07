import 'package:app_todo/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'AppStyle/AppStylw.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  late String task;
  late String desc;
  late String updatename = '';
  late String updatedesc = '';

  update(id, value, description) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .update({'task': value, 'desc': description});
    Navigator.pop(context);
  }

  void showdialog() {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Note'),
            content: Form(
                key: formkey,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Title'),
                  validator: (_val) {
                    if (_val!.isEmpty) {
                      return "Cant be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (_val) {
                    task = _val;
                  },
                )),
            actions: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
                onChanged: (_val) {
                  desc = _val;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // if (isUpdate) {
                        //   FirebaseFirestore.instance
                        //       .collection('tasks')
                        //       .doc(ds.id)
                        //       .update({"task": task});
                        // }
                        FirebaseFirestore.instance.collection('tasks').add({
                          "task": task,
                          'desc': desc,
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Add')),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.minColor,
      appBar: AppBar(
        title: Text('Todo App'),
        backgroundColor: AppStyle.bgColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showdialog(),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppStyle.red),
                      child: ListTile(
                        title: Text(ds['task']),
                        subtitle: Text(ds['desc']),
                        trailing: Icon(Icons.delete),
                        onLongPress: () {
                          FirebaseFirestore.instance
                              .collection('tasks')
                              .doc(ds.id)
                              .delete();
                        },
                        onTap: () {
                          Get.defaultDialog(
                              title: 'Update',
                              content: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Task'),
                                onChanged: (value) {
                                  setState(() {
                                    updatename = value;
                                  });
                                },
                              ),
                              actions: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Description'),
                                  onChanged: (description) {
                                    setState(() {
                                      updatedesc = description;
                                    });
                                  },
                                ),
                                ElevatedButton(
                                    // onPressed: () {},
                                    onPressed: () {
                                      update(snapshot.data!.docs[index].id,
                                          updatename, updatedesc);
                                    },
                                    child: Text('Update'))
                              ]);
                        },
                      ),
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
