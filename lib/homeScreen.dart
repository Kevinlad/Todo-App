import 'package:app_todo/notecard.dart';
import 'package:app_todo/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Your Notes"),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('todo').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.requireData;

                    return ListView.builder(
                      // return GridView(
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 2),
                      //   children: snapshot.data!.docs.map((note) {
                      //     noteCard(() => {}, note);
                      //   }).toList,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final doc = data.docs[index];
                        // Text(doc['title']);
                        // Text(doc['content']);
                        // Text(doc['date']);
                        return ListTile(
                          leading: Text(doc['title']),
                          subtitle: Text(doc['content']),
                          trailing: Text(doc['date']),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewScreen()));
                          },
                        );
                      },
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2),
                      // children: snapshot.data!.map((document) {
                      //   noteCard(() {}, document);
                      // }).toList(),
                    );
                  }
                  return Text('No notes');
                }),
          )
        ],
      ),
    );
  }
}
