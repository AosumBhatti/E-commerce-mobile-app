import 'package:firstapp/screens/homePage.dart';
import 'package:firstapp/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/widgets/widgets.dart';
import 'package:firstapp/widgets/inputwidget.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmail,
        password: _loginPassword,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No Account with that Email Please SignUp First!';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect Password';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _loginPageLoading = true;
    });
    String _loginAccountFeedback = await _loginAccount();
    if (_loginAccountFeedback != null) {
      _alertDialogBuilder(_loginAccountFeedback);
      setState(() {
        _loginPageLoading = false;
      });
    }
  }

  bool _loginPageLoading = false;
  String _loginEmail = '';
  String _loginPassword = '';
  // Focus node for input fields
  FocusNode _passwordFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode = FocusNode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 24.0),
              child: Text('Welcome User \nLogin To Your Account',
                  textAlign: TextAlign.center,
                  style: Constant.boldRegularHeadings),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: 'Email',
                  onChanged: (value) {
                    _loginEmail = value;
                  },
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  hintText: 'Password',
                  onChanged: (value) {
                    _loginPassword = value;
                  },
                  onSubmitted: (value) {
                    _submitForm();
                  },
                  isPassword: true,
                  focusNode: _passwordFocusNode,
                ),
                CustomBtn(
                  text: 'Login',
                  onPressed: () {
                    _submitForm();
                  },
                  isLoading: _loginPageLoading,
                  outline: false,
                ),
              ],
            ),
            CustomBtn(
              text: "Create New Account",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              outline: true,
            ),
          ],
        )),
      ),
    );
  }
}
