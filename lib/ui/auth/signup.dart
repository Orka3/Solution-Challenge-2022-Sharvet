import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../../component/InputForm.dart';
import '../../methods/toast.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({this.choice});

  final choice;

  @override
  _SignUpPageState createState() => _SignUpPageState(choice: choice);
}

class _SignUpPageState extends State<SignUpPage> {
  _SignUpPageState({this.choice});

  final choice;
  static Color mainColor = const Color(0xff00C776);

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController NameInputController = TextEditingController();
  TextEditingController IDInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController confirmPasswordInputController =
      TextEditingController();
  TextEditingController contactInputController = TextEditingController();
  TextEditingController businessnameInputController = TextEditingController();
  TextEditingController addressInputController = TextEditingController();
  bool _loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
  }

  Widget _loadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _formWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(196, 135, 198, .3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: buildInput("name*", NameInputController)),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(child: buildInput("ID*", IDInputController))
                      ],
                    ),
                    buildInput("Email*", emailInputController),
                    buildInput("Password*", passwordInputController),
                    buildInput(
                        "Confirm password*", confirmPasswordInputController),
                    buildInput("business name", businessnameInputController),
                    buildInput("business address*", addressInputController),
                    buildInput("contact*", contactInputController),
                    SignInButtonBuilder(
                      padding: EdgeInsets.only(left: 28),
                      text: 'Sign up with Email',
                      icon: Icons.email,
                      backgroundColor: mainColor,
                      onPressed: () async {
                        if (passwordInputController.text !=
                            confirmPasswordInputController.text) {
                          toastError(
                              _scaffoldKey,
                              PlatformException(
                                  code: 'signup',
                                  message:
                                      'Please check your password again.'));
                          return;
                        }
                        try {
                          setState(() => _loading = true);
                          final r = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailInputController.text,
                                  password: passwordInputController.text);

                          await r.user?.reload();
                          updateUserData(r.user?.uid,
                              choice,
                              IDInputController.text,
                              emailInputController.text,
                              NameInputController.text,
                              contactInputController.text,
                              addressInputController.text,
                              businessnameInputController.text,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        } catch (e) {
                          toastError(_scaffoldKey, e);
                          print(e);
                        } finally {
                          if (mounted) setState(() => _loading = false);
                        }
                      },
                    ),
                    Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text("Sign in"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Welcome, $choice!",
          style: const TextStyle(fontSize: 30, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: _loading ? _loadingWidget() : _formWidget()),
          ],
        ),
      ),
    );
  }

  Future updateUserData(uid,choice,id,email,name,contact,baddress,bname) async {
    fireStore.collection('users').doc(uid).set({
      'job':choice,
      'id': id,
      'name' :name,
      'email':email,
      'contact':contact,
      'bname':bname,
      'baddress':baddress,
      'rank': 'bronze',
      'mileage': 0
    });
  }
}
