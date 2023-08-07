import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView extends StatefulWidget {
  final String customerIDValue;
  final String firstNameValue;
  final String lastNameValue;
  final String clientCodeValue;
  const WebView(
      {Key? key,
      required this.customerIDValue,
      required this.firstNameValue,
      required this.lastNameValue,
      required this.clientCodeValue})
      : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return WebViewPage(
      url:
          "https://mtpre.adityabirlahealth.com/execute/journey/650115dd-b2ec-4cc6-94c4-dd3367a61590?&token=&customer_id=${widget.customerIDValue}&firstname=${widget.firstNameValue}&lastname=${widget.lastNameValue}&source=${widget.clientCodeValue}&clientcode=${widget.clientCodeValue}",
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
/*  final Completer<AndroidInAppWebViewController> _controller =
      Completer<AndroidInAppWebViewController>();*/

  Future webViewMethod() async {
    print('In Microphone permission method');
    WidgetsFlutterBinding.ensureInitialized();

    Permission.microphone.request();
    WebViewMethodForCamera();
  }

  Future WebViewMethodForCamera() async {
    print('In Camera permission method');
    WidgetsFlutterBinding.ensureInitialized();
    Permission.camera.request();
    WebViewMethodForStorage();
  }

  Future WebViewMethodForStorage() async {
    print('In storage permission method');
    WidgetsFlutterBinding.ensureInitialized();
    await Permission.storage.request();
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      //wv.WebView.platform = wv.SurfaceAndroidWebView();
    }
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return wv.WebView(
  //     initialUrl: widget.url,
  //     javascriptMode: wv.JavascriptMode.unrestricted,
  //     onWebViewCreated: (wv.WebViewController webViewController) {
  //       _controller.complete(webViewController);
  //     },
  //     onProgress: (int progress) {
  //       print('WebView is loading (progress : $progress%)');
  //     },
  //     onPageStarted: (String url) {
  //       print('Page started loading: $url');
  //     },
  //     onPageFinished: (String url) {
  //       print('Page finished loading: $url');
  //     },
  //     gestureNavigationEnabled: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    InAppWebViewController _webViewController;
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(widget.url.toString())),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false, useOnDownloadStart: true
            //    debuggingEnabled: true,
            ),
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        _webViewController = controller;
      },
      onDownloadStartRequest: (controller, url) async {
        print("onDownloadStart $url");
      },
      androidOnPermissionRequest: (InAppWebViewController controller,
          String origin, List<String> resources) async {
        webViewMethod();
        return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT);
      },
    );
  }
}
