import 'package:flutter/foundation.dart';
import 'package:taskify_app/core/auth/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:taskify_app/core/auth/authentication/data/model/auth_model.dart';
import 'package:taskify_app/core/auth/authentication/domain/entity/auth_entity.dart';
import 'package:taskify_app/core/auth/authentication/domain/repository/auth_repository.dart';
import 'package:taskify_app/core/storage/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remote;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._remote, this._tokenStorage);

  @override
  Future<void> register(AuthEntity auth) async {
    await _remote.register(AuthModel.fromEntity(auth));
  }

  @override
  Future<AuthEntity> login(AuthEntity auth) async {
    debugPrint("REPOSITORY LOGIN HIT: ${auth.email}");

    final model = await _remote.login(AuthModel.fromEntity(auth));

    // Save access & refresh tokens securely
    if (model.accessToken != null && model.accessToken!.isNotEmpty) {
      await _tokenStorage.saveTokens(
        accessToken: model.accessToken!,
        refreshToken: model.refreshToken,
      );
      await _tokenStorage.saveUserJson(model.toJson());
    }

    return model.toEntity();
  }

  @override
  Future<AuthEntity> refreshToken() async {
    final currentRefreshToken = await _tokenStorage.getRefreshToken() ?? '';
    final model = await _remote.refreshToken(currentRefreshToken);

    if (model.accessToken != null && model.accessToken!.isNotEmpty) {
      await _tokenStorage.saveTokens(
        accessToken: model.accessToken!,
        refreshToken: model.refreshToken,
      );
    }

    return model.toEntity();
  }

  @override
  Future<void> logout(AuthEntity auth) async {
    final currentRefreshToken = await _tokenStorage.getRefreshToken() ?? '';
    try {
      await _remote.logout(currentRefreshToken);
    } catch (_) {}
    await _tokenStorage.clearAll();
  }

  @override
  Future<void> forgotPassword(AuthEntity auth) async {
    await _remote.forgotPassword(AuthModel.fromEntity(auth));
  }

  @override
  Future<void> resetPassword(AuthEntity auth) async {
    await _remote.resetPassword(AuthModel.fromEntity(auth));
  }

  @override
  Future<void> changePassword(AuthEntity auth) async {
    await _remote.changePassword(AuthModel.fromEntity(auth));
  }

  @override
  Future<void> verifyEmail(AuthEntity auth) async {
    await _remote.verifyEmail(AuthModel.fromEntity(auth));
  }

  @override
  Future<void> resendOtp(AuthEntity auth) async {
    await _remote.resendOtp(AuthModel.fromEntity(auth));
  }

  @override
  Future<AuthEntity> updateProfile(AuthEntity auth) async {
    final model = await _remote.updateProfile(AuthModel.fromEntity(auth));
    await _tokenStorage.saveUserJson(model.toJson());
    return model.toEntity();
  }
}