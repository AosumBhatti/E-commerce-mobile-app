import 'package:firstapp/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/widgets/widgets.dart';
import 'package:firstapp/widgets/inputwidget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _registerEmail,
        password: _registerPassword,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Password is too Short.';
      } else if (e.code == 'email-already-in-use') {
        return 'The email is already in use please try a differient one!';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _registerPageLoading = true;
    });
    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
      setState(() {
        _registerPageLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerPageLoading = false;
  String _registerEmail = '';
  String _registerPassword = '';
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
              child: Text('Create a New Account',
                  textAlign: TextAlign.center,
                  style: Constant.boldRegularHeadings),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: 'Email',
                  onChanged: (value) {
                    _registerEmail = value;
                  },
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  hintText: 'Password',
                  onChanged: (value) {
                    _registerPassword = value;
                  },
                  onSubmitted: (value) {
                    _submitForm();
                  },
                  isPassword: true,
                  focusNode: _passwordFocusNode,
                ),
                CustomBtn(
                  text: 'Register',
                  onPressed: () {
                    _submitForm();
                  },
                  isLoading: _registerPageLoading,
                  outline: false,
                ),
              ],
            ),
            CustomBtn(
              text: "Already Have an account? Login",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => loginPage()));
              },
              outline: true,
            ),
          ],
        )),
      ),
    );
  }
}
