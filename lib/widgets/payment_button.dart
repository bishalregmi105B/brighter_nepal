import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatefulWidget {
  const PaymentButton(
      {super.key, required this.title, required this.pid, required this.amt});
  final String title;
  final String pid;
  final double amt;
  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  String refId = '';
  String hasError = '';

  @override
  Widget build(BuildContext context) {
    return EsewaPayButton(
      paymentConfig: ESewaConfig.dev(
        su: 'https://www.marvel.com/hello',
        amt: widget.amt,
        fu: 'https://www.marvel.com/hello',
        pid: widget.pid,
        // scd: dotenv.env['ESEWA_SCD']!
      ),
      width: 100,
      onFailure: (result) async {
        setState(() {
          refId = '';
          hasError = result;
        });
        if (kDebugMode) {
          print(result);
        }
      },
      onSuccess: (result) async {
        setState(() {
          hasError = '';
          refId = result.refId!;
        });
        if (kDebugMode) {
          print(result.toJson());
        }
      },
    );
  }
}
