library abw_sample_packagev1;

import 'package:abw_sample_packagev1/webview.dart';
import 'package:flutter/material.dart';

class DHAABWCustom {
  static dhaABW(BuildContext context, String customerID, String firstName,
      String lastName, String clientCode) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebView(
                customerIDValue: customerID,
                firstNameValue: firstName,
                lastNameValue: lastName,
                clientCodeValue: clientCode)));
  }
}
