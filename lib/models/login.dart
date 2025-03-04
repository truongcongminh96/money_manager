class Login {
  final String userName;
  final String password;

  //<editor-fold desc="Data Methods">
  const Login({required this.userName, required this.password});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Login &&
          runtimeType == other.runtimeType &&
          userName == other.userName &&
          password == other.password);

  @override
  int get hashCode => userName.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'Login{' + ' userName: $userName,' + ' password: $password,' + '}';
  }

  Login copyWith({String? userName, String? password}) {
    return Login(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {'userName': this.userName, 'password': this.password};
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      userName: map['userName'] as String,
      password: map['password'] as String,
    );
  }

  //</editor-fold>
}
