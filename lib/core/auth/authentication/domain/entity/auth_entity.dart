class AuthEntity {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? userName;
  final String? dob;
  final String? gender;
  final String? password;
  final String? currentPassword;
  final String? newPassword;
  final String? avatar;
  final bool? isEmailVerified;
  final bool? isActive;
  final String? token;
  final String? otp;

  const AuthEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.dob,
    this.gender,
    this.password,
    this.currentPassword,
    this.newPassword,
    this.avatar,
    this.isEmailVerified,
    this.isActive,
    this.token,
    this.otp,
  });
}
