import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/model/login_model.dart';
import 'package:gdscsolution/ui/auth/chooseSignup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPagState createState() => _LoginPagState();
}

class _LoginPagState extends State<LoginPage>{
  String _id = '';
  String _pw = '';
  late SharedPreferences _prefs;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late FirebaseAuthService _auth;
  static Color mainColor = const Color(0xff00C776);
  late String job;


  @override
  void initState(){
    super.initState();
    _loadId();
  }

  _loadId() async{
    _prefs = await SharedPreferences.getInstance(); // 캐시에 저장되어있는 값을 불러온다.
    setState(() { // 캐시에 저장된 값을 반영하여 현재 상태를 설정한다.
      // SharedPreferences에 id, pw로 저장된 값을 읽어 필드에 저장. 없을 경우 0으로 대입
      _id = (_prefs.getString('id') ?? '');
      _pw = (_prefs.getString('pw') ?? '');
      print(_id); // Run 기록으로 id와 pw의 값을 확인할 수 있음.
      print(_pw);
    });
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthService>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: -40,
                      height: 400,
                      width: width,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image/back1.png'),
                                fit: BoxFit.fill)),
                      )),
                  Positioned(
                      height: 400,
                      width: width + 20,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image/back2.png'),
                                fit: BoxFit.fill)),
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Login",
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                        _buildEmailInput(),
                        _buildPasswordInput(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Center(
                      child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildSubmitButton(),

                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChooseSign()));
                      },
                      child: const Center(
                          child: Text(
                        "Create Account",
                        style: TextStyle(fontSize: 18,color: Color.fromRGBO(49, 39, 79, .6)),
                      ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'email',
            hintStyle: TextStyle(color: Colors.grey)),
        controller: _emailController,
        onSaved: (value) => _emailController.text = (value?.trim())!,
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.visiblePassword,
        autocorrect: false,
        obscureText: true,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'password',
            hintStyle: TextStyle(color: Colors.grey)),
        controller: _passwordController,
        onSaved: (value) => _passwordController.text = (value?.trim())!,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () async => _submit(),
      child: Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: mainColor,
          ),
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }

  Future<void> _submit() async {
    final user = await _auth.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
    context.read<FirebaseAuthService>().getUID((user?.uid)!);

    final data = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
    final job = data.data()!['job'];
    context.read<FirebaseAuthService>().getJob(job);


    (user == null)
        ? print('로그인 맞지않습니다!!!!!!!!!!!!!!!!!!!')
        :Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
    _id = _emailController.text;  // _id 에 입력받은 값 넣어줌
    _pw = _passwordController.text;  // _pw 에 입력받은 값 넣어줌
    _prefs.setString('id', _id);  // id를 키로 가지고 있는 값에 입력받은 _id를 넣어줌. = 캐시에 넣어줌
    _prefs.setString('pw', _pw);  // pw를 키로 가지고 있는 값에 입력받은 _pw를 넣어줌. = 캐시에 넣어줌

  }

}
