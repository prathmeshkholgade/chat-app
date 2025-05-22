import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:chatapp/features/messages/data/model/chat_message_model.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class GetMsgRemoteDataSource {
  Future<Either<Failure, Stream<List<ChatMessageModel>>>> getMessage({
    required String roomId,
    DocumentSnapshot? lastMessage,
  });
}

class GetMsgeRemoteDataSourceImp implements GetMsgRemoteDataSource {
  final FirestoreService fireStore = sl<FirestoreService>();

  @override
  Future<Either<Failure, Stream<List<ChatMessageModel>>>> getMessage({
    required String roomId,
    DocumentSnapshot? lastMessage,
  }) async {
    try {
      CollectionReference chatRoom = fireStore.fireStore.collection(
        "chatRooms",
      );
      CollectionReference getChatRoomMessage(String chatRoomId) {
        return chatRoom.doc(chatRoomId).collection("messages");
      }

      var query = getChatRoomMessage(
        roomId,
      ).orderBy("createdAt", descending: true).limit(20);
      if (lastMessage != null) {
        query = query.startAfterDocument(lastMessage);
      }

      Stream<List<ChatMessageModel>> messageStream = query.snapshots().map(
        (snapshot) =>
            snapshot.docs
                .map((doc) => ChatMessageModel.fromFireStore(doc))
                .toList(),
      );

      return Right(messageStream);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
