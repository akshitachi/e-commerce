import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/http_exception.dart';
import '../widgets/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: AuthCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Signup;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured'),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).logIn(
          _authData['email'],
          _authData['password'],
        );

        // Log user in
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signUP(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication error';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _authMode == AuthMode.Signup
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Register to get started',
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Log in to get started',
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
          Text(
            'Experience the all new App!',
            style: TextStyle(
              color: Color(0xff707070),
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _authMode == AuthMode.Signup
                        ? TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'assets/user/person-24px (1).png',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                labelText: 'Name'),
                            keyboardType: TextInputType.name,
                            onSaved: (value) {
                              _authData['name'] = value;
                            },
                          )
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/user/email-24px.png',
                              width: 10,
                              height: 10,
                              fit: BoxFit.fill,
                            ),
                          ),
                          labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _authMode == AuthMode.Signup
                        ? TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'assets/user/phone-24px.png',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                labelText: 'Mobile Number'),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.length < 10 ||
                                  value.length > 10) {
                                return 'Invalid phone number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['mobileno'] = value;
                            },
                          )
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/user/lock.png',
                            width: 10,
                            height: 10,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      obscureText: !_passwordVisible,
                      controller: _passwordController,
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Password is too short!';
                        }
                      },
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                  ),
                  if (_authMode == AuthMode.Signup)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/user/lock.png',
                              width: 10,
                              height: 10,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        obscureText: !_passwordVisible,
                        controller: _confirmPasswordController,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                              }
                            : null,
                      ),
                    ),
                  _authMode == AuthMode.Login
                      ? FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Use Mobile Number",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    _authMode == AuthMode.Signup
                        ? SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: RaisedButton(
                              child: Text(
                                'REGISTER',
                                style: TextStyle(),
                              ),
                              onPressed: _submit,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Color(0xffF3AA4E),
                              textColor: Colors.white,
                            ),
                          )
                        : Text(''),
                  FlatButton(
                    child: _authMode == AuthMode.Signup
                        ? RichText(
                            text: TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 18,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _switchAuthMode,
                                )
                              ],
                            ),
                          )
                        : null,
                    onPressed: _switchAuthMode,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Colors.black,
                  ),
                  _authMode == AuthMode.Login
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: RaisedButton(
                              child: Text(
                                'Login',
                                style: TextStyle(),
                              ),
                              onPressed: _submit,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Color(0xffF3AA4E),
                              textColor: Colors.white,
                            ),
                          ),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
