import 'package:dio/dio.dart';

class CustomInterceptors extends InterceptorsWrapper {
  CustomInterceptors()
      : super(
          onRequest: (options, handler) {
            print("On request");

            return handler.next(options);
          },
          onResponse: (response, handler) {
            print("On response");
            return handler.next(response);
          },
          onError: (DioError e, handler) {
            print("On error");
            return handler.next(e);
          },
        );
}
