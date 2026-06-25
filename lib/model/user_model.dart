class UserModel {
  final String dni;
  final String fullName;
  final String email;
  final String token;

  UserModel({
    required this.dni,
    required this.fullName,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      dni: json['dni'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dni': dni,
      'fullName': fullName,
      'email': email,
      'token': token,
    };
  }
}
