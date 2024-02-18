import 'package:brighter_nepal/helper/launcher_functions.dart';
import 'package:brighter_nepal/pages/payment_page.dart';
import 'package:brighter_nepal/values/myroutes.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.0,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: MyValues.primary_color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Help',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          ListTile(
            leading: const Icon(
              Icons.language,
              color: Colors.white,
            ),
            title: const Text(
              'Contact Via Whatsapp',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              _launchWhatsApp();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              color: Colors.white,
            ),
            title: const Text(
              'Call Us',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              launchPhoneApp("tel:977-981572686");
              // Handle calling functionality
            },
          ),
        ],
      ),
    );
  }

  void _launchWhatsApp() async {
    String whatsappNumber = '9815726868';

    String message = "Hello, I want to get Help Bikash Sir \n ";

    String url =
        "https://wa.me/$whatsappNumber/?text=${Uri.encodeFull(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error if the URL can't be launched
      print("Could not launch $url");
    }
  }
}
