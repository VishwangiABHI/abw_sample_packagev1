import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as wv;

class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  //HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    //homeViewModel.getCombinedHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return const WebViewPage(
      url:
          "https://mtpre.adityabirlahealth.com/execute/journey/650115dd-b2ec-4cc6-94c4-dd3367a61590?&token=&customer_id=2&firstname=rohan&lastname=vish&source=abcd&clientcode=abcd",
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String? url;

  const WebViewPage({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<wv.WebViewController> _controller =
      Completer<wv.WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      wv.WebView.platform = wv.SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return wv.WebView(
      initialUrl: widget.url,
      javascriptMode: wv.JavascriptMode.unrestricted,
      onWebViewCreated: (wv.WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onProgress: (int progress) {
        print('WebView is loading (progress : $progress%)');
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
      gestureNavigationEnabled: true,
    );
  }
}
