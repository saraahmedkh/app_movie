import 'package:flutter/material.dart';
import 'package:flutter_application/api/api_manager.dart';
import 'package:flutter_application/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/screens/register/language_provider.dart';
import '../../core/styles/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleVerifyEmail(BuildContext context, bool isArabic) async{
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showSnackBar(
        context,
        isArabic ? "من فضلك ادخل البريد الإلكتروني" : "Please enter your email",
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
    _showSnackBar(
      context,
      isArabic
          ? "تم إرسال رابط إعادة التعيين على بريدك"
          : "Reset link sent to your email!",
    );
    bool succes =await ApiManager.resetPassword(_emailController.text, _passwordController.text);
    if(succes){
      Navigator.pop(context);
    }
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

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);
    bool isArabic = langProvider.currentLocale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.appBarIcon),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isArabic ? "نسيت كلمة المرور" : "Forget Password",
          style: const TextStyle(color: AppColors.appBarTitle),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/images/Forgot password.png', width: 220),
            const SizedBox(height: 40),
            Text(
              isArabic
                  ? "أدخل بريدك الإلكتروني وسنرسل لك رابط إعادة تعيين كلمة المرور"
                  : "Enter your email and we'll send you a password reset link",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: AppColors.textPrimary),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surface,
                hintText: isArabic ? "البريد الإلكتروني" : "Email",
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.iconPrimary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: (

                    ) => _handleVerifyEmail(context, isArabic),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isArabic ? "تحقق من البريد" : "Verify Email",
                  style: const TextStyle(
                    color: AppColors.buttonText,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
