import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_sharing/detail.dart';


class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      StreamBuilder(
        stream: _products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];

                String imageUrl = documentSnapshot['image'];
                String recipeName = documentSnapshot['name'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detailpage(
                                      documentSnapshot: documentSnapshot)),
                            );
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.black.withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  recipeName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      print(documentSnapshot['cart']);

                                      if (documentSnapshot['cart'] == false) {
                                        _products
                                            .doc(documentSnapshot.id)
                                            .update({'cart': true});
                                      } else {
                                        _products
                                            .doc(documentSnapshot.id)
                                            .update({'cart': false});
                                      }
                                    },
                                    icon: Icon(Icons.favorite_border)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
   
    );
  }
}
