import 'package:flutter/material.dart';
import 'package:flutter_application/api/api_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/screens/register/language_provider.dart';
import 'package:flutter_application/screens/register/register_screen.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_input_decoration.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordObscured = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleLogin(BuildContext context, bool isArabic) async {

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(
        context,
        isArabic
            ? "من فضلك ادخل البريد الإلكتروني وكلمة المرور"
            : "Please enter your email and password",
      );
      return;
    }

    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      _showSnackBar(
        context,
        isArabic ? "البريد الإلكتروني غير صحيح" : "Please enter a valid email",
      );
      return;
    }

    if (password.length < 6) {
      _showSnackBar(
        context,
        isArabic
            ? "كلمة المرور يجب أن تكون 6 أحرف على الأقل"
            : "Password must be at least 6 characters",
      );
      return;
    }

    try {

      var response = await ApiManager.login(email, password);

      if (response != null) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );

      }

    } catch (e) {

      _showSnackBar(
        context,
        isArabic
            ? "فشل تسجيل الدخول"
            : "Login failed",
      );

    }

  }


  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);
    bool isArabic = langProvider.currentLocale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.appBarIcon),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isArabic ? "تسجيل الدخول" : "Login",
          style: const TextStyle(color: AppColors.appBarTitle),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/splash.png',
                width: 120,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.play_circle_fill,
                  color: AppColors.primary,
                  size: 150,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: _emailController,
                hint: isArabic ? "البريد الإلكتروني" : "Email",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                controller: _passwordController,
                hint: isArabic ? "كلمة المرور" : "Password",
                icon: Icons.lock_outline,
                isPassword: true,
                isObscured: _isPasswordObscured,
                onSuffixTap: () =>
                    setState(() => _isPasswordObscured = !_isPasswordObscured),
              ),
              Align(
                alignment:
                    isArabic ? Alignment.centerLeft : Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, 'forget_password'),
                  child: Text(
                    isArabic ? "نسيت كلمة المرور؟" : "Forgot Password?",
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => _handleLogin(context, isArabic),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isArabic ? "تسجيل الدخول" : "Login",
                    style: const TextStyle(
                      color: AppColors.buttonText,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.divider)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      isArabic ? "أو" : "OR",
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.divider)),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Text(
                    "G",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: Text(
                    isArabic ? "تسجيل الدخول بجوجل" : "Login With Google",
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.divider),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isArabic ? "ليس لديك حساب؟ " : "Don't Have Account? ",
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      isArabic ? "إنشاء حساب" : "Create One",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildLanguageSwitcher(langProvider),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isObscured = false,
    VoidCallback? onSuffixTap,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? isObscured : false,
        keyboardType: keyboardType,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: AppInputDecoration.field(
          hint: hint,
          prefixIcon: icon,
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(
                    isObscured ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.iconSecondary,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildLanguageSwitcher(LanguageProvider provider) {
    bool isAr = provider.currentLocale.languageCode == 'ar';
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => provider.changeLanguage('en'),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: !isAr ? AppColors.primary : Colors.transparent,
              child: const Text("🇺🇸", style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => provider.changeLanguage('ar'),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: isAr ? AppColors.primary : Colors.transparent,
              child: const Text("🇪🇬", style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
