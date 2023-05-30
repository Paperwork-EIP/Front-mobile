import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:paperwork/home/view/Header.dart';
import 'package:paperwork/profile/profile.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  const email = 'test@test.test';
  const headers = {
    "Content-Type": "application/json",
  };
  const url = 'http://54.86.209.237:8080';
  const newEmail = 'test2@test.test';
  const newUsername = 'Sandros';
  const newPassword = 'test';
  const newPicture = 'https://static.jobat.be/uploadedImages/grandprofilfb.jpg';
  group('ModifyData', () {
    test('fromJson', () {
      final Map<String, dynamic> json = {
        'message': 'Hello World',
        'appoinment': 'meeting'
      };

      final calendar = ModifyProfile.fromJson(json);

      expect(calendar.message, equals('Hello World'));
    });
    test('should return a valid response data', () async {
      final response = await http.get(
        Uri.parse(
            "$url/user//modifyDatas?token=$email&username=$newUsername&new_email=$newEmail&password=$newPassword&profile_picture=$newPicture"),
        headers: headers,
      );
      final result = json.decode(response.body);

      expect(result, isNotNull);
    });

    test('should throw an exception when invalid email is passed', () async {
      const invalidEmail = 'invalid@example';

      expect(
          () => setModifyUser(
              token: "azertyuytfdsdrftyytrezzerty",
              newEmail: newEmail,
              newUsername: newUsername,
              newPassword: newPassword,
              profilePicture: newPicture),
          throwsException);
    });
  });
}
