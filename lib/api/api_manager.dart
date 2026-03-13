import 'package:dio/dio.dart';
import 'package:flutter_application/models/movie.dart';

class ApiManager {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: "https://movies-api.accel.li/api/v2/",
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));

  // --- GET MOVIES ---
  static Future<List<Movies>> getMovies() async {
    Response response = await dio.get("list_movies.json");

    List moviesJson = response.data["data"]["movies"];

    return moviesJson.map((e) => Movies.fromJson(e)).toList();
    // try {
    //   Response response = await dio.get("list_movies.json");
    //
    //   if (response.statusCode == 200) {
    //     List? moviesList = response.data["data"]["movies"];
    //     if (moviesList == null) return [];
    //     return moviesList.map((e) => Movie.fromJson(e)).toList();
    //   } else {
    //     throw Exception("Failed to load movies: ${response.statusCode}");
    //   }
    // } on DioException catch (e) {
    //   _handleDioError(e);
    //   return [];
    // } catch (e) {
    //   print("Unexpected Error: $e");
    //   return [];
    // }
  }

  // --- LOGIN FUNCTION ---
  static Future login(String email, String password) async {
    try {
      Response response = await dio.post(
        "auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      // Usually returns user data or a token
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
      // Re-throw or return null so the UI knows the login failed
      return null;
    } catch (e) {
      print("Unexpected Login Error: $e");
      return null;
    }
  }

// function register
  static Future register(String name, String email, String password) async {
    Response response = await dio.post(
      "auth/register",
      data: {"name": name, "email": email, "password": password},
    );

    return response.data;
  }

  // function reset password
  static Future resetPassword(String email, String password) async {
    Response response = await dio.patch(
      "auth/reset-password",
      data: {"email": email, "password": password},
    );

    return response.data;
  }
// function update profil
  static Future updateProfile(String name, String phone) async {
    Response response = await dio.patch(
      "auth/update-profile",
      data: {"name": name, "phone": phone},
    );

    return response.data;
  }

  // --- ERROR HANDLER ---
  static void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      print("Connection Timeout: Check your internet connection.");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      print("Server Timeout: The server is taking too long to respond.");
    } else if (e.type == DioExceptionType.badResponse) {
      // This is where 401 Unauthorized or 400 Bad Request errors are caught
      print("Server Error: ${e.response?.statusCode} - ${e.response?.data}");
    } else if (e.type == DioExceptionType.connectionError) {
      print("No Internet connection.");
    } else {
      print("Network Error: ${e.message}");
    }
  }
}
