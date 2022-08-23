// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserAccount {
  final String name;
  final String email;
  final String phoneNumber;
  final String token;
  final List cart;

  UserAccount({
    required this.token,
    required this.name,
    required this.email,
    required this.cart,
    required this.phoneNumber,
  });

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
      name: map['name'] as String,
      token: map['token'] as String,
      email: map['email'] as String,
      phoneNumber: map['phone'] as String,
      cart: map['cart'] as List,
    );
  }

  factory UserAccount.fromJson(String source) => UserAccount.fromMap(json.decode(source) as Map<String, dynamic>);
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'token': token,
      'cart': cart,
    };
  }

  String toJson() => json.encode(toMap());
}
