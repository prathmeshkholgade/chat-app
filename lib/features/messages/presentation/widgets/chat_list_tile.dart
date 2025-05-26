import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final ChatRoomModel chat;
  final String currentUserId;
  final VoidCallback onTap;
  const ChatListTile({
    super.key,
    required this.chat,
    required this.currentUserId,
    required this.onTap,
  });

  String getChatRoomName() {
    final friendUserid = chat.participants.firstWhere(
      (id) => id != currentUserId,
      orElse: () => '',
    );
    print("error bro ...");
    return chat.participantsName?[friendUserid] ?? "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          getChatRoomName()[0].toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        getChatRoomName(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Expanded(
        child: Text(
          chat.lastMessage ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Text("3"),
      ),
    );
  }
}
