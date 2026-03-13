import 'package:flutter/material.dart';
import 'package:flutter_application/api/api_manager.dart';
import 'package:flutter_application/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/screens/register/language_provider.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_input_decoration.dart';
import '../../services/user_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String avatar = "assets/images/ava1.png";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleRegister(BuildContext context, bool isArabic) async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      _showSnackBar(
        context,
        isArabic ? "من فضلك املأ جميع الحقول" : "Please fill all fields",
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

    if (password != confirmPassword) {
      _showSnackBar(
        context,
        isArabic
            ? "كلمة المرور وتأكيدها غير متطابقين"
            : "Passwords do not match",
      );
      return;
    }

    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(phone)) {
      _showSnackBar(
        context,
        isArabic ? "رقم الهاتف غير صحيح" : "Please enter a valid phone number",
      );
      return;
    }
    bool sucess = await ApiManager.register( name,email,password  );
    if (sucess) {
      _showSnackBar(
        context,
        isArabic ? "تم إنشاء الحساب بنجاح" : "Account created successfully",
      );
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      _showSnackBar(
        context,
        isArabic ? "حدث خطأ أثناء التسجيل" : "Registration failed",
      );
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
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.appBarIcon),
            onPressed: () async {
              await UserStorage.saveUser(
                  _nameController.text, _phoneController.text, avatar);
              Navigator.pop(context);
            }),
        title: Text(
          isArabic ? "إنشاء حساب" : "Register",
          style: const TextStyle(color: AppColors.appBarTitle),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/ava2.png', width: 70),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/ava1.png', width: 110),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/ava3.png', width: 70),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                isArabic ? "الصورة الشخصية" : "Avatar",
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: _nameController,
                hint: isArabic ? "الاسم" : "Name",
                icon: Icons.person_pin_outlined,
              ),
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
              _buildTextField(
                controller: _confirmPasswordController,
                hint: isArabic ? "تأكيد كلمة المرور" : "Confirm Password",
                icon: Icons.lock_outline,
                isPassword: true,
                isObscured: _isConfirmPasswordObscured,
                onSuffixTap: () => setState(
                  () =>
                      _isConfirmPasswordObscured = !_isConfirmPasswordObscured,
                ),
              ),
              _buildTextField(
                controller: _phoneController,
                hint: isArabic ? "رقم الهاتف" : "Phone Number",
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => _handleRegister(context, isArabic),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isArabic ? "إنشاء حساب" : "Create Account",
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isArabic ? "لديك حساب بالفعل؟ " : "Already Have Account? ",
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, 'login'),
                    child: Text(
                      isArabic ? "تسجيل الدخول" : "Login",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
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
              child: const Text("ُ🇪🇬", style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
