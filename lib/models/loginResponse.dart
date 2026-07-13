class LoginResponse {
  final int idUtente;
  final String username;

  LoginResponse({
    required this.idUtente,
    required this.username,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      idUtente: json["idUtente"],
      username: json["username"],
    );
  }
}
