import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            FontAwesomeIcons.circleChevronLeft,
            color: Colors.black,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: GoogleFonts.poppins()),
                  EditProfileForm(),
                  Text('Name', style: GoogleFonts.poppins()),
                  EditProfileForm(),
                  Text('ProfileImage', style: GoogleFonts.poppins()),
                  EditProfileForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          keyboardType: TextInputType.name,
          onSaved: (newValue) {
            newValue!;
          },
          style: GoogleFonts.poppins(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            fillColor: Colors.white70,
          ),
        ),
      ),
    );
  }
}
