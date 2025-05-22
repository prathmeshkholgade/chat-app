import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:chatapp/features/messages/data/model/chat_message_model.dart';
import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:chatapp/features/messages/domain/entities/chat_room_entitiy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatRoomModel>> getChatRoom(
    String currentUid,
    String friendUid,
  );
  Future<Either<Failure, ChatMessaageEntitiy>> sendMessage({
    required String chatRoomId,
    required String senderUid,
    required String receiverUid,
    required String messageText,
    MessageType messageType = MessageType.text,
  });

  Future<Either<Failure, Stream<List<ChatMessageModel>>>> getMessage({
    required String roomId,
    DocumentSnapshot? lastMessage,
  });
  Future<Either<Failure, Stream<List<ChatMessageModel>>>> getMoreMsg({
    required String roomId,
    required DocumentSnapshot lastMessage,
  });
}
