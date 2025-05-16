import 'package:chatapp/core/common/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CallHistoryPage extends StatelessWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: "Calls", size: 18),
        centerTitle: true,
      ),
    );
  }
}
