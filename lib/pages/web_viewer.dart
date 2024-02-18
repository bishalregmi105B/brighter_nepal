// import 'package:brighter_nepal/widgets/loading_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebVi extends StatefulWidget {
//   final String initialUrl;
//   final String title;

//   const WebVi({
//     super.key,
//     required this.initialUrl,
//     required this.title,
//   });

//   @override
//   State<WebVi> createState() => _WebViState();
// }

// class _WebViState extends State<WebVi> {
//   late WebViewController _webViewController;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize _webViewController here
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 241, 245, 248),
//         title: Text(
//           widget.title,
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               _webViewController.reload();
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () async {
//               if (await _webViewController.canGoBack()) {
//                 _webViewController.goBack();
//               }
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.arrow_forward),
//             onPressed: () async {
//               if (await _webViewController.canGoForward()) {
//                 _webViewController.goForward();
//               }
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           WebView(
//             initialUrl: widget.initialUrl,
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController webViewController) {
//               _webViewController = webViewController;
//             },
//             onPageStarted: (String url) {
//               setState(() {
//                 isLoading = true;
//               });
//             },
//             onPageFinished: (String url) {
//               setState(() {
//                 isLoading = false;
//               });
//             },
//           ),
//           if (isLoading)
//             const Center(
//               child: LoadingAnimation(), // Display loading indicator
//             ),
//         ],
//       ),
//     );
//   }
// }
