import 'package:dio/dio.dart';
import 'package:ihamt/Service/interceptors.dart';

class ApiService {
  final Dio dio;

  ApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl: "http://localhost:3000",
          ),
        )..interceptors.add(CustomInterceptors());

  Future<Response> getRequest(String path, [bool isAuth = false]) async {
    if (isAuth) {
      print("Auth required");
      return dio.get(path, options: Options(headers: {"Authorization": ""}));
    } else {
      return dio.get(path);
    }
  }

  Future<Response> login(String email, String password) async {
    try {
      final response = await dio.get(
        "/login",
        queryParameters: {
          "username": email,
          "password": password,
        },
      );
      print("statuscode: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        print("Login successful");
        return response;
      }
      return response;
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == 400) {
          print('Bad Request: ${error.response?.data}');
        } else {
          throw Exception('Failed to fetch data: $error');
        }
      } else {
        throw Exception('Failed to fetch data: $error');
      }
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<Response> signup(String email, String password, String phone) async {
    try {
      print(phone);
      print(email);
      print(password);
      final response = await dio.post(
        "/signup",
        queryParameters: {
          "phone": phone,
          "username": email,
          "password": password,
        },
      );
      print("statuscode: " + response.statusCode.toString());
      if (response.statusCode == 201) {
        print("Signup successful");
        return response;
      }
      return response;
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == 400) {
          print('Bad Request: ${error.response?.data}');
        } else {
          throw Exception('Failed to fetch data: $error');
        }
      } else {
        throw Exception('Failed to fetch data: $error');
      }
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<Response> getUserData(String userId) async {
    try {
      final response = await dio.get("/user/$userId");
      return response;
    } catch (error) {
      // Handle error
      throw Exception("Failed to get user data: $error");
    }
  }

  Future<Response> postRequest(String path,
      {bool isAuth = true, dynamic body}) async {
    if (isAuth) {
      print("Auth required");
      return dio.post(path,
          data: body, options: Options(headers: {"Authorization": ""}));
    } else {
      return dio.post(path, data: body);
    }
  }

  Future<Response> putRequest(String path,
      {bool isAuth = true, dynamic body}) async {
    if (isAuth) {
      print("Auth required");
      return dio.put(path,
          data: body, options: Options(headers: {"Authorization": ""}));
    } else {
      return dio.put(path, data: body);
    }
  }

  Future<Response> deleteRequest(String path,
      {bool isAuth = true, dynamic body}) async {
    if (isAuth) {
      print("Auth required");
      return dio.delete(path,
          data: body, options: Options(headers: {"Authorization": ""}));
    } else {
      return dio.delete(path, data: body);
    }
  }
}
