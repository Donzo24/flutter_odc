import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MessagePage extends StatefulWidget {

  MessagePage({super.key, required this.message});

  late Map message;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Map msg;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    msg = widget.message;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message de"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(msg['user']['nom']),
          onPressed: () {
            
          },
        ),
      )
    );
  }
}