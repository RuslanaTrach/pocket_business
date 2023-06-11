import 'dart:convert';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/foundation.dart';


import 'package:http/http.dart' as http;

enum SocialConnection {
  google('google-oauth2'),
  email('Username-Password-Authentication');

  final String getName;

  const SocialConnection(this.getName);
}

class AuthenticationWithSocialConnections
    extends AuthenticationService<Credentials> {
  SocialConnection get connection {
    throw UnimplementedError('connection getter must be implemented');
  }

  @override
  Future<Credentials> signIn() async {
    try {


                Credentials response =await auth0.webAuthentication(scheme: 'demo').login(
              parameters: {
                'connection': connection.getName,
              } //, 'scope':"openid"},
          );

            if (kDebugMode) {
              print(response.idToken);

              print(response.user.toString());
              print(response.user.email);
            }
            return response;

    } catch (e) {
      if (!kReleaseMode) {
        debugPrint(e.toString());
      }
      throw Exception();
    }
  }

  Future<String> signUp(String email) async {
    try {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      var response = await http.post(
          Uri.parse(
              'https://dev-s8m3mg8ibtuewaan.us.auth0.com/passwordless/start'),
          body: {
            'client_id': 'X4ZUOs1c0Tf38snx5uPAJcia9ShgJtZI',
            'connection': 'email',
            'email': email,
            'send': 'code'
          },
          headers: headers);

      if (kDebugMode) {
        print(response);
      }
      return response.body;
    } catch (e) {
      if (!kReleaseMode) {}
      throw Exception();
    }
  }

  Future<String> sendCode(String code, String email) async {
    try {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      print(code);
      var response = await http.post(
          Uri.parse('https://dev-s8m3mg8ibtuewaan.us.auth0.com/oauth/token'),
          body: {
            'client_id': 'X4ZUOs1c0Tf38snx5uPAJcia9ShgJtZI',
            'grant_type': 'http://auth0.com/oauth/grant-type/passwordless/otp',
            'otp': code,
            'realm': 'email',
            'username': email
          },
          headers: headers);

      if (kDebugMode) {
        print(response);
      }
      print(response.body.toString());
      return response.body;
    } catch (e) {
      if (!kReleaseMode) {}
      throw Exception();
    }
  }

  @override
  Future<void> signOut() async {
    await auth0.webAuthentication(scheme: 'demo').logout();
  }
}

abstract class AuthenticationService<T> {
  Auth0 auth0 = Auth0(
      "dev-s8m3mg8ibtuewaan.us.auth0.com", "X4ZUOs1c0Tf38snx5uPAJcia9ShgJtZI");


  Future<T> signIn();

  Future<void> signOut();
}

class SignInWithEmail extends AuthenticationWithSocialConnections {
  @override
  SocialConnection get connection => SocialConnection.email;
}

class SignInWithGoogle extends AuthenticationWithSocialConnections {
  @override
  SocialConnection get connection => SocialConnection.google;
}
