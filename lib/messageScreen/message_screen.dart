import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quickloc8/MapScreen/map_screen.dart';
import 'package:quickloc8/messageScreen/messages.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Messages> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString("assets/jsonfile/messages.json");

    final body = jsonDecode(data);
    setState(() {
      messages = body.map<Messages>(Messages.fromJson).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quick Alerts",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF55722),
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: messages.length, // Use the actual messages length
        itemBuilder: (context, index) {
          final message = messages[index];
          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                radius: 28, // Assuming you have an image or customization here
              ),
              title: Text(message.subject),
              subtitle: Text(message.message),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()),
        ),
        child: const Icon(Icons.map),
      ),
    );
  }
}
