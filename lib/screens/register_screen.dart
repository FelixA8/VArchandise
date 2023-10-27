import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showPassword = true;
  bool showConfirmedPassword = true;
  final formKey = GlobalKey<FormState>();

  void changePasswordState() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void changeConfirmedPasswordState() {
    setState(() {
      showConfirmedPassword = !showConfirmedPassword;
    });
  }

  void goToLoginScreen() {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ > 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset('images/varchandise_logo2.jpg'),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        style:
                            GoogleFonts.poppins(color: const Color(0xff7408C2)),
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        obscureText: showPassword,
                        style:
                            GoogleFonts.poppins(color: const Color(0xff7408C2)),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: changePasswordState,
                                icon: Icon(showPassword
                                    ? Icons.remove_red_eye
                                    : FontAwesomeIcons.eyeSlash)),
                            labelText: 'Password'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        obscureText: showConfirmedPassword,
                        style:
                            GoogleFonts.poppins(color: const Color(0xff7408C2)),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: changeConfirmedPasswordState,
                                icon: Icon(showConfirmedPassword
                                    ? Icons.remove_red_eye
                                    : FontAwesomeIcons.eyeSlash)),
                            labelText: 'Confirm Password'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff7408C2)),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              side: BorderSide(
                                width: 1,
                                color: Color(0xff7408C2),
                              ),
                            ),
                          ),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffffffff)),
                        ),
                        onPressed: goToLoginScreen,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 65, vertical: 10),
                          child: Text(
                            'Back',
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: const Color(0xff7408C2)),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
