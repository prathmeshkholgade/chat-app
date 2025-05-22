import 'package:chatapp/features/messages/data/model/chat_message_model.dart';
import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:flutter/material.dart';

class MessageBubbles extends StatelessWidget {
  final ChatMessaageEntitiy message;
  final bool isMe;
  const MessageBubbles({required this.message, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          minWidth: 40,
          maxWidth: MediaQuery.of(context).size.width * 0.6, // Set max width
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[800],
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.only(
          left: isMe ? 64 : 8,
          right: isMe ? 8 : 6,
          bottom: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(message.content, style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("4:54 AM"),
                const SizedBox(width: 4),
                Icon(
                  (Icons.done_all),
                  color:
                      message.status == MessageStatus.read
                          ? Colors.red
                          : Colors.white70,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
