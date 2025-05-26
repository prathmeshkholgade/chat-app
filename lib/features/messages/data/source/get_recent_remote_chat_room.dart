import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetRecentRemoteChatRoom {
  Stream<List<ChatRoomModel>> getRecentChatRooms(String userId);
}

class GetRecentRemoteChatRoomImpl implements GetRecentRemoteChatRoom {
  final FirestoreService fireStore = sl<FirestoreService>();
  @override
  Stream<List<ChatRoomModel>> getRecentChatRooms(String userId) {
    // TODO: implement getRecentChatRooms
    CollectionReference chatRoom = fireStore.fireStore.collection("chatRooms");
    return chatRoom
        .where("participants", arrayContains: userId)
        .orderBy("lastMessageTime", descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((docs) => ChatRoomModel.fromFireStore(docs))
                  .toList(),
        );
  }
}
