import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:chatapp/features/messages/data/model/chat_message_model.dart';
import 'package:chatapp/features/messages/data/source/chat_remote_data_sorce.dart';
import 'package:chatapp/features/messages/data/source/get_more_msg_remote_data_source.dart';
import 'package:chatapp/features/messages/data/source/get_msg_remote_data_source.dart';
import 'package:chatapp/features/messages/data/source/send_msg_remote_data_source.dart';
import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:chatapp/features/messages/domain/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ChatRepoImp implements ChatRepository {
  final ChatRemoteDataSorce chatRemoteDataSorce;
  final SendMsgRemoteDataSource sendMsgRemoteDataSource;
  final GetMsgRemoteDataSource getMsgRemoteDataSource;
  final GetMoreMsgRemoteDataSource getMoreMsgRemoteDataSource;
  ChatRepoImp({
    required this.sendMsgRemoteDataSource,
    required this.chatRemoteDataSorce,
    required this.getMsgRemoteDataSource,
    required this.getMoreMsgRemoteDataSource,
  });
  @override
  Future<Either<Failure, ChatRoomModel>> getChatRoom(
    String currentUid,
    String friendUid,
  ) async {
    return await chatRemoteDataSorce.getChatRoom(currentUid, friendUid);
  }

  @override
  Future<Either<Failure, ChatMessaageEntitiy>> sendMessage({
    required String chatRoomId,
    required String senderUid,
    required String receiverUid,
    required String messageText,
    MessageType messageType = MessageType.text,
  }) {
    return sendMsgRemoteDataSource.sendMsg(
      chatRoomId: chatRoomId,
      senderUid: senderUid,
      receiverUid: receiverUid,
      messageText: messageText,
      messageType: messageType,
    );
  }

  @override
  Future<Either<Failure, Stream<List<ChatMessageModel>>>> getMessage({
    required String roomId,
    DocumentSnapshot? lastMessage,
  }) {
    return getMsgRemoteDataSource.getMessage(
      roomId: roomId,
      lastMessage: lastMessage,
    );
  }

  @override
  Future<Either<Failure, Stream<List<ChatMessageModel>>>> getMoreMsg({
    required String roomId,
    required DocumentSnapshot lastMessage,
  }) {
    return getMoreMsgRemoteDataSource.getMoreMsg(
      roomId: roomId,
      lastMessage: lastMessage,
    );
  }
}
