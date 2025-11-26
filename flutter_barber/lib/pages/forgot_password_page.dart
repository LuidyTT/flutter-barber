// ignore_for_file: unused_import, library_private_types_in_public_api, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barber/widgets/button_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = '';
  final _emailKey = GlobalKey<FormState>();

  // Cores consistentes com a AuthPage
  final Color _primaryColor = const Color(0xff6C63FF);
  final Color _secondaryColor = const Color(0xff4A90E2);
  final Color _lightBackground = const Color(0xffF8F9FA);
  final Color _darkBackground = const Color(0xff1A1D21);
  final Color _textLight = const Color(0xff2D3748);
  final Color _textDark = const Color(0xffE2E8F0);
  final Color _hintColor = const Color(0xffA0AEC0);
  final Color _cardLight = Colors.white;
  final Color _cardDark = const Color(0xff2D3748);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [_darkBackground, _darkBackground.withOpacity(0.95)],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [_lightBackground, Colors.white],
                ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),

                // Back Button
                _buildBackButton(size, isDarkMode, context),
                SizedBox(height: size.height * 0.05),

                // Header
                _buildHeader(size, isDarkMode),
                SizedBox(height: size.height * 0.03),

                // Description
                _buildDescription(size, isDarkMode),
                SizedBox(height: size.height * 0.04),

                // Email Field
                _buildEmailField(size, isDarkMode),
                SizedBox(height: size.height * 0.04),

                // Send Button
                _buildSendButton(size, isDarkMode),
                SizedBox(height: size.height * 0.06),

                // Logo
                _buildLogo(size, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(Size size, bool isDarkMode, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(size.width * 0.02),
        decoration: BoxDecoration(
          color: isDarkMode ? _cardDark : _cardLight,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: isDarkMode ? _textDark : _textLight,
          size: size.height * 0.022,
        ),
      ),
    );
  }

  Widget _buildHeader(Size size, bool isDarkMode) {
    return Text(
      'Reset Password',
      style: GoogleFonts.poppins(
        color: isDarkMode ? _textDark : _textLight,
        fontSize: size.height * 0.032,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildDescription(Size size, bool isDarkMode) {
    return Text(
      "Don't worry! Just enter your email address below and we'll send you a link to reset your password.",
      style: GoogleFonts.poppins(
        color: isDarkMode
            ? _textDark.withOpacity(0.7)
            : _textLight.withOpacity(0.7),
        fontSize: size.height * 0.016,
        height: 1.5,
      ),
    );
  }

  Widget _buildEmailField(Size size, bool isDarkMode) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? _cardDark : _cardLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Form(
          key: _emailKey,
          child: TextFormField(
            style: GoogleFonts.poppins(
              color: isDarkMode ? _textDark : _textLight,
              fontSize: size.height * 0.016,
            ),
            onChanged: (value) => setState(() => email = value),
            validator: (valuemail) {
              if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              ).hasMatch(valuemail!)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              border: InputBorder.none,
              hintText: "Enter your email",
              hintStyle: TextStyle(color: _hintColor),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: _primaryColor,
                size: size.height * 0.025,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton(Size size, bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primaryColor, _secondaryColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextButton(
            onPressed: () {
              if (_emailKey.currentState!.validate()) {
                print('Password reset sent to: $email');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reset link sent to $email'),
                    backgroundColor: _primaryColor,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Send Reset Link',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: size.height * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Size size, bool isDarkMode) {
    return Column(
      children: [
        Container(
          height: 1,
          width: size.width * 0.3,
          color: isDarkMode
              ? _hintColor.withOpacity(0.3)
              : _hintColor.withOpacity(0.2),
        ),
        SizedBox(height: size.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '+',
              style: GoogleFonts.poppins(
                color: const Color(0xffFF6584),
                fontSize: size.height * 0.035,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
