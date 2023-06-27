// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:pwa/api/cart.dart';
import 'package:pwa/api/product.dart';
import 'package:pwa/components/card_panier.dart';
import 'package:pwa/model/carts.dart';
import 'package:pwa/model/products.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int nbArticles = 0;
  int prixPanier = 0;
  List<Product> products = [];
  late Products product =
      Products(products: products, total: 0, skip: 0, limit: 0);
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    Cart fetchedCart = (await fetchCarts())!;
    getItembyProductCartID(fetchedCart);
  }

  void getItembyProductCartID(Cart items) {
    items.products!.forEach((element) async {
      Product? product = await fetchProductsById(element!.id);

      setState(() {
        products.add(product!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Nb articles: $nbArticles"),
              Text("Prix total: $prixPanier €")
            ],
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: product.products.length,
              itemBuilder: (BuildContext context, int index) {
                return CardPanier(products: product.products, index: index);
              }),
        ],
      ),
    );
  }
}
