import 'package:brighter_nepal/models/books.dart';
import 'package:brighter_nepal/pages/payment_page.dart';
import 'package:brighter_nepal/payment/payment_page.dart';

import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/widgets/bottom_sheet_payment.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:flutter/material.dart';

class BooksCard extends StatefulWidget {
  final books book;

  const BooksCard({
    super.key,
    required this.book,
  });

  @override
  State<BooksCard> createState() => _BooksCardState();
}

class _BooksCardState extends State<BooksCard> {
  @override
  Widget build(BuildContext context) {
    double price = (int.parse(widget.book.discount) > 0)
        ? calcDiscount(widget.book.price, widget.book.discount)
        : double.parse(widget.book.price);

    return Container(
        width: 300.0,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        margin: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Image.network(
                widget.book.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    // Image has been successfully loaded

                    return child;
                  } else {
                    // Image is still loading
                    return const Center(child: Card_Skeletan());
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.book.name,
                style: MyStyles.card_blue_text,
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Text(
                    "Rs. ${price} /- ",
                    style: MyStyles.card_blue_text,
                  ),
                  (int.parse(widget.book.discount) > 0)
                      ? Row(
                          children: [
                            Text(
                              "Rs. ${widget.book.price} /- ",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontStyle: FontStyle.italic),
                            ),
                            Text(
                              " ${widget.book.discount}% OFF ",
                              style: MyStyles.card_blue_text,
                            )
                          ],
                        )
                      : const Text(" "),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EsewaApp(
                              title: "Product", amt: 1000, pid: "1020393"),
                        ),
                      );
                    },
                    child: const Text("Explore")),
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const PaymentOption();
                        },
                      );
                    },
                    child: const Text("Help")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentPage(
                                id: widget.book.id,
                                name: widget.book.name,
                                price: price,
                                discount: widget.book.discount,
                                description: widget.book.name,
                                imag_url: widget.book.imageUrl)),
                      );
                    },
                    child: const Text("Buy Now")),
              ],
            )
          ],
        ));
  }
}

double calcDiscount(String price, String discount) {
  try {
    double originalPrice = double.parse(price);
    double discountPercentage = double.parse(discount);

    if (originalPrice < 0 ||
        discountPercentage < 0 ||
        discountPercentage > 100) {
      throw const FormatException("Invalid input.");
    }

    return originalPrice - (originalPrice * discountPercentage / 100);
  } catch (e) {
    print("Error: $e");
    return -1;
  }
}
