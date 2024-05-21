import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.data, required this.self});
  final Map<String, dynamic> data;
  final bool self;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: self ? Colors.lightGreen[100] : Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          !self
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(data['photoURL'])),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  data['displayName'],
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
                data['photoURL'] != null
                    ? Image.network(
                        data['photoURL'],
                        width: 190,
                      )
                    : Text(data['message'],
                        textAlign: self ? TextAlign.end : TextAlign.start,
                        style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          self
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(data['photoURL'])),
                )
              : Container()
        ],
      ),
    );
  }
}
