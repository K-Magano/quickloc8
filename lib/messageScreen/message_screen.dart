import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:quickloc8/MapScreen/map_screen.dart';
import 'package:quickloc8/messageScreen/messages.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<JsonMessages>> ReadJsonFile() async {
    final jsondata =
        await rootBundle.rootBundle.loadString("assets/jsonfile/messages.json");
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => JsonMessages.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quick  Alerts",
          style: TextStyle(
            color: Colors.white, // Change color as desired
            fontSize: 25, // Adjust font size
            fontFamily: 'Roboto', // Set desired font family
            fontWeight: FontWeight.bold, // Adjust font weight
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF55722),
        elevation: 4, // Set border elevation
      ),
      body: FutureBuilder(
        future: ReadJsonFile(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<JsonMessages>;
            return ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        // Avatar
                        const CircleAvatar(
                          backgroundColor: Color(0xFFFFCCBC),
                          radius: 25,
                          child: Text(
                            'E',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Details (Subject, Message)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Subject
                              Text(
                                items[index].subject.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                              // Message
                              Text(
                                _truncateText(
                                  items[index].message.toString(),
                                  5,
                                ),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        // Display (Date)
                        Text(
                          items[index].display.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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

String _truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    final words = text.split(' ');
    if (words.length <= maxLength) {
      return words.join(' ');
    } else {
      return '${words.take(maxLength).join(' ')}...';
    }
  }
}
