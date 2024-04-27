import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

// Event triggered when user attempts to log in
class UserLoginRequested extends UserEvent {
  final String email;
  final String password;

  const UserLoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// Event triggered when user attempts to sign up
class UserSignUpRequested extends UserEvent {
  final String phone;
  final String email;
  final String password;

  const UserSignUpRequested(this.email, this.password, this.phone);

  @override
  List<Object?> get props => [email, password];
}

// Event triggered when user logs out
class UserLogoutRequested extends UserEvent {
  const UserLogoutRequested();
}

// Event triggered when user info is requested
class UserGetInfoRequested extends UserEvent {
  const UserGetInfoRequested();
}
