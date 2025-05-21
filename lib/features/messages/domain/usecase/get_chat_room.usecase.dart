import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:chatapp/features/messages/domain/entities/chat_messaage.entitiy.dart';
import 'package:chatapp/features/messages/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class GetChatRoomUseCase {
  final ChatRepository chatRepository;
  GetChatRoomUseCase({required this.chatRepository});

  Future<Either<Failure, ChatRoomModel>> call({
    required String currentUid,
    required String friendUid,
  }) {
    return chatRepository.getChatRoom(currentUid, friendUid);
  }
}
