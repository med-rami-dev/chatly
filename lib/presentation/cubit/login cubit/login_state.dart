part of 'login_cubit.dart';

@immutable
sealed class LoginCubitState {}

final class LoginCubitInitial extends LoginCubitState {}

final class LoginCubitSuccess extends LoginCubitState {}

final class LoginCubitFailed extends LoginCubitState {
  final String? errorCode;
  LoginCubitFailed({this.errorCode});
}

final class LoginCubitLoading extends LoginCubitState {}
