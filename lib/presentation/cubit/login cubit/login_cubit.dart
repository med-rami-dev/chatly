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

  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> loginAsGuest() async {
    try {
      emit(LoginCubitLoading());
      final user = await FirebaseAuth.instance.signInAnonymously();
      emit(LoginCubitSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginCubitFailed(errorCode: e.code));
    } catch (e) {
      emit(LoginCubitFailed(errorCode: 'Something went wrong'));
    }
  }
}
