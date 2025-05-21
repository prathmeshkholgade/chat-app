import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:chatapp/features/messages/data/model/chat_message_model.dart';
import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:chatapp/features/messages/presentation/getx/message_chat_controller.dart';
import 'package:chatapp/features/messages/presentation/widgets/message_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MessageDetailsPage extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  const MessageDetailsPage({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<MessageDetailsPage> createState() => _MessageDetailsPageState();
}

class _MessageDetailsPageState extends State<MessageDetailsPage> {
  final chatMessageController = sl<MessageChatController>();
  final authController = sl<AuthController>();
  late String currentUid;
  @override
  void initState() {
    currentUid = authController.user.value!.id;
    super.initState();
    print("this is receiver id  ${widget.receiverId}");
    chatMessageController.loadChatRoom(
      currentUid: currentUid,
      friendUid: widget.receiverId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(child: Text(widget.receiverName[0].toUpperCase())),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.receiverName),
                Text(
                  "online",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Icon(Icons.video_call),
          SizedBox(width: 10),
          Icon(Icons.call),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.black12),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return MessageBubbles(
                    message: ChatMessageModel(
                      id: "dfs",
                      chatRoomId: "sadsa",
                      senderId: "sad",
                      receiverId: widget.receiverId,
                      content: "hello i am prathmesh  ",
                      readBy: [],
                      status: MessageStatus.sent,
                      messageType: MessageType.text,
                      createdAt: DateTime.now(),
                    ),
                    isMe: true,
                  );
                },
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.emoji_emotions),
                    Expanded(
                      child: TextField(
                        controller: chatMessageController.messageController,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    Obx(() {
                      final isChatRoomReady =
                          chatMessageController.chatRoom.value != null;
                      return GestureDetector(
                        onTap:
                            isChatRoomReady
                                ? () {
                                  print(
                                    "sending message $currentUid to ${widget.receiverId}",
                                  );
                                  chatMessageController.sendMessage(
                                    currentUid,
                                    widget.receiverId,
                                  );
                                }
                                : null, // disables the tap if chatRoom is not ready
                        child: CircleAvatar(
                          backgroundColor:
                              isChatRoomReady
                                  ? Colors.orange[300]
                                  : Colors.grey,
                          child: Icon(Icons.send),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
