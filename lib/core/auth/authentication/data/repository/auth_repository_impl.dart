

import 'package:taskify_app/core/auth/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:taskify_app/core/auth/authentication/data/model/auth_model.dart';
import 'package:taskify_app/core/auth/authentication/domain/entity/auth_entity.dart';
import 'package:taskify_app/core/auth/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remote;

  AuthRepositoryImpl(this._remote);

  @override
  Future<void> register(AuthEntity auth) async {
    await _remote.register(AuthModel.fromEntity(auth));
  }

  @override
  Future<AuthEntity> login(AuthEntity auth) async {
    final model = await _remote.login(AuthModel.fromEntity(auth));
    return model.toEntity();
  }

  @override
  Future<AuthEntity> refreshToken() async {
    final model = await _remote.refreshToken();
    return model.toEntity();
  }

  @override
  Future<void> logout(AuthEntity auth) async {
    await _remote.logout(AuthModel.fromEntity(auth));
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
}