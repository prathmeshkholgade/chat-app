import 'package:chatapp/core/utils/network_error_page.dart';
import 'package:chatapp/di/injection.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final errorController = sl<NetworkController>();
  ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text('Network Error'),
          SizedBox(height: 10),
          Image.network(
            "https://static.vecteezy.com/system/resources/previews/037/359/695/non_2x/connection-error-filled-outline-icon-style-illustration-eps-10-file-vector.jpg",
          ),
          SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              errorController.retry();
            },
            child: Text("try again"),
          ),
        ],
      ),
    );
  }
}
