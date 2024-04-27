import 'package:bloc/bloc.dart';
import 'package:my_app/Service/api.dart';
import 'package:my_app/bloc/User/userstates.dart';
import 'package:my_app/bloc/User/uevents.dart';
import 'package:my_app/Model/User.dart';
import 'package:my_app/providers/common.dart';

import 'package:provider/provider.dart';

import 'package:ihamt/global_keys.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserLoginRequested>((event, emit) async {
      emit(UserLoading());
      try {
        final api = ApiService();
        final res = await api.login(event.email, event.password);

        print(res.statusCode);
        if (res.statusCode == 200) {
          print("done");

          final result = await api.getUserData(res.data);
          print(result);
          User a = User.fromJson(result.data);
          Provider.of<CommonProvider>(GlobalKeys.navigatorKey.currentContext!,
                  listen: false)
              .updateUser(a);
          emit(UserLoginSuccess());
        } else {
          emit(UserLoginFailure("Нууц үг нэр буруу"));
        }
      } catch (e) {
        print(e);
        print("errr");
        emit(UserLoginFailure("Нэр эсвэл нууц үг буруу"));
      }
    });

    on<UserSignUpRequested>((event, emit) async {
      emit(UserSignUpLoading());
      try {
        final api = ApiService();
        final res = await api.signup(event.email, event.password, event.phone);

        print(res.statusCode);
        if (res.data == "Signup successful") {
          print("done");
          emit(UserSignUpSuccess());
        } else {
          emit(UserSignUpFailure("Нууц үг нэр буруу"));
        }
      } catch (e) {
        print(e);
        print("errr");
        emit(UserSignUpFailure("Хэрэглэгч бүртгэгдсэн байна."));
      }
    });
  }

  // @override
  // Stream<UserState> mapEventToState(UserEvent event) async* {
  //   if (event is UserLoginRequested) {
  //     yield* _mapUserLoginRequestedToState(event);
  //   }
  //   // Add other event handlers here if needed
  // }

  // Stream<UserState> _mapUserLoginRequestedToState(
  //     UserLoginRequested event) async* {
  //   yield UserLoading();
  //   try {
  //     // Call your authentication service to perform login
  //     final res = await apiService.login(event.email, event.password);

  //     // Process the login response
  //     // For example, check if login was successful or not
  //     if (res.data['success']) {
  //       yield UserLoginSuccess();
  //     } else {
  //       yield UserLoginFailure(res.data['message']);
  //     }
  //   } catch (e) {
  //     yield UserLoginFailure('An error occurred during login');
  //   }
  // }
}
