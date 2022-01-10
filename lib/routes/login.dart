import 'dart:ui';
import 'package:classroom/controllers/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:classroom/services/auth.dart';
import 'package:provider/provider.dart';

const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);
enum SignOptions { signIn, signUp, forgetPass }

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignOptions _formType = SignOptions.signIn;
  bool isSpin = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String primaryText =
        _formType == SignOptions.signIn ? "Sign In " : "Sign Up";
    final String secondaryText = _formType == SignOptions.signIn
        ? "Need a Account ? Sign Up"
        : "Already Have An Account";
    final auth = Provider.of<Auth>(context);
    final font = Provider.of<TypoGraphyOfApp>(context);

    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          font.heading2(
              "Classroom", Theme.of(context).textTheme.headline2!.color!),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Container(
            width: double.infinity,
          ),
          //TextForm
          SizedBox(height: 8.0),
          //TextForm
          SizedBox(height: 8.0),
          // _formType == SignOptions.signUp
          //     ? TextForms(
          //         isspin: isSpin,
          //         enter: _confirmPassword,
          //         placeholder: "Confirm Password",
          //         hide: true,
          //       )
          //     : Text(''),
          SizedBox(height: 15.0),
          // isSpin
          //     ? CupertinoButton(
          //         color: colorschema.buttonColor(),
          //         child: GenralText(
          //           text: primaryText,
          //           color: colorschema.genralText(),
          //         ),
          //         onPressed: () => submit(_email.text.trim(), _password.text,
          //             _confirmPassword.text, auth, _ana),
          //       )
          //     : LoadingSpinner(size: 5),
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
          // CupertinoButton(
          //     padding: EdgeInsets.zero,
          //     child: GenralText(
          //       text: secondaryText,
          //       family: 'SF-Pro-Text-Semibold',
          //       color: CupertinoColors.activeBlue,
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         _formType = _formType == SignOptions.signIn
          //             ? SignOptions.signUp
          //             : SignOptions.signIn;
          //       });
          //       _email.clear();
          //       _password.clear();
          //     }),
          // _formType == SignOptions.signIn
          //     ? CupertinoButton(
          //         child: Text(
          //           'Forget Password',
          //           style: TextStyle(
          //               fontFamily: 'SF-Pro-Text-Regular',
          //               color: CupertinoColors.systemGrey),
          //         ),
          //         onPressed: () => forgetPass(context, auth, colorschema),
          //         padding: EdgeInsets.only(top: 0.5),
          //       )
          //     : Text(''),
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
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // HeadingText(
                  //   text: 'Forget Password',
                  // ),
                  SizedBox(height: 15.0),
                  // TextForms(
                  //   isspin: isSpin,
                  //   enter: _emailForget,
                  //   placeholder: 'Email Address',
                  //   hide: false,
                  // ),
                  SizedBox(height: 30.0),
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
                  SizedBox(
                    height: 8.0,
                  ),
                  CupertinoButton(
                    child: Text(
                      ' Back ',
                      style: TextStyle(color: CupertinoColors.activeBlue),
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
