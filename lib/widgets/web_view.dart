import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHandler extends StatefulWidget {
  final String initialUrl;
  final String title;

  WebViewHandler({required this.initialUrl, required this.title});

  @override
  _WebViewHandlerState createState() => _WebViewHandlerState();
}

class _WebViewHandlerState extends State<WebViewHandler> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: widget.initialUrl,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
        },
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          // Handle page loading started
        },
        onPageFinished: (String url) {
          // Handle page loading finished
        },
        onWebResourceError: (WebResourceError error) {
          // Handle web resource error
        },
        navigationDelegate: (NavigationRequest request) {
          // Handle URL navigation, e.g., prevent certain URLs from loading
          return NavigationDecision.navigate;
        },
        gestureNavigationEnabled: true,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer(),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Execute JavaScript code on the WebView
          _webViewController
              .evaluateJavascript("alert('Hello from Flutter!');");
        },
        child: Icon(Icons.code),
      ),
    );
  }
}
