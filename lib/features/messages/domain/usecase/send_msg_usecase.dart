import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:chatapp/features/messages/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class SendMsgUseCase {
  final ChatRepository chatRepository;
  SendMsgUseCase({required this.chatRepository});
  Future<Either<Failure, ChatMessaageEntitiy>> sendMessage({
    required String chatRoomId,
    required String senderUid,
    required String receiverUid,
    required String messageText,
    MessageType messageType = MessageType.text,
  }) {
    return chatRepository.sendMessage(
      chatRoomId: chatRoomId,
      senderUid: senderUid,
      receiverUid: receiverUid,
      messageText: messageText,
      messageType: messageType,
    );
  }
}
