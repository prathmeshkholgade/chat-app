import 'package:chatapp/features/messages/domain/entities/chat_room_entitiy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel extends ChatRoomEntity {
  ChatRoomModel({
    required super.id,
    required super.participants,
    super.lastMessageTime,
    super.lastMessageSenderId,
    super.lastreadtime,
    super.participantsName,
    super.isTyping = false,
    super.isTypingUserId,
    super.lastMessage,
  });
  // to convert json from object
  toJson() {
    return {
      'id': id,
      'participants': participants,
      'lastMessageTime': lastMessageTime,
      'lastMessageSenderId': lastMessageSenderId,
      'lastreadtime': lastreadtime,
      'participantsName': participantsName,
      'isTyping': isTyping,
      'isTypingUserId': isTypingUserId,
      'lastMessage': lastMessage,
    };
  }

  // fromjson to convert json to object
  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json["id"],
      participants: json["participants"],
      isTyping: json["isTyping"],
      isTypingUserId: json["isTypingUserId"],
      lastMessageTime: json["lastMessageTime"],
      lastMessageSenderId: json["lastMessageSenderId"],
      lastreadtime: json["lastreadtime"],
      participantsName: json["participantsName"],
      lastMessage: json["lastMessage"],
    );
  }

  factory ChatRoomModel.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatRoomModel.fromJson({"id": doc.id, ...data});
  }
}
