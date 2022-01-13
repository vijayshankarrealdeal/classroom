import 'dart:ui';
import 'package:classroom/widgets/loading_spinner.dart';
import 'package:classroom/widgets/text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:classroom/services/auth.dart';
import 'package:provider/provider.dart';

enum SignOptions { signIn, signUp, forgetPass }

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignOptions _formType = SignOptions.signIn;
  bool isSpin = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String primaryText =
        _formType == SignOptions.signIn ? "Sign In " : "Sign Up";
    final String secondaryText = _formType == SignOptions.signIn
        ? "Need a Account ? Sign Up"
        : "Already Have An Account";
    final auth = Provider.of<Auth>(context);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Classroom',
            style: TextStyle(fontSize: 45),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Container(
            width: double.infinity,
          ),
          FormFeildApp(
            controller: _email,
            placeholder: "Email",
          ),
          //TextForm
          FormFeildApp(
            controller: _password,
            placeholder: "Password",
            hide: true,
          ),
          _formType == SignOptions.signUp
              ? FormFeildApp(
                  controller: _confirmPassword,
                  placeholder: "Confirm Password",
                  hide: true,
                )
              : const Text(''),
          const SizedBox(height: 12.0),
          isSpin
              ? CupertinoButton.filled(
                  child: Text(
                    primaryText,
                    style:const TextStyle(
                      color: CupertinoColors.white,
                    ),
                  ),
                  onPressed: () => submit(_email.text.trim(), _password.text,
                      _confirmPassword.text, auth),
                )
              : loadingSpinner(),
          // CupertinoButton(
          //     padding: EdgeInsets.zero,
          //     child: GenralText(
          //       text: 'Sign In / Sign up with google',
          //       family: 'SF-Pro-Text-Semibold',
          //       color: CupertinoColors.activeBlue,
          //     ),
          //     onPressed: () {
          //       auth.signInWithGoogle();
          //     }),
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(secondaryText),
              onPressed: () {
                setState(() {
                  _formType = _formType == SignOptions.signIn
                      ? SignOptions.signUp
                      : SignOptions.signIn;
                });
                _email.clear();
                _password.clear();
              }),
          _formType == SignOptions.signIn
              ? CupertinoButton(
                  child: const Text("Forgot Password"),
                  onPressed: () => forgetPass(context, auth),
                  padding: const EdgeInsets.only(top: 0.5),
                )
              : const Text(''),
        ],
      ),
    );
  }

  void submit(
    String email,
    String password,
    String confirmPassword,
    Auth auth,
  ) async {
    if (_formType == SignOptions.signIn) {
      try {
        setState(() {
          isSpin = false;
        });
        await auth.signIn(email, password);
      } catch (e) {
        setState(() {
          isSpin = true;
        });
        //  dialog(context, e.message, Provider.of<ColorManager>(context).textH1());
      }
    } else {
      if (password == confirmPassword) {
        try {
          setState(() {
            isSpin = false;
          });
          await auth.signUp(email, password);
        } catch (e) {
          setState(() {
            isSpin = true;
          });
          // dialog(
          //     context, e.message, Provider.of<ColorManager>(context).textH1());
        }
      } else {
        setState(() {
          isSpin = true;
        });
        // dialog(context, 'Password not matched',
        //     Provider.of<ColorManager>(context).textH1());
      }
    }
  }

  void forgetPass(BuildContext context, Auth auth) {
    // ignore: unused_local_variable
    TextEditingController _emailForget = TextEditingController();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Dialog(
            // backgroundColor: Provider.of<ColorManager>(context).scaffoldColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Forgot Password',
                      style: CupertinoTheme.of(context).textTheme.textStyle),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 4.0),
                    child: FormFeildApp(
                      controller: _password,
                      placeholder: "Password",
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  // CupertinoButton(
                  //     color: colorschema.buttonColor(),
                  //     child: GenralText(
                  //         text: 'Submit', color: colorschema.genralText()),
                  //     onPressed: () async {
                  //       try {
                  //         setState(() {
                  //           isSpin = false;
                  //         });
                  //         await auth.forgotPassword(_emailForget.text);
                  //         passwordRestdialog(context,
                  //             'Rest password Link is sent on your email\ncheck your inbox');
                  //         _emailForget.clear();
                  //         setState(() {
                  //           isSpin = true;
                  //         });
                  //       } catch (e) {
                  //         setState(() {
                  //           isSpin = true;
                  //         });
                  //         dialog(context, e.message,
                  //             Provider.of<ColorManager>(context).textH1());
                  //       }
                  //     }),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CupertinoButton(
                    child: const Text(
                      ' Back ',
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
