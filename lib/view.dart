import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final doc = data.docs[index];
    return Scaffold(
      body: Container(
        child: Column(
          children: [
//  Text(doc['title']);
            //   Text(doc['content']);
            //   Text(doc['date']);
            TextField()
          ],
        ),
      ),
    );
  }
}
