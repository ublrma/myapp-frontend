import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

// Initial state
class UserInitial extends UserState {}

// State indicating that user login process is in progress
class UserLoading extends UserState {}

// State indicating that user login was successful
class UserLoginSuccess extends UserState {}

// State indicating that user login failed
class UserLoginFailure extends UserState {
  final String error;

  const UserLoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// State indicating that user sign up process is in progress
class UserSignUpLoading extends UserState {}

// State indicating that user sign up was successful
class UserSignUpSuccess extends UserState {}

// State indicating that user sign up failed
class UserSignUpFailure extends UserState {
  final String error;

  const UserSignUpFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// State indicating that user logout process is in progress
class UserLogoutLoading extends UserState {}

// State indicating that user logout was successful
class UserLogoutSuccess extends UserState {}

// State
