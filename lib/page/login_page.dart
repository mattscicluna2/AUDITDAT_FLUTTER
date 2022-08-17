import 'package:auditdat/common/utilities.dart';
import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/user.dart';
import 'package:auditdat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  late FToast fToast = FToast();

  @override
  void initState() {
    super.initState();

    fToast.init(context);
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            controller: txtEmail,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: ColorConstants.secondary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: ColorConstants.primary,
                ),
              ),
              labelText: 'Username / Email',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.email),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            controller: txtPassword,
            obscureText: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: ColorConstants.secondary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: ColorConstants.primary,
                ),
              ),
              labelText: 'Password',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.lock),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: EdgeInsets.all(15),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          primary: Colors.white,
          onPrimary: ColorConstants.secondary,
        ),
        onPressed: login,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: ColorConstants.primary,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app_logo_white.png'),
          // fit: BoxFit.cover,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.15,
      // height: 50,
    );
  }

  Widget _buildUpdatLogo() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/updat_logo_purple.png'),
          // fit: BoxFit.cover,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.05,
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Future<void> login() async {
    String email = txtEmail.text;
    String password = txtPassword.text;

    if (await Utilities.hasInternet()) {
      Map<String, dynamic> response =
      await AuthService.instance.authenticate(email, password);
      dynamic token = response['token'];
      dynamic user = response['user'];

      if (token != null && user != null) {
        User _user = User.fromJson(user);
        AuthService.instance.login(_user, token);

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      } else {
        Utilities.showToast(
            context: context,
            message: 'Login Failed',
            icon: FontAwesomeIcons.exclamation,
            backgroundColor: ColorConstants.danger,
            toastGravity: ToastGravity.BOTTOM);
      }
    } else {
      Utilities.showToast(
          context: context,
          message: 'An internet connection is required to perform this action.',
          icon: FontAwesomeIcons.exclamation,
          backgroundColor: ColorConstants.danger,
          toastGravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildAppLogo(),
                      SizedBox(height: 15.0),
                      Text(
                        'AuditDAT',
                        style: TextStyle(
                          color: Color.fromRGBO(94, 44, 237, 1),
                          fontFamily: 'OpenSans',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 25.0),
                      _buildEmailTF(),
                      SizedBox(height: 15.0),
                      _buildPasswordTF(),
                      _buildLoginBtn(),
                      SizedBox(height: 25.0),
                      _buildUpdatLogo(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
