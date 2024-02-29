import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  //? This is the method to Login the user
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginCubitLoading());
    try {
      await FirebaseAuth.instance
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

  //? This is the method to register the user
  Future<void> registerUser({required String email, password}) async {
    try {
      emit(RegisterLoading());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'weak password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'email already exists'));
      }
    } catch (ex) {
      emit(
          RegisterFailure(errorMessage: 'there was an error please try again'));
    }
  }
}
