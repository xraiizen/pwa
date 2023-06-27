import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pwa/api/product.dart';
import 'package:pwa/components/card_home.dart';
import 'package:pwa/model/products.dart';

typedef CartCallback = void Function(bool param);

class MyHomePage extends StatefulWidget {
  final CartCallback onCallbackforScreen;

  const MyHomePage({
    super.key,
    required this.onCallbackforScreen,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Products? products;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  void getProducts() async {
    Products? fetchedProduct = await fetchProducts();
    setState(() {
      products = fetchedProduct;
      if (kDebugMode) {
        print("lenght: ${products!.products.length}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int crossAxis = (MediaQuery.of(context).size.width ~/ 250).toInt();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (crossAxis > 2 && crossAxis < 4) {
      height = height + 700;
    } else if (crossAxis > 4) {
      height = height + 1100;
    }
    return products != null && products!.products.isNotEmpty
        ? GridView.builder(
            itemCount: products!.products.length,
            primary: true,
            padding: const EdgeInsets.all(5),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 40,
              crossAxisSpacing: 24,
              // width / height: fixed for *all* items
              childAspectRatio: width / (height),
              // childAspectRatio: 0.4,
              crossAxisCount: crossAxis <= 3 ? crossAxis : 4,
            ),
            itemBuilder: (context, index) {
              return cardHome(
                imageUrl: products!.products[index].thumbnail,
                categorie: products!.products[index].category,
                title: products!.products[index].title,
                star: products!.products[index].rating!,
                desc: products!.products[index].description,
                prix: products!.products[index].price.toDouble(),
                onCallback: (bool param) {
                  if (param == true) {
                    widget.onCallbackforScreen(true);
                  }
                },
              );
            },
          )
        : const Center(child: Text("Aucune Données"));
  }
}
