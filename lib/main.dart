import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert Dialog Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alert Dialog"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            cardWidget("Dismissable Alert Dialog", () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text("I am an alert dialog"),
                  );
                },
              );
            }),
            cardWidget("Non-dismissable Alert Dialog", () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                        "This dialog cannot be dismissed without an action"),
                    actions: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Text("Close"),
                      )
                    ],
                  );
                },
              );
            }),
            cardWidget("Non-dismissable Alert Dialog and WillPopScope", () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child: AlertDialog(
                      title: const Text(
                          "This dialog cannot be dismissed without an action"),
                      actions: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Text("Close"),
                        )
                      ],
                    ),
                  );
                },
              );
            }),
            cardWidget("Non-dismissable Alert Dialog with blurred background",
                () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: AlertDialog(
                          title: const Text(
                              "This dialog cannot be dismissed without an action"),
                          actions: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Text("Close"),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }),
            cardWidget(
                "Your OS is outdated and should be updated before your proceed",
                () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: AlertDialog(
                          title: const Text("OS Update Warning"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.warning,
                                color: Colors.orange,
                                size: 50,
                              ),
                              Text(
                                "You must update your OS before proceeding further!",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          actions: [
                            GestureDetector(
                              onTap: () {
                                // Run update OS code here
                                Navigator.of(context).pop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }),
          ],
        ),
      ),
    );
  }

  Card cardWidget(String title, Function f) {
    return Card(
      color: Colors.grey[100],
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        onTap: () => f(),
      ),
    );
  }
}
