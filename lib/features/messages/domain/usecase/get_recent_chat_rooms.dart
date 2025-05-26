import 'package:chatapp/features/messages/data/model/Chat_room_model.dart';
import 'package:chatapp/features/messages/domain/repository/chat_repository.dart';

class GetRecentChatRoomsUseCase {
  final ChatRepository chatRepository;
  GetRecentChatRoomsUseCase({required this.chatRepository});

  Stream<List<ChatRoomModel>> call(String userId) {
    return chatRepository.getRecentChatRooms(userId);
  }
}
