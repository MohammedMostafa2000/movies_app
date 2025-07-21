class UserDataModel {
  final String? name;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? phone;
  final int? avatarId;

  UserDataModel({
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.phone,
    this.avatarId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
      'avaterId': avatarId,
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      avatarId: json['avaterId'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      phone: json['phone'],
    );
  }
}
