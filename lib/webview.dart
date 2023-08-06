import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as wv;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
      wv.WebView.platform = wv.SurfaceAndroidWebView();
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
