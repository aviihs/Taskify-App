import 'package:taskify_app/core/auth/authentication/domain/entity/auth_entity.dart';

abstract class AuthRepository {
  Future<void> register(AuthEntity auth);

  Future<AuthEntity> login(AuthEntity auth);

  Future<AuthEntity> refreshToken();

  Future<void> logout(AuthEntity auth);

  Future<void> forgotPassword(AuthEntity auth);

  Future<void> resetPassword(AuthEntity auth);

  Future<void> changePassword(AuthEntity auth);

  Future<void> verifyEmail(AuthEntity auth);

  Future<void> resendOtp(AuthEntity auth);
}