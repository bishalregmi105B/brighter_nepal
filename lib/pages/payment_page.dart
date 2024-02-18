import 'package:brighter_nepal/helper/functions.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/values/user_logged_data.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/bottom_sheet_payment.dart';
import 'package:brighter_nepal/widgets/bottom_sheet_payment_details.dart';
import 'package:brighter_nepal/widgets/input_field.dart';
import 'package:brighter_nepal/widgets/payment_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart' as geocoding;

class PaymentPage extends StatefulWidget {
  final String id;
  final String name;
  final double price;
  final String discount;
  final String description;
  final String imag_url;
  const PaymentPage(
      {super.key,
      required this.id,
      required this.name,
      required this.price,
      required this.discount,
      required this.description,
      required this.imag_url});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController name = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController discount_code = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  location.Location locationProvider = location.Location();
  location.LocationData? currentLocation;
  String? province;
  String? district;
  String? city;

  Future<void> _getLocation() async {
    try {
      var locationData = await locationProvider.getLocation();
      setState(() {
        currentLocation = locationData;
      });

      // Reverse geocoding
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      );

      setState(() {
        province = placemarks.first.administrativeArea;
        district = placemarks.first.subAdministrativeArea;
        city = placemarks.first.locality;
        print(province);
        name.text = MySharedPreferences.getString(MyValues.NAME);
        provinceController.text = placemarks.first.administrativeArea ?? '';
        districtController.text = placemarks.first.subAdministrativeArea ?? '';
        cityController.text = placemarks.first.locality ?? '';
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyValues.primary_color,
        title: const Text(
          'BRIGHTER NEPAL - PAYMENT ',
          style: TextStyle(color: Colors.white),
        ),
        leading: Image.asset("images/logo.jpg"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const Payment_details();
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: MyValues.primary_color,
                    borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                height: MediaQuery.of(context).size.height -
                    (75 / 100) * MediaQuery.of(context).size.height,
                child: Image.network(
                  widget.imag_url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: MyValues.primary_white,
                  borderRadius: BorderRadius.circular(20)),
              width: double.infinity,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Details",
                    style: MyStyles.card_blue_text,
                  ),
                  InputField(
                    controller: name,
                    hint_text: 'Enter Your Name',
                    prefixIcon: Icon(Icons.person),
                    obsc: false,
                  ),
                  InputField(
                    controller: numbercontroller,
                    hint_text: 'Enter Your Contact Number',
                    prefixIcon: Icon(CupertinoIcons.phone),
                    obsc: false,
                  ),
                  InputField(
                    controller: provinceController,
                    hint_text: 'Province',
                    prefixIcon: Icon(CupertinoIcons.location),
                    obsc: false,
                  ),
                  InputField(
                    controller: districtController,
                    hint_text: 'District',
                    prefixIcon: Icon(CupertinoIcons.location),
                    obsc: false,
                  ),
                  InputField(
                    controller: cityController,
                    hint_text: 'City',
                    prefixIcon: Icon(CupertinoIcons.location),
                    obsc: false,
                  ),
                  InputField(
                    controller: discount_code,
                    hint_text: 'Enter Discount Code ',
                    prefixIcon: Icon(CupertinoIcons.person),
                    obsc: false,
                  ),
                ],
              ),
            ),
            PaymentButton(
              amt: widget.price,
              title: widget.name,
              pid: generateOrderNumber(),
            )
          ],
        ),
      ),
    );
  }
}
