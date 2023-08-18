import 'package:abw_sample_packagev1/abw_sample_packagev1.dart';
import 'package:abw_sample_packagev1/webview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textControllerUserId = TextEditingController();
  final _links = ['Digital Health Assessment'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
                _links.map((link) => _urlButtonView(context, link)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _urlButtonView(BuildContext context, String url) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        TextField(
          controller: textControllerUserId,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              labelText: 'User ID',
              hintText: 'Enter unique User ID like 1..'),
        ),
        // TextButton(
        //   child: Text(
        //     url,
        //     style: TextStyle(
        //         color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 16),
        //   ),
        //   onPressed: () => DHAABWCustom.dhaABW(
        //       context, textControllerUserId.text, "Vishwangi", "Shah", "abcd"),
        // ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(180, 0, 0, 1),
                  Color.fromRGBO(176, 0, 0, .9),
                ])),
            child: Center(
              child: TextButton(
                onPressed: () {
                  if (textControllerUserId.text != '') {
                    DHAABWCustom.dhaABW(context, textControllerUserId.text,
                        "Vishwangi", "Shah", "abcd");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter User ID"),
                      ),
                    );
                  }
                },
                child: Text(
                  url,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
