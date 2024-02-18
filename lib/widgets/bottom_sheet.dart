import 'package:brighter_nepal/helper/launcher_functions.dart';
import 'package:brighter_nepal/values/myroutes.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

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
          ListTile(
            leading: const Icon(
              Icons.sign_language_sharp,
              color: Colors.white,
            ),
            title: const Text(
              'Create An Account',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, MyRoutes.signup);
              // Handle theme settings
            },
          ),
          const SizedBox(height: 10.0),
          ListTile(
            leading: const Icon(
              Icons.language,
              color: Colors.white,
            ),
            title: const Text(
              'View Our Website',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              launchPhoneApp(
                  "https://ashlyasoftwares.000webhostapp.com/brighter_nepal/");
              // Handle language settings
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
              // Handle theme settings
            },
          ),
        ],
      ),
    );
  }
}
