class SignUpModel {
  String name;
  String email;
  String password;
  String confirmPassword;

  SignUpModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  bool validate() {
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return false;
    }
    if (password.length < 6) {
      return false;
    }
    if (password != confirmPassword) {
      return false;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return false;
    }
    return true;
  }

  Future<bool> signUp() async {
    // Lógica de signup (por exemplo, chamada a uma API)
    return true; // Retorna true se o signup for bem-sucedido
  }
}
