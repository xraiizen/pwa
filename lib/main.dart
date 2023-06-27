import 'package:flutter/material.dart';
import 'package:pwa/components/sidebar.dart';
import 'package:pwa/pages/account.dart';
import 'package:pwa/pages/cart.dart';
import 'package:pwa/pages/home.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({
    super.key,
  });

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool paramScreen = false;
  late Widget page;
  String title = "Accueil";

  @override
  void initState() {
    super.initState();
    page = MyHomePage(
      onCallbackforScreen: (bool param) {
        setState(() {
          paramScreen = param;
          handleClick();
          handleIndexChanged(2, paramScreen);
        });
      },
    );
  }

  void handleIndexChanged(int index, bool callbackValue) {
    switch (index) {
      case 0:
        setState(() {
          paramScreen = false;
          page = const Account();
          title = "Mon compte";
        });
        break;
      case 1:
        setState(() {
          page = MyHomePage(
            onCallbackforScreen: (bool param) {
              setState(() {
                paramScreen = param;
                handleIndexChanged(2, paramScreen);
                handleClick();
              });
            },
          );
          title = "Accueil";
        });
        break;
      case 2:
        setState(() {
          paramScreen = false;
          page = const CartPage();
          title = "Mon panier";
        });
        break;
    }
  }

  void handleClick() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CupertinoAlertDialog(
          title: Text('Article ajouter au panier'),
        );
      },
    );

    // Attendre 5 secondes avant de fermer la modale
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            onIndexChanged: (index) => handleIndexChanged(index, paramScreen),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
              child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 75,
                  child: page),
            ],
          ))
        ],
      ),
    );
  }
}
