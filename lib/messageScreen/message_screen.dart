/// Displays a list of messages loaded from a JSON file.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
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
          "Quick Alerts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF55722),
        elevation: 4,
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

                /**Each message is displayed within an ExpansionTile,
                 *  allowing users to expand and collapse messages. 
                 * The title of the ExpansionTile contains the subject of the message, while the children property contains the full message text. */
                  child: ExpansionTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xFFFFCCBC),
                            radius: 25,
                            child: Text(
                              'E',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].subject.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _truncateText(
                                    items[index].message.toString(),
                                    5,
                                  ),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          items[index].message.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
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
    );
  }

/*Truncates long message texts to a specified maximum length, appending ellipsis (...) 
if necessary to indicate truncation.*/

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
}
