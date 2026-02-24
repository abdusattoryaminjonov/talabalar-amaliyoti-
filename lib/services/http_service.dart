import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constands/constands.dart';
import '../models/login_users_model/users_model.dart';
import 'log_service.dart';

class HttpService {

  Future<http.Response> login(String login, String password) async {
    final url = Uri.parse("$BASE_URL/tap-api/api/auth/login");

    final body = jsonEncode({
      "username": login,
      "password": password,
    });

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    LogService.d(response.body);

    return response;
  }

  Future<http.Response> refreshToken(String refreshToken) async {
    final url = Uri.parse(
        "https://apiyangi.uznpu.uz/tap-api/api/auth/refresh-token");

    final body = jsonEncode({
      "refreshToken": refreshToken,
    });

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    return response;
  }

  Future<http.Response> updatePassword(String currentPass, String newPass, String confirmPass, String token) async {
    final url = Uri.parse("$BASE_URL/tap-api/api/auth/change-password");

    final body = jsonEncode({
      "currentPassword": currentPass,
      "newPassword": newPass,
      "confirmPassword": confirmPass
    });

    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );

    LogService.d(response.body);

    return response;
  }

  Future<http.Response> getProfileData(String token) async {
    final url = Uri.parse("$BASE_URL/tap-api/api/me");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getMyInternships(String token) async {
    final url = Uri.parse("$BASE_URL/tap-api/api/student/my-internships");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getQuotas(String token, int internshipId,int pageNumber) async {
    final url = Uri.parse("$BASE_URL/tap-api/api/student/show-quota?internshipId=$internshipId&pageNumber=$pageNumber&pageSize=10");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getAttendance(String token, int internshipId) async {
    final url = Uri.parse("$BASE_URL/tap-api/api/attendance/$internshipId");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> getAttendanceDaily(String token, int internshipId) async {
    final url = Uri.parse("$BASE_URL/tap-api/api/attendance/daily/$internshipId");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return response;
  }

  Future<http.Response> attendance({required String token,required int internshipId,required String lat,required String lng,required String notes,required String buttonType}) async {
    final url = Uri.parse("$BASE_URL/tap-api/api/attendance/check");


    final body = jsonEncode({
      "internshipId": internshipId,
      "latitude": lat,
      "longitude": lng,
      "notes": notes,
      "action": buttonType
    });

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body
    );

    return response;
  }

  Future<http.Response> choseQuota(String token, int internshipId,int quotaId) async {
    final url = Uri.parse("$BASE_URL/tap-api/api/student/assign-quota");

    final body = jsonEncode({
      "internshipId": internshipId,
      "quotaId": quotaId
    });

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body
    );

    return response;
  }

  Future<UsersModel?> fetchUsers(String token) async {
    const url = "$BASE_URL/api/auth/all";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return UsersModel.fromJson(jsonDecode(response.body));
      } else {
        print("Xato: ${response.statusCode} => ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<bool> updateUser(String token, int id, String name, String username, String password, String role) async {
    final url = Uri.parse("$BASE_URL/api/auth/$id");

    final body = {
      "name": name,
      "username": username,
      "password": password,
      "authRoles": ["${role.toUpperCase()}"],
    };

    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return true; // muvaffaqiyatli yangilandi
    } else {
      throw Exception("Update xatolik: ${response.statusCode} ${response.body}");
    }
  }


  static void _throwException(http.Response response) {
    String reason = response.reasonPhrase ?? 'Unknown error';
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(reason);
      case 401:
        throw InvalidInputException(reason);
      case 403:
        throw UnauthorisedException(reason);
      case 404:
        throw FetchDataException(reason);
      case 500:
      default:
        throw FetchDataException(reason);
    }
  }
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
}

class InvalidInputException implements Exception {
  final String message;
  InvalidInputException(this.message);
}

class UnauthorisedException implements Exception {
  final String message;
  UnauthorisedException(this.message);
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);
}