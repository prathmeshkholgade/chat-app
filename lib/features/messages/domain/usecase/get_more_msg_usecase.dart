import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/messages/data/model/chat_message_model.dart';
import 'package:chatapp/features/messages/domain/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class GetMoreMsgUsecase {
  final ChatRepository chatRepository;
  GetMoreMsgUsecase({required this.chatRepository});

  Future<Either<Failure, Stream<List<ChatMessageModel>>>> call({
    required String roomId,
    required DocumentSnapshot lastMessage,
  }) {
    return chatRepository.getMoreMsg(roomId: roomId, lastMessage: lastMessage);
  }
}
