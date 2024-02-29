part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatReceived extends ChatState {
  final List<Message> messagesList;
  ChatReceived({required this.messagesList});
}

final class ChatFailure extends ChatState {
  final String? errorMessage;
  ChatFailure({this.errorMessage});
}
