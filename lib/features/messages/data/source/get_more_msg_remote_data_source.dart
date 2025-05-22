import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/messages/data/model/chat_message_model.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class GetMoreMsgRemoteDataSource {
  Future<Either<Failure, Stream<List<ChatMessageModel>>>> getMoreMsg({
    required String roomId,
    required DocumentSnapshot lastMessage,
  });
}

class GetMoreMsgRemoteDataSourceImp implements GetMoreMsgRemoteDataSource {
  final FirestoreService fireStore = sl<FirestoreService>();

  @override
  Future<Either<Failure, Stream<List<ChatMessageModel>>>> getMoreMsg({
    required String roomId,
    required DocumentSnapshot lastMessage,
  }) async {
    try {
      CollectionReference chatRoom = fireStore.fireStore.collection(
        "chatRooms",
      );

      CollectionReference getChatRoomMessage(String chatRoomId) {
        return chatRoom.doc(chatRoomId).collection("messages");
      }

      final query = getChatRoomMessage(roomId)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(lastMessage)
          .limit(20);

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
