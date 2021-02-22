import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String username;
  final String updatedAt;
  final String firstname;
  final String lastname;

  User(this.id, this.name, this.email, this.username, this.firstname,
      this.lastname, this.updatedAt);

  User.fromJson(Map<String, dynamic> json)
      : id = json['sub'],
        email = json['email'],
        name = json['name'],
        username = json['preferred_username'],
        updatedAt = json['updated_at'],
        firstname = json['given_name'],
        lastname = json['family_name'];

  Map<String, dynamic> toJson() => {
        'sub': id,
        'name': name,
        'email': email,
        'preferred_username': username,
        'updated_at': updatedAt,
        'given_name': firstname,
        'family_name': lastname,
      };
}
