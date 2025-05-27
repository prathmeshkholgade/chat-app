import 'dart:async';

import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:chatapp/features/messages/domain/repository/chat_repository.dart';
import 'package:chatapp/features/messages/domain/usecase/get_chat_room.usecase.dart';
import 'package:chatapp/features/messages/domain/usecase/get_more_msg_usecase.dart';
import 'package:chatapp/features/messages/domain/usecase/get_msg_usecase.dart';
import 'package:chatapp/features/messages/domain/usecase/get_recent_chat_rooms.dart';
import 'package:chatapp/features/messages/domain/usecase/send_msg_usecase.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final GetRecentChatRoomsUseCase getRecentChatRoomsUseCase;
  final authController = sl<AuthController>();
  final FirestoreService fireStore = sl<FirestoreService>();
  MessageChatController({
    required this.sendMsgUseCase,
    required this.getChatRoomUseCase,
    required this.getMsgUseCase,
    required this.getMoreMsgUsecase,
    required this.getRecentChatRoomsUseCase,
  });
  var chatStatus = ChatStatus.intial.obs;
  var error = ''.obs;
  var chatRoom = Rxn<ChatRoomModel>();
  var messages = <ChatMessaageEntitiy>[].obs;
  RxBool isInTheChat = false.obs;

  StreamSubscription? _messageSubscription;
  CollectionReference get getChatRooms =>
      fireStore.fireStore.collection("chatRooms");

  CollectionReference getChatRoomMsg(String roomId) {
    return getChatRooms.doc(roomId).collection("messages");
  }

  Future<void> loadChatRoom({
    required String currentUid,
    required String friendUid,
  }) async {
    isInTheChat.value = true;
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
        chatRoom.value = room;
        chatStatus.value = ChatStatus.loaded;
        subscribeToMessages(room.id!);
      },
    );
  }

  Future<void> sendMessage(String currentUid, friendUid) async {
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
          (msgList) async {
            print("New messages received: $msgList");
            messages.assignAll(msgList);
            await markMessageAsRead(roomId, authController.user.value!.id);
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

  Stream<List<ChatRoomModel>> getRecentChatRooms() {
    final userUid = authController.user.value!.id;
    return getRecentChatRoomsUseCase(userUid);
  }

  Stream<int> getUnreadCount(String chatRoomid, String userId) {
    return getChatRoomMsg(chatRoomid)
        .where("receiverId", isEqualTo: userId)
        .where("status", isEqualTo: MessageStatus.sent.toString())
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.length;
        });
  }

  Future<void> markMessageAsRead(String chatRoomId, String userId) async {
    final batch = fireStore.fireStore.batch();
    final unReadMessages =
        await getChatRoomMsg(chatRoomId)
            .where("receiverid", isEqualTo: userId)
            .where("status", isEqualTo: MessageStatus.sent.toString())
            .get();
    print("found un read messages: ${unReadMessages.docs.length}");
    for (final doc in unReadMessages.docs) {
      batch.update(doc.reference, {
        "readBy": FieldValue.arrayUnion([userId]),
        "status": MessageStatus.read.toString(),
      });
      await batch.commit();
      print("marked msg as a read for userId $userId");
    }
  }

  Future<void> leaveChat() async {
    isInTheChat.value = false;
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
