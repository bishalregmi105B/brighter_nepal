import 'package:brighter_nepal/models/courses.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:flutter/material.dart';

class MockTestCards extends StatefulWidget {
  final course courses;

  const MockTestCards({
    super.key,
    required this.courses,
  });

  @override
  State<MockTestCards> createState() => _MockTestCardsState();
}

class _MockTestCardsState extends State<MockTestCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 260.0,
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
                widget.courses.imageUrl,
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
                "${widget.courses.name} Admit Card",
                style: MyStyles.card_blue_text,
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Text(
                    "Rs. ${(int.parse(widget.courses.entry_discount) > 0) ? calcDiscount(widget.courses.entry_price, widget.courses.entry_discount) : widget.courses.entry_price} /- Per Test",
                    style: MyStyles.card_blue_text,
                  ),
                  (int.parse(widget.courses.entry_discount) > 0)
                      ? Row(
                          children: [
                            Text(
                              "Rs. ${widget.courses.entry_price} /- ",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontStyle: FontStyle.italic),
                            ),
                            Text(
                              " ${widget.courses.entry_discount}% OFF ",
                              style: MyStyles.card_blue_text,
                            )
                          ],
                        )
                      : const Text(" "),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      print("object");
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
