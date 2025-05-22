import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/addnewcontact/domain/model/contact_model.dart';
import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRemoteDataSorce {
  Future<Either<Failure, ChatRoomModel>> getChatRoom(
    String currentUid,
    String friendUid,
  );
}

class ChatRemoteDataSorceImpl extends ChatRemoteDataSorce {
  final FirestoreService fireStore = sl<FirestoreService>();
  @override
  Future<Either<Failure, ChatRoomModel>> getChatRoom(
    String currentUid,
    String friendUid,
  ) async {
    try {
      CollectionReference chatCollRef = fireStore.fireStore.collection(
        'chatRooms',
      );
      final users = [currentUid, friendUid]..sort();
      final String roomId = users.join("_");
      final DocumentReference chatRoomRef = fireStore.fireStore
          .collection("chatRooms")
          .doc(roomId);
      final roomDocs = await chatRoomRef.get();
      if (roomDocs.exists) {
        final chatRoom = ChatRoomModel.fromFireStore(roomDocs);
        return right(chatRoom);
      }

      final currentUserData =
          (await fireStore.fireStore.collection("users").doc(currentUid).get())
              .data();
      final friendUserData =
          (await fireStore.fireStore.collection("users").doc(friendUid).get())
              .data();

      final participantsName = {
        currentUid: currentUserData?["name"].toString() ?? " ",
        friendUid: friendUserData?["name"].toString() ?? " ",
      };

      final newRoom = ChatRoomModel(
        id: roomId,
        participants: users,
        participantsName: participantsName,
        lastreadtime: {currentUid: Timestamp.now(), friendUid: Timestamp.now()},
      );
      await chatCollRef.doc(roomId).set(newRoom.toJson());
      return right(newRoom);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
