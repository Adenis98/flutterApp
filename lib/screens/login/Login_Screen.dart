import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orbitnetmobileapp/core/services/login.dart';
import 'package:orbitnetmobileapp/screens/allScreens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Hex_Color.dart';

enum FormData {
  User,
  password,
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    final userLogin = userController.text;
    final userPwd = passwordController.text;

    try {
      // Call your login method here
      final loginService = Provider.of<LoginService>(context, listen: false);
      final result = await loginService.login(userLogin, userPwd, context);
      if (result['AuthUserReponse']['AuthUserResultat']['RetMsg'] == "") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'user', jsonEncode(result['AuthUserReponse']['AuthUserResultat']));

        String? user =
            jsonEncode(result['AuthUserReponse']['AuthUserResultat']);
        Map<String, dynamic> json = jsonDecode(user);

        String histVehic = json['HistVehic'];
        String ca = json['CA'];
        String rec = json['REC'];
        String actAt = json['ACT_AT'];

        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomePage(histVehic:histVehic, ca: ca, rec: rec, actAt: actAt);
        }));
      }
    } catch (e) {
      // Handle any errors (e.g., network issues, invalid credentials)
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [
              HexColor("#4b4293").withOpacity(0.8),
              HexColor("#4b4293"),
              HexColor("#08418e"),
              HexColor("#08418e")
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color:
                      const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Please sign in to continue",
                          style: TextStyle(
                              color: Colors.white, letterSpacing: 0.5),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: selected == FormData.User
                                ? enabled
                                : backgroundColor,
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            controller: userController,
                            onTap: () {
                              setState(() {
                                selected = FormData.User;
                              });
                            },
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: selected == FormData.User
                                    ? enabledtxt
                                    : deaible,
                                size: 20,
                              ),
                              hintText: 'User',
                              hintStyle: TextStyle(
                                  color: selected == FormData.User
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 12),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.User
                                    ? enabledtxt
                                    : deaible,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.password
                                  ? enabled
                                  : backgroundColor),
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            controller: passwordController,
                            onTap: () {
                              setState(() {
                                selected = FormData.password;
                              });
                            },
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock_open_outlined,
                                  color: selected == FormData.password
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  icon: ispasswordev
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: selected == FormData.password
                                              ? enabledtxt
                                              : deaible,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: selected == FormData.password
                                              ? enabledtxt
                                              : deaible,
                                          size: 20,
                                        ),
                                  onPressed: () => setState(
                                      () => ispasswordev = !ispasswordev),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: selected == FormData.password
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12)),
                            obscureText: ispasswordev,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.password
                                    ? enabledtxt
                                    : deaible,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              _handleLogin();
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF2697FF),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14.0, horizontal: 80),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0))),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
