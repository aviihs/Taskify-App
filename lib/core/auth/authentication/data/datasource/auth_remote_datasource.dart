import 'package:taskify_app/core/auth/authentication/data/model/auth_model.dart';
import 'package:taskify_app/core/network/api_client.dart';
import 'package:taskify_app/core/network/api_constant.dart';

class AuthRemoteDatasource {
  final ApiClient _api;

  AuthRemoteDatasource(this._api);

  /// POST /auth/register
  Future<void> register(AuthModel auth) async {
    final payload = {
      'firstName': auth.firstName,
      'lastName': auth.lastName,
      'email': auth.email,
      'userName':
          auth.userName ??
          auth.email?.split('@').first ??
          'user_${DateTime.now().millisecondsSinceEpoch}',
      'password': auth.password,
    };
    await _api.post(ApiConstants.register, data: payload);
  }

  /// POST /auth/login
  Future<AuthModel> login(AuthModel auth) async {
    final response = await _api.post(
      ApiConstants.login,
      data: {"email": auth.email, "password": auth.password},
    );

    final Map<String, dynamic> jsonResponse = response is Map
        ? Map<String, dynamic>.from(response)
        : <String, dynamic>{};

    return AuthModel.fromJson(jsonResponse);
  }

  /// POST /auth/refresh
  Future<AuthModel> refreshToken(String refreshToken) async {
    final response = await _api.post(
      ApiConstants.refreshToken,
      data: {'refreshToken': refreshToken},
    );
    final Map<String, dynamic> jsonResponse = response is Map
        ? Map<String, dynamic>.from(response)
        : <String, dynamic>{};
    return AuthModel.fromJson(jsonResponse);
  }

  /// POST /auth/logout
  Future<void> logout(String refreshToken) async {
    await _api.post(ApiConstants.logout, data: {'refreshToken': refreshToken});
  }

  /// POST /auth/forgot-password
  Future<void> forgotPassword(AuthModel auth) async {
    await _api.post(ApiConstants.forgotPassword, data: {'email': auth.email});
  }

  /// POST /auth/reset-password
  Future<void> resetPassword(AuthModel auth) async {
    await _api.post(
      ApiConstants.resetPassword,
      data: {
        'token': auth.otp ?? auth.token,
        'newPassword': auth.newPassword ?? auth.password,
      },
    );
  }

  /// POST /auth/change-password
  Future<void> changePassword(AuthModel auth) async {
    await _api.post(
      ApiConstants.changePassword,
      data: {
        'currentPassword': auth.currentPassword,
        'newPassword': auth.newPassword,
      },
    );
  }

  /// POST /auth/verify-email
  Future<void> verifyEmail(AuthModel auth) async {
    await _api.post(
      ApiConstants.verifyEmail,
      data: {'email': auth.email, 'otp': auth.otp},
    );
  }

  /// POST /auth/resend-otp
  Future<void> resendOtp(AuthModel auth) async {
    await _api.post(ApiConstants.resendOtp, data: {'email': auth.email});
  }

  /// PUT /auth/profile
  Future<AuthModel> updateProfile(AuthModel auth) async {
    final payload = <String, dynamic>{};
    if (auth.firstName != null) payload['firstName'] = auth.firstName;
    if (auth.lastName != null) payload['lastName'] = auth.lastName;
    if (auth.dob != null) payload['dob'] = auth.dob;
    if (auth.gender != null) payload['gender'] = auth.gender;
    if (auth.bio != null) payload['bio'] = auth.bio;
    if (auth.phone != null) payload['phone'] = auth.phone;
    if (auth.avatar != null) payload['avatar'] = auth.avatar;

    final response = await _api.put('/auth/profile', data: payload);
    final Map<String, dynamic> jsonResponse = response is Map
        ? Map<String, dynamic>.from(response)
        : <String, dynamic>{};
    return AuthModel.fromJson(jsonResponse);
  }
}
