class User {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? registerNum;
  final String? walletNum;
  final int? walletValue;
  final String? driverId;
  final int? bankId;
  final String? bankName;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.registerNum,
    this.walletNum,
    this.walletValue,
    this.driverId,
    this.bankId,
    this.bankName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      firstName: json['F_name'],
      lastName: json['L_name'],
      phone: json['phone'],
      email: json['e_mail'],
      registerNum: json['register_num'],
      walletNum: json['wallet_num'],
      walletValue: json['wallet_value'],
      driverId: json['driver_id'],
      bankId: json['bank_id'],
      bankName: json['bank_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'F_name': firstName,
      'L_name': lastName,
      'phone': phone,
      'e_mail': email,
      'register_num': registerNum,
      'wallet_num': walletNum,
      'wallet_value': walletValue,
      'driver_id': driverId,
      'bank_id': bankId,
      'bank_name': bankName,
    };
  }
}
