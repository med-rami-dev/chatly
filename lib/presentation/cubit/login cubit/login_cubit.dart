import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitInitial());
  String? errorCode;
  //* This is the method to login the user
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginCubitLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginCubitSuccess());
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'user-not-found') {
        emit(LoginCubitFailed(errorCode: 'User not found'));
      } else if (exception.code == 'wrong-password') {
        emit(LoginCubitFailed(errorCode: 'Wrong password'));
      }
    } catch (e) {
      emit(LoginCubitFailed(errorCode: 'Something went wrong'));
    }
  }
}
