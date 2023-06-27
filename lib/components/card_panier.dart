import 'package:flutter/material.dart';
import 'package:pwa/model/products.dart';
import 'package:quantity_input/quantity_input.dart';

class CardPanier extends StatefulWidget {
  final List<Product> products;
  final int index;
  const CardPanier({
    super.key,
    required this.products,
    required this.index,
  });

  @override
  State<CardPanier> createState() => _CardPanierState();
}

class _CardPanierState extends State<CardPanier> {
  final double prixOneItem = 0.00;
  double prixmultipleItem = 0.00;
  int steppedIntInput = 1;
  late double price;
  @override
  void initState() {
    super.initState();

    price = double.parse(widget.products[widget.index].price.toString());
  }

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 450;
    return Card(
      shadowColor: const Color.fromARGB(0, 255, 255, 255),
      color: const Color.fromARGB(108, 255, 255, 255),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: isScreenWide ? Axis.horizontal : Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10.0), // Le rayon de la bordure arrondie
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                        fit: BoxFit.cover,
                        widget.products[widget.index].thumbnail),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: widget.products[widget.index].title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "prix de l'unité: $price €",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuantityInput(
                    inputWidth: 30,
                    value: steppedIntInput,
                    step: 1,
                    buttonColor: const Color.fromARGB(255, 0, 0, 0),
                    iconColor: const Color.fromARGB(255, 255, 255, 255),
                    onChanged: (value) => setState(() {
                          steppedIntInput =
                              int.parse(value.replaceAll(',', ''));
                          prixmultipleItem =
                              widget.products[widget.index].price *
                                  steppedIntInput.toDouble();
                        })),
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "$prixmultipleItem €",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
