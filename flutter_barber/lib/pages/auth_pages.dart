// ignore_for_file: unused_import, library_private_types_in_public_api, deprecated_member_use, avoid_print, unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_barber/service/user_service.dart' show UserService;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barber/pages/forgot_password_page.dart';
import 'package:flutter_barber/pages/home_page.dart';
import 'package:flutter_barber/widgets/button_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool checkedValue = false;
  bool register = true;
  bool pwVisible = false;
  bool _isLoading = false;

  List<String> textfieldsStrings = ["", "", "", "", ""];

  final _firstnamekey = GlobalKey<FormState>();
  final _lastNamekey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();

  // Cores harmoniosas
  final Color _primaryColor = const Color(0xff6C63FF);
  final Color _secondaryColor = const Color(0xff4A90E2);
  final Color _accentColor = const Color(0xffFF6584);
  final Color _lightBackground = const Color(0xffF8F9FA);
  final Color _darkBackground = const Color(0xff1A1D21);
  final Color _textLight = const Color(0xff2D3748);
  final Color _textDark = const Color(0xffE2E8F0);
  final Color _hintColor = const Color(0xffA0AEC0);
  final Color _cardLight = Colors.white;
  final Color _cardDark = const Color(0xff2D3748);

  // Na AuthPage, atualize a função _authenticate:
  Future<void> _authenticate() async {
    setState(() {
      _isLoading = true;
    });

    // Simular delay de rede
    await Future.delayed(const Duration(seconds: 2));

    // Salvar dados do usuário se for cadastro
    if (register) {
      await UserService.saveUserData(
        firstName: textfieldsStrings[0], // First Name
        lastName: textfieldsStrings[1], // Last Name
        email: textfieldsStrings[2], // Email
      );
    }

    setState(() {
      _isLoading = false;
    });

    // Navegar para a HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

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
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),

                // Header Card
                _buildHeaderCard(size, isDarkMode),
                SizedBox(height: size.height * 0.03),

                // Form Card
                _buildFormCard(size, isDarkMode),
                SizedBox(height: size.height * 0.03),

                // Footer
                _buildFooter(size, isDarkMode),
                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(Size size, bool isDarkMode) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? _cardDark.withOpacity(0.8) : _cardLight,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(size.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey there,',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight.withOpacity(0.7),
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: size.height * 0.008),
            Text(
              register ? 'Create an Account' : 'Welcome Back',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(Size size, bool isDarkMode) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? _cardDark.withOpacity(0.8) : _cardLight,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(size.width * 0.06),
        child: Column(
          children: [
            // Form Fields
            _buildFormFields(size, isDarkMode),
            SizedBox(height: size.height * 0.025),

            // Terms or Forgot Password
            _buildTermsOrForgot(size, isDarkMode),
            SizedBox(height: size.height * 0.025),

            // Action Button
            _buildActionButton(size, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(Size size, bool isDarkMode) {
    return Column(
      children: [
        if (register) ...[
          _buildTextField(
            "First Name",
            Icons.person_outline,
            false,
            size,
            (valuename) {
              if (valuename.length <= 2) {
                return 'Name must be at least 3 characters';
              }
              return null;
            },
            _firstnamekey,
            0,
            isDarkMode,
          ),
          SizedBox(height: size.height * 0.018),
          _buildTextField(
            "Last Name",
            Icons.person_outline,
            false,
            size,
            (valuesurname) {
              if (valuesurname.length <= 2) {
                return 'Last name must be at least 3 characters';
              }
              return null;
            },
            _lastNamekey,
            1,
            isDarkMode,
          ),
          SizedBox(height: size.height * 0.018),
        ],
        _buildTextField(
          "Email",
          Icons.email_outlined,
          false,
          size,
          (valuemail) {
            if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
            ).hasMatch(valuemail)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          _emailKey,
          2,
          isDarkMode,
        ),
        SizedBox(height: size.height * 0.018),
        _buildTextField(
          "Password",
          Icons.lock_outline,
          true,
          size,
          (valuepassword) {
            if (valuepassword.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          _passwordKey,
          3,
          isDarkMode,
        ),
        if (register) ...[
          SizedBox(height: size.height * 0.018),
          _buildTextField(
            "Confirm Password",
            Icons.lock_outline,
            true,
            size,
            (valuepassword) {
              if (valuepassword != textfieldsStrings[3]) {
                return 'Passwords do not match';
              }
              return null;
            },
            _confirmPasswordKey,
            4,
            isDarkMode,
          ),
        ],
      ],
    );
  }

  Widget _buildTermsOrForgot(Size size, bool isDarkMode) {
    return register
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? _darkBackground.withOpacity(0.3)
                  : _lightBackground.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: isDarkMode ? _hintColor : _hintColor,
                  ),
                  child: Checkbox(
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                      });
                    },
                    activeColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(
                            color: isDarkMode ? _hintColor : _hintColor,
                            fontSize: size.height * 0.014,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => print('Terms of Service'),
                            child: Text(
                              "Terms",
                              style: TextStyle(
                                color: _primaryColor,
                                fontSize: size.height * 0.014,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: " and ",
                          style: TextStyle(
                            color: isDarkMode ? _hintColor : _hintColor,
                            fontSize: size.height * 0.014,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => print('Privacy Policy'),
                            child: Text(
                              "Privacy",
                              style: TextStyle(
                                color: _primaryColor,
                                fontSize: size.height * 0.014,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage(),
                    ),
                  );
                },
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(
                    color: _primaryColor,
                    fontSize: size.height * 0.015,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
  }

  Widget _buildActionButton(Size size, bool isDarkMode) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
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
            onPressed: _isLoading
                ? null
                : () async {
                    if (register) {
                      if (_validateRegister()) {
                        await _authenticate();
                      }
                    } else {
                      if (_validateLogin()) {
                        await _authenticate();
                      }
                    }
                  },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    height: size.height * 0.02,
                    width: size.height * 0.02,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    register ? "Create Account" : "Sign In",
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

  Widget _buildFooter(Size size, bool isDarkMode) {
    return Column(
      children: [
        // Logo
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: isDarkMode
              ? _cardDark.withOpacity(0.6)
              : _cardLight.withOpacity(0.8),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02,
              horizontal: size.width * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Barber',
                  style: GoogleFonts.poppins(
                    color: isDarkMode ? _textDark : _textLight,
                    fontSize: size.height * 0.024,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Style',
                  style: GoogleFonts.poppins(
                    color: _primaryColor,
                    fontSize: size.height * 0.024,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: size.height * 0.03),

        // Switch Auth Mode
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: isDarkMode
              ? _cardDark.withOpacity(0.6)
              : _cardLight.withOpacity(0.8),
          child: Container(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  register
                      ? "Already have an account? "
                      : "Don't have an account? ",
                  style: TextStyle(
                    color: isDarkMode ? _hintColor : _hintColor,
                    fontSize: size.height * 0.015,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => register = !register),
                  child: Text(
                    register ? "Sign In" : "Sign Up",
                    style: TextStyle(
                      color: _primaryColor,
                      fontSize: size.height * 0.015,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String hintText,
    IconData icon,
    bool isPassword,
    Size size,
    FormFieldValidator validator,
    GlobalKey<FormState> key,
    int stringToEdit,
    bool isDarkMode,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.transparent : Colors.grey.withOpacity(0.2),
        ),
        color: isDarkMode
            ? _darkBackground.withOpacity(0.5)
            : _lightBackground.withOpacity(0.8),
      ),
      child: Form(
        key: key,
        child: TextFormField(
          style: GoogleFonts.poppins(
            color: isDarkMode ? _textDark : _textLight,
            fontSize: size.height * 0.015,
          ),
          onChanged: (value) {
            setState(() {
              textfieldsStrings[stringToEdit] = value;
            });
          },
          validator: validator,
          obscureText: isPassword ? !pwVisible : false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.018,
            ),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: _hintColor,
              fontSize: size.height * 0.015,
            ),
            prefixIcon: Icon(
              icon,
              color: _primaryColor,
              size: size.height * 0.022,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      pwVisible ? Icons.visibility : Icons.visibility_off,
                      color: _hintColor,
                      size: size.height * 0.02,
                    ),
                    onPressed: () {
                      setState(() {
                        pwVisible = !pwVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }

  bool _validateRegister() {
    return _firstnamekey.currentState!.validate() &&
        _lastNamekey.currentState!.validate() &&
        _emailKey.currentState!.validate() &&
        _passwordKey.currentState!.validate() &&
        _confirmPasswordKey.currentState!.validate() &&
        checkedValue;
  }

  bool _validateLogin() {
    return _emailKey.currentState!.validate() &&
        _passwordKey.currentState!.validate();
  }
}
