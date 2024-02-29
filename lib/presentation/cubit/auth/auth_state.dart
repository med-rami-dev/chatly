part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

//* This is For Register
final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFailure extends AuthState {
  final String? errorMessage;
  RegisterFailure({this.errorMessage});
}

//* This is for Login
final class LoginCubitSuccess extends AuthState {}

final class LoginCubitFailed extends AuthState {
  final String? errorCode;
  LoginCubitFailed({this.errorCode});
}

final class LoginCubitLoading extends AuthState {}
