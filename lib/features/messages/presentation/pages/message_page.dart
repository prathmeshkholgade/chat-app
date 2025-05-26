import 'package:chatapp/core/common/widgets/app_text.dart';
import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:chatapp/features/messages/presentation/getx/message_chat_controller.dart';
import 'package:chatapp/features/messages/presentation/pages/message_details_page.dart';
import 'package:chatapp/features/messages/presentation/widgets/chat_list_tile.dart';
import 'package:chatapp/features/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key});
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final messageChatController = sl<MessageChatController>();
  final authController = sl<AuthController>();
  @override
  void initState() {
    super.initState();
    // Wait until the user data is available before loading messages
    
  }

  @override
  Widget build(BuildContext context) {
    final currId = authController.user.value;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        title: AppText(text: "Messages", size: 18),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(ProfilePage());
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Obx(
        () =>
            authController.user.value?.id == null
                ? Center(child: CircularProgressIndicator())
                : StreamBuilder(
                  stream: messageChatController.getRecentChatRooms(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.data;
                    if (data!.isEmpty) {
                      return Center(child: Text('No recent chat rooms'));
                    }

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final chat = data[index];
                        return ChatListTile(
                          chat: chat,
                          currentUserId: currId!.id,
                          onTap: () {
                            print("gettign to details page");
                            final friendUserid = chat.participants.firstWhere(
                              (id) => id != currId.id,
                            );
                            print(" user id $friendUserid");
                            final friendUserName =
                                chat.participantsName?[friendUserid] ??
                                "unknown";
                            print(friendUserName);
                            print(friendUserid);
                            Get.to(
                              () => MessageDetailsPage(
                                receiverId: friendUserid!,
                                receiverName: friendUserName,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),

        //obx
      ),
    );
  }
}
