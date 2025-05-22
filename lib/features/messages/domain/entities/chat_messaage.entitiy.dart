enum MessageType { text, image, vidio }

enum MessageStatus { sent, delivered, read }

class ChatMessaageEntitiy  {
  final String id;
  final String senderId;
  final String chatRoomId;
  final String receiverId;
  final String content;
  final MessageType messageType;
  final MessageStatus status;
  final List<String> readBy;
  final DateTime createdAt;

  ChatMessaageEntitiy({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.chatRoomId,
    this.messageType = MessageType.text,
    this.status = MessageStatus.sent,
    required this.readBy,
    required this.createdAt,
  });
}
