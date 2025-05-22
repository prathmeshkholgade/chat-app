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
      participants:
          (json["participants"] as List<dynamic>)
              .map((e) => e?.toString())
              .toList(),
      isTyping: json["isTyping"] ?? false,
      isTypingUserId: json["isTypingUserId"],
      lastMessageTime: (json["lastMessageTime"] as Timestamp?)?.toDate(),
      lastMessageSenderId: json["lastMessageSenderId"],
      lastreadtime: (json["lastreadtime"] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as Timestamp),
      ),
      participantsName: (json["participantsName"] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value.toString())),
      lastMessage: json["lastMessage"],
    );
  }

  factory ChatRoomModel.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatRoomModel.fromJson({"id": doc.id, ...data});
  }
}
