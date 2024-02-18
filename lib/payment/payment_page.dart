import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EsewaApp extends StatefulWidget {
  const EsewaApp(
      {super.key, required this.title, required this.pid, required this.amt});

  final String title;
  final String pid;
  final double amt;

  @override
  State<EsewaApp> createState() => _EsewaAppState();
}

class _EsewaAppState extends State<EsewaApp> {
  String refId = '';
  String hasError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Example Use case - 1
            EsewaPayButton(
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
            ),

            if (refId.isNotEmpty)
              Text('Console: Payment Success, Ref Id: $refId'),
            if (hasError.isNotEmpty)
              Text('Console: Payment Failed, Message: $hasError'),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
