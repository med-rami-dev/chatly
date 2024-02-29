import 'package:chatly/constants.dart';
import 'package:chatly/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message> messagesList = [];
  //* This function will send message to firebase
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  void sendMessage({required String message, required String email}) {
    // send message to firebase
    try {
      messages.add(
        {kMessage: message, kCreatedAt: DateTime.now(), kId: email},
      );
    } on FirebaseFirestore catch (ex) {
      emit(ChatFailure(errorMessage: 'There is SomeThing Went Wrong $ex'));
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var docs in event.docs) {
        messagesList.add(Message.fromJson(docs));
      }
      emit(ChatReceived(messagesList: messagesList));
    });
  }
}
