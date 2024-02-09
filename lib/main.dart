import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_sharing/home.dart';
import 'package:recipe_sharing/favorite.dart';
import 'package:recipe_sharing/screen3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  int myIndex = 0;
  List<Widget> widgetlist = const [
    // Text("Home", style: TextStyle(fontSize: 40)),
    // Text("favrioute", style: TextStyle(fontSize: 40)),
    // Text("subscription", style: TextStyle(fontSize: 40)),

    screen1(),
    screen2(),
    screen3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetlist[myIndex],
      ),
      appBar: AppBar(
        title: Text("Recipe"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo,
        showSelectedLabels: false,
        onTap: (Index) {
          setState(() {
            myIndex = Index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favrioute',
              backgroundColor: Colors.purple),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_rounded),
              label: 'Subscription',
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
