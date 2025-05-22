import 'dart:async';

import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:chatapp/features/messages/domain/repository/chat_repository.dart';
import 'package:chatapp/features/messages/domain/usecase/get_chat_room.usecase.dart';
import 'package:chatapp/features/messages/domain/usecase/get_more_msg_usecase.dart';
import 'package:chatapp/features/messages/domain/usecase/get_msg_usecase.dart';
import 'package:chatapp/features/messages/domain/usecase/send_msg_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

enum ChatStatus { intial, loading, loaded, error }

class MessageChatController extends GetxController {
  final messageController = TextEditingController();
  final GetChatRoomUseCase getChatRoomUseCase;
  final SendMsgUseCase sendMsgUseCase;
  final GetMsgUsecase getMsgUseCase;
  final GetMoreMsgUsecase getMoreMsgUsecase;

  MessageChatController({
    required this.sendMsgUseCase,
    required this.getChatRoomUseCase,
    required this.getMsgUseCase,
    required this.getMoreMsgUsecase,
  });
  var chatStatus = ChatStatus.intial.obs;
  var error = ''.obs;
  var chatRoom = Rxn<ChatRoomModel>();
  var messages = <ChatMessaageEntitiy>[].obs;
  StreamSubscription? _messageSubscription;

  Future<void> loadChatRoom({
    required String currentUid,
    required String friendUid,
  }) async {
    print("loading chat room...");
    chatStatus.value = ChatStatus.loaded;
    final result = await getChatRoomUseCase(
      currentUid: currentUid,
      friendUid: friendUid,
    );
    result.fold(
      (failuer) {
        print(failuer);
        chatStatus.value = ChatStatus.error;
        error.value = failuer.message;
      },
      (room) {
        print("Chat room successfully loaded: ${room.id}");
        print("and this is room $room");
        chatRoom.value = room;
        chatStatus.value = ChatStatus.loaded;

        subscribeToMessages(room.id!);
      },
    );
  }

  Future<void> sendMessage(String currentUid, friendUid) async {
    print(
      "send msg reached here with $currentUid to $friendUid and the message is < ${messageController.text} > and the chatRoom value is  this ${chatRoom.value} ",
    );
    if (messageController.text.trim().isEmpty || chatRoom.value == null) return;

    final msgText = messageController.text.trim();
    final roomId = chatRoom.value!.id;
    if (roomId == null || roomId.isEmpty) return;
    print("message sending is processing ");
    final result = await sendMsgUseCase.sendMessage(
      chatRoomId: roomId,
      senderUid: currentUid,
      receiverUid: friendUid,
      messageText: msgText,
    );
    result.fold(
      (failure) {
        print(failure);
      },
      (msg) {
        messageController.clear();
        print("msg sent to user");
      },
    );
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void subscribeToMessages(String roomId) async {
    _messageSubscription?.cancel();
    final result = await getMsgUseCase(roomId: roomId);
    result.fold(
      (failure) {
        print("Failed to get messages: ${failure.message}");
        chatStatus.value = ChatStatus.error;
        error.value = failure.message;
      },
      (stream) {
        _messageSubscription = stream.listen(
          (msgList) {
            print("New messages received: $msgList");
            messages.assignAll(msgList);
          },
          onError: (e) {
            print("Error listening to messages: $e");
            chatStatus.value = ChatStatus.error;
            error.value = e.toString();
          },
        );
      },
    );
  }
}
