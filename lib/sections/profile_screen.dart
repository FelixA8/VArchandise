import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences? _sharedPreferences;
  void logOut() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences!.clear();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const CircleAvatar(radius: 70),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Felix Anderson',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'felixanderson@gmail.com',
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: 135,
                        child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            backgroundColor: const Color(0xff7408C2),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Edit Profile',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    backgroundColor: const Color(0xff9C8747),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Gold Member',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                thickness: 1,
              ),
              EditProfileCategories(
                  onTap: () {},
                  description: "",
                  title: "Address",
                  icon: const Icon(FontAwesomeIcons.locationDot),
                  keyword: "",
                  showArrow: true),
              EditProfileCategories(
                  onTap: () {},
                  description: "",
                  title: "Clear History",
                  icon: const Icon(FontAwesomeIcons.trashCan),
                  keyword: "",
                  showArrow: true),
              EditProfileCategories(
                  onTap: () {},
                  description: "",
                  title: "Change Theme",
                  icon: const Icon(FontAwesomeIcons.yinYang),
                  keyword: "",
                  showArrow: true),
              EditProfileCategories(
                  onTap: () {},
                  description: "",
                  title: "About Us",
                  icon: const Icon(FontAwesomeIcons.info),
                  keyword: "",
                  showArrow: true),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                thickness: 1,
              ),
              EditProfileCategories(
                  onTap: () {
                    logOut();
                  },
                  description: "",
                  title: "Log Out",
                  icon: const Icon(Icons.exit_to_app),
                  keyword: "",
                  showArrow: false),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileCategories extends StatelessWidget {
  const EditProfileCategories({
    super.key,
    required this.description,
    required this.title,
    required this.icon,
    required this.keyword,
    required this.showArrow,
    required this.onTap,
  });
  final Icon icon;
  final String description;
  final String title;
  final String keyword;
  final bool showArrow;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: icon,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 11,
              child: Text(
                title,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            const Spacer(),
            Expanded(
                flex: 1,
                child: showArrow
                    ? const Icon(
                        FontAwesomeIcons.angleRight,
                        size: 20,
                      )
                    : Container()),
          ],
        ),
      ),
    );
  }
}
