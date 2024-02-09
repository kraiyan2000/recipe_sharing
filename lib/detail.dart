import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const Detailpage({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot newdocumentsnapshot = widget.documentSnapshot;

    return Scaffold(
      appBar: AppBar(
        title: Text(newdocumentsnapshot['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  newdocumentsnapshot['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 500,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Text(
                      newdocumentsnapshot['description'],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
