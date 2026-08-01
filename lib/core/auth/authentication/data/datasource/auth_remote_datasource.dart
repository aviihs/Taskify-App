import 'package:taskify_app/core/auth/authentication/data/model/auth_model.dart';
import 'package:taskify_app/core/network/api_client.dart';
import 'package:taskify_app/core/network/api_constant.dart';
import 'package:taskify_app/core/network/api_helper.dart';

class AuthRemoteDatasource {
  final ApiClient _api;

  AuthRemoteDatasource(this._api);

  /// POST /auth/register
  Future<void> register(AuthModel auth) async {
    await _api.post(
      ApiConstants.register,
      data: auth.toJson(),
    );
  }

  /// POST /auth/login
  Future<AuthModel> login(AuthModel auth) async {
    final raw = await _api.post(
      ApiConstants.login,
      data: {
        'email': auth.email,
        'password': auth.password,
      },
    );

    final data = ApiHelper.data(raw);
    final json = ApiHelper.map(data);

    return AuthModel.fromJson(json);
  }

  /// POST /auth/refresh
  Future<AuthModel> refreshToken() async {
    final raw = await _api.post(ApiConstants.refreshToken);

    final data = ApiHelper.data(raw);
    final json = ApiHelper.map(data);

    return AuthModel.fromJson(json);
  }

  /// POST /auth/logout
  Future<void> logout(AuthModel auth) async {
    await _api.post(
      ApiConstants.logout,
      data: {
        'email': auth.email,
      },
    );
  }

  /// POST /auth/forgot-password
  Future<void> forgotPassword(AuthModel auth) async {
    await _api.post(
      ApiConstants.forgotPassword,
      data: {
        'email': auth.email,
      },
    );
  }

  /// POST /auth/reset-password
  Future<void> resetPassword(AuthModel auth) async {
    await _api.post(
      ApiConstants.resetPassword,
      data: {
        'token': auth.token,
        'newPassword': auth.newPassword,
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
      data: {
        'email': auth.email,
        'otp': auth.otp,
      },
    );
  }

  /// POST /auth/resend-otp
  Future<void> resendOtp(AuthModel auth) async {
    await _api.post(
      ApiConstants.resendOtp,
      data: {
        'email': auth.email,
      },
    );
  }
}