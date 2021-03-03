import 'package:epilappsy_web/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: _loginCard(),
      ),
    );
  }

  Widget _loginCard() => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          width: double.infinity,
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "EPILAPPSY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "E-mail",
                        ),
                        validator: _emailValidator,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(64),
                        ],
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: _obscureIcon(),
                        ),
                        obscureText: _obscurePassword,
                        validator: _passwordValidator,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(64),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              _loginButton(),
            ],
          ),
        ),
      );

  Widget _obscureIcon() => IconButton(
        icon: Icon(
          // Based on passwordVisible state choose the icon
          _obscurePassword ? Icons.visibility : Icons.visibility_off,
          color: _obscurePassword
              ? Colors.grey
              : Theme.of(context).primaryColorDark,
        ),
        onPressed: () {
          // Update the state i.e. toogle the state of passwordVisible variable
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      );

  Widget _loginButton() => IgnorePointer(
        ignoring: _isLoging,
        child: TextButton(
          style: TextButton.styleFrom(shape: RoundedRectangleBorder()),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            width: double.infinity,
            height: 48,
            child: _isLoging
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text("Login"),
          ),
          onPressed: _login,
        ),
      );

  String _emailValidator(String text) {
    final String email = text.trim();
    if (email.isEmpty) return "E-mail is empty";
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) return "Invalid e-mail address";
    return null;
  }

  String _passwordValidator(String text) {
    final String password = text.trim();
    if (password.isEmpty) return "Password is empty";
    return null;
  }

  Future<void> _login() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoging = true;
      });
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      Database.login(
        email,
        password,
        onError: (_) {
          if (mounted) {
            setState(() {
              _isLoging = false;
            });
          }
        },
      );
    }
  }
}
