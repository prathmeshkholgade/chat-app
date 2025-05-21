import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/messages/data/model/chat_message_model.dart';
import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class SendMsgRemoteDataSource {
  Future<Either<Failure, ChatMessaageEntitiy>> sendMsg({
    required String chatRoomId,
    required String senderUid,
    required String receiverUid,
    required String messageText,
    MessageType messageType = MessageType.text,
  });
}

class SendMsgRemoteDataSourceImpl implements SendMsgRemoteDataSource {
  final fireStore = sl<FirestoreService>();
  @override
  Future<Either<Failure, ChatMessaageEntitiy>> sendMsg({
    required String chatRoomId,
    required String senderUid,
    required String receiverUid,
    required String messageText,
    MessageType messageType = MessageType.text,
  }) async {
    try {
      CollectionReference chatRoom = fireStore.fireStore.collection(
        "chatRooms",
      );
      CollectionReference getChatRoomMessage(String chatRoomId) {
        return chatRoom.doc(chatRoomId).collection("messages");
      }

      // batch in firestore
      final batch = fireStore.fireStore.batch();
      //get message sub collections
      final messageRef = getChatRoomMessage(chatRoomId);

      final messageDoc = messageRef.doc();
      // chatMessage
      final message = ChatMessageModel(
        id: messageDoc.id,
        senderId: senderUid,
        receiverId: receiverUid,
        content: messageText,
        messageType: messageType,
        chatRoomId: chatRoomId,
        // status: ,
        readBy: [senderUid],
        createdAt: DateTime.now(),
      );

      // add message to sub collection
      batch.set(messageDoc, message.toJson());
      batch.update(chatRoom.doc(chatRoomId), {
        "lastMessage": messageText,
        "lastMessageSenderId": senderUid,
        "lastMessageTime": message.createdAt,
      });
      await batch.commit();
      return Right(message);
      //update chat room
    } catch (e) {
      print(e);
      return Left(ServerFailure(e.toString()));
    }
  }
}
