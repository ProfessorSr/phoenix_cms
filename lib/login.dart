import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(
      {Key? key, required TrackingScrollController scrollController})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  bool visible = false;

  final passwordController = TextEditingController();
  final usernameController = TextEditingController()
    ..text = SharedPrefs().remember;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Image.asset('assets/images/salubrity_logo_black.png'),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                //cursorColor: Colors.black,
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                //cursorColor: Colors.black,
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  //enabledBorder: UnderlineInputBorder(
                  //  borderSide: BorderSide(color: Colors.white),
                  // CCF unfocused
                  //),
                  //focusedBorder: UnderlineInputBorder(
                  //  borderSide: BorderSide(color: Colors.black),
                  // CCF focused
                  //),
                  //border: UnderlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Remember Me'),
                ),
                Checkbox(
                  //side: const BorderSide(color: Colors.white),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                      if (value == true) {
                        SharedPrefs().remember = usernameController.text;
                      }
                      if (value == false) {
                        SharedPrefs().remember = '';
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: userLogin,
              child: const Text('Login'),
            ),
            TextButton(
              child: const Text(
                'New User? Create Account',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Scaffold()),
                );
              },
            ),
            TextButton(
              child: const Text(
                'Forgot Password',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Scaffold()),
                );
              },
            ),
            Visibility(
              visible: visible,
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future userLogin() async {
    setState(() {
      visible = true;
    });
    String salted =
        '5fW3DHnWQVEugmjrsVWL8y06u9hlHW9B00fLEO552k4oXdm9lkMy2JuENz';
    String hashedPassword =
        Crypt.sha256(passwordController.text, salt: salted).toString();
    String username = usernameController.text;

    var url = Uri.parse('https://salubrity.website/caredesign/user_login.php');

    var data = {'username': username, 'password': hashedPassword};

    var response = await http.post(url, body: json.encode(data));

    var message = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print(response.statusCode);
      //print(message);
      if (message == 'Invalid Username or Password Please Try Again') {
        setState(
          () {
            visible = false;
          },
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        SharedPrefs().userId = message[0]['userId'];
        SharedPrefs().username = message[0]['username'];
        SharedPrefs().namePrefix = message[0]['namePrefix'];
        SharedPrefs().nameFirst = message[0]['nameFirst'];
        SharedPrefs().nameLast = message[0]['nameLast'];
        SharedPrefs().nameSuffix = message[0]['nameSuffix'];
        SharedPrefs().status = message[0]['status'];

        Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(
            builder: (context) => const Scaffold(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } else {
      setState(() {
        visible = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
