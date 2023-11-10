import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/rest/rest_login_api.dart';
import 'package:varchandise/screens/home_screen.dart';
import 'package:varchandise/screens/register_data_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool rememberBool = false;
  SharedPreferences? _sharedPreferences;
  var _enteredEmail = '';
  var _enteredPassword = '';

  void changeScreenToHomeScreen(res) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(res: res),
      ),
    );
  }

  void validate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await doLogin(_enteredEmail, _enteredPassword);
    }
  }

  void changeToSignInScreen() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const RegisterDataScreen();
      },
    ));
  }

  doLogin(String email, String password) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var res = await userLogin(email.trim(), password.trim());
    if (res["success"]) {
      var userEmail = res['user'][0]['CustomerEmail'];
      String customerID = res['user'][0]['CustomerID'].toString();
      _sharedPreferences!.setString('customerID', customerID);
      _sharedPreferences!.setString('usermail', userEmail);
      _sharedPreferences!.setString('password', password);

      changeScreenToHomeScreen(res);
    } else if (res["success"] == false) {
      print("WRONG PASSWORD");
    }
  }

  @override
  Widget build(BuildContext context) {
    const loginformtextdecoration = InputDecoration(
      labelText: 'email',
      contentPadding: EdgeInsets.only(top: 10, left: 8),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Color(0xff7408C2)),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xff7408C2),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 359,
                  height: 577,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      ),
                      color: Colors.white),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 88,
                      ),
                      Image.asset('images/varchandise_logo.png'),
                      const SizedBox(
                        height: 58,
                      ),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                onSaved: (newValue) {
                                  _enteredEmail = newValue!;
                                },
                                decoration: loginformtextdecoration,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff7408C2)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.name,
                                  obscureText: true,
                                  onSaved: (newValue) {
                                    _enteredPassword = newValue!;
                                  },
                                  decoration: loginformtextdecoration.copyWith(
                                      labelText: 'password'))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                activeColor: const Color(0xff7408C2),
                                value: rememberBool,
                                onChanged: (value) {
                                  setState(() {
                                    rememberBool = !rememberBool;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Remember me',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff8A8A8A), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 65,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        child: SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: const Color(0xff7408C2),
                            ),
                            onPressed: validate,
                            child: Text(
                              'Log In',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Text(
                  'Or login using?',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('images/google.jpg'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('images/facebook.jpg'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\' have an account? ',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        changeToSignInScreen();
                      },
                      child: Text(
                        'Sign up here!!',
                        style: GoogleFonts.poppins(
                          color: const Color(0xffFFC107),
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
