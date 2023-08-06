import 'package:abw_sample_packagev1/webview.dart';
import 'package:flutter/material.dart';
import 'package:abw_sample_packagev1/abw_sample_packagev1.dart';

class Home extends StatelessWidget {
  final _links = ['https://camellabs.com'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _links.map((link) => _urlButton(context, link)).toList(),
    ))));
  }

  Widget _urlButton(BuildContext context, String url) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: TextButton(
          child: Text(url),
          onPressed: () => CustomAlertBox.dhaABW(context),
        ));
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebView()));
  }
}
