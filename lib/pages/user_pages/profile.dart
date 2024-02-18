import 'dart:convert';

import 'package:brighter_nepal/values/myroutes.dart';
import 'package:brighter_nepal/values/user_logged_data.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:brighter_nepal/widgets/snackbar.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String img_url = '';
  String name = '';
  String id = "";
  String number = "";
  String email = "";

  bool is_uploading = false;
  bool is_updating = false;

  @override
  void initState() {
    super.initState();
    load_userdata();
  }

  Future<void> load_userdata() async {
    setState(() {
      img_url = MySharedPreferences.getString(MyValues.IMG);
      name = MySharedPreferences.getString(MyValues.NAME);
      id = MySharedPreferences.getString(MyValues.USER_ID);
      email = MySharedPreferences.getString(MyValues.EMAIL);
      number = MySharedPreferences.getString(MyValues.PHONE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  radius: 70,
                  foregroundImage: NetworkImage(img_url),
                ),
              ),
              const SizedBox(height: 20),
              itemProfile('Id', id, CupertinoIcons.person),
              const SizedBox(height: 20),
              itemProfile('Name', name, CupertinoIcons.person),
              const SizedBox(height: 10),
              (is_uploading == true) ? const LoadingAnimation() : Container(),
              itemProfile('Phone', number, CupertinoIcons.phone),
              const SizedBox(height: 10),
              itemProfile('Email', email, CupertinoIcons.mail),
              // const SizedBox(
              //   height: 20,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //       onPressed: () {},
              //       style: ElevatedButton.styleFrom(
              //         padding: const EdgeInsets.all(15),
              //       ),
              //       child: const Text('Edit Profile')),
              // ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      await MySharedPreferences.remove(MyValues.LOGGED_IN);
                      await MySharedPreferences.remove(MyValues.USER_ID);
                      await MySharedPreferences.remove(MyValues.NAME);
                      await MySharedPreferences.remove(MyValues.EMAIL);
                      await MySharedPreferences.remove(MyValues.PHONE);
                      Navigator.pushReplacementNamed(context, MyRoutes.splash);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('Logout')),
              ),
              const SizedBox(
                height: 0,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      _showPassWordChangeForm(
                        "Change Password",
                      );
                    },
                    child: const Text("Change Password"),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: (title == "Id")
            ? const Icon(Icons.verified_user_sharp)
            : IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  _showUpdateFormDialog(title, subtitle);
                },
              ),
        tileColor: Colors.white,
      ),
    );
  }

  Future<void> _showUpdateFormDialog(String title, String currentValue) async {
    TextEditingController controller =
        TextEditingController(text: currentValue);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update $title'),
          content: TextField(controller: controller),
          actions: [
            ElevatedButton(
              onPressed: () {
                _update_user_detail(title, controller.text);
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPassWordChangeForm(String currentValue) async {
    TextEditingController controllerFinalpass = TextEditingController();
    String notice = "";

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Update Your Password'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {},
                controller: controllerFinalpass,
                decoration:
                    const InputDecoration(hintText: "Enter New Password"),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                notice,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _update_user_detail(
                    "Update Password", controllerFinalpass.text);
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  _update_user_detail(String title, String value) async {
    var url = Uri.https(MyValues.server_url, MyValues.app_user_update);
    try {
      var response = await http.post(url, body: {
        'title': title,
        'id': MySharedPreferences.getString(MyValues.USER_ID),
        'value': value,
        'todo': 'update_user_details'
      });
      setState(() {
        is_updating = true;
      });
      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        var decodeData = jsonDecode(response.body);
        print(decodeData["response"]);
        if (decodeData["response"] == "failure") {
          setState(() {
            is_updating = false;
          });
          const snackBar = SnackNotice(
              title: "Something Went Wrong",
              message: "We are working to fix it soon");

          // Simple snackbar
        } else {
          if (title == "Name") {
            MySharedPreferences.setString(MyValues.NAME, value);
          } else if (title == "Phone") {
            MySharedPreferences.setString(MyValues.PHONE, value);
          } else if (title == "Email") {
            MySharedPreferences.setString(MyValues.EMAIL, value);
          }
          load_userdata();
          setState(() {
            is_updating = false;
          });
          Navigator.pop(context);
          //
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
