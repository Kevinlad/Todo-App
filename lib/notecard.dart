import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget noteCard(Function() onTap, DocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.lime, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Text(doc['title']),
        Text(doc['date']),
        Text(doc['content'])
      ]),
    ),
  );
}
