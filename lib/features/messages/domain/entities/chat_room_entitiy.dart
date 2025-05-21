import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomEntity {
  final String? id;
  final List<String?> participants;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final String? lastMessageSenderId;
  final Map<String, Timestamp>? lastreadtime;
  final Map<String, String>? participantsName;
  final bool? isTyping;
  final bool? isTypingUserId;

  ChatRoomEntity({
    required this.id,
    required this.participants,
    this.lastMessageTime,
    this.lastMessage,
    this.lastMessageSenderId,
    this.lastreadtime,
    this.participantsName,
    this.isTyping = false,
    this.isTypingUserId,
  });
}
