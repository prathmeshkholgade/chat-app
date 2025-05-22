import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel extends ChatMessaageEntitiy {
  ChatMessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.readBy,
    required super.createdAt,
    required super.chatRoomId,
    super.status,
    super.messageType,
  });
  // object to json
  toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': content,
      "chatRoomId": chatRoomId,
      'status': status.toString(),
      'readBy': readBy,
      'createdAt': createdAt,
      'messageType': messageType.toString(),
    };
  }

  // fromjson to convert json to object
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      content: json['message'] ?? '',
      status: MessageStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => MessageStatus.sent,
      ),
      chatRoomId: json["chatRoomId"] ?? '',
      readBy: (json['readBy'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      messageType: MessageType.values.firstWhere(
        (e) => e.toString() == json['messageType'],
        orElse: () => MessageType.text,
      ),
    );
  }

  // fromjson to convert json to object
  factory ChatMessageModel.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessageModel.fromJson({"id": doc.id, ...data});
  }
  String toString() {
    return '''
ChatMessageModel(
  id: $id,
  senderId: $senderId,
  receiverId: $receiverId,
  content: $content,
  chatRoomId: $chatRoomId,
  messageType: $messageType,
  status: $status,
  readBy: $readBy,
  createdAt: $createdAt
)
''';
  }
}
