import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../config/animations/loading.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/customBackButton.dart';
import '../../../../core/widgets/customButton.dart';
import '../../../../core/widgets/customTextField.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/login/login_cubit.dart';

class Login_SignupPage extends StatelessWidget {
  Login_SignupPage({Key? key}) : super(key: key);

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveConfig.of(context);
    double containerWidth = responsive.isMobile ? double.infinity : 550;

    return Scaffold(
      backgroundColor: AppColors.smooky2,
      body: Center(
        child: Container(
          width: containerWidth,
          height: 850,
          decoration: BoxDecoration(color: AppColors.smooky),
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<LoginCubit, LoginState>(
                      listener: (context, loginState) {
                        if (loginState is LoginLoading) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(child: LoadinDount()),
                          );
                        } else {
                          // إغلاق أي Dialog مفتوح
                          if (Navigator.of(context, rootNavigator: true).canPop()) {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        }

                        if (loginState is LoginSuccess) {
                          context.read<AuthCubit>().loggedIn();
                          context.go('/dash');
                        } else if (loginState is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(loginState.message)),
                          );
                        }
                      },
                    ),
                  ],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Image.asset(AppImages.logo, width: 200),
                      ),
                      const SizedBox(height: 40),

                      /// رقم الهاتف
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "رقم الهاتف",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: "أدخل رقمك",
                        prefixIcon: Icons.phone,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),

                      /// كلمة السر
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "كلمة السر",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ValueListenableBuilder<bool>(
                        valueListenable: _obscurePasswordNotifier,
                        builder: (context, obscureText, child) {
                          return CustomTextField(
                            hintText: "••••••••",
                            prefixIcon: Icons.lock,
                            controller: passwordController,
                            obscureText: obscureText,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.amber,
                              ),
                              onPressed: () {
                                _obscurePasswordNotifier.value =
                                !_obscurePasswordNotifier.value;
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),

                      /// زر تسجيل الدخول
                      SizedBox(
                        width: containerWidth,
                        height: 45,
                        child: CustomButton(
                          text: "تسجيل الدخول",
                          onPressed: () {
                            context.read<LoginCubit>().login(
                              phonenumber: phoneController.text,
                              password: passwordController.text,
                            );
                          },
                          buttonColor: AppColors.amber,
                          textColor: AppColors.black1,
                          borderRadius: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// زر رجوع
              CustomBackButton(onTap: () => context.go('/home')),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropDown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: AppColors.smooky2, // خلفية القائمة
      value: value,
      icon: Icon(Icons.arrow_drop_down, color: AppColors.amber),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.smooky2, // خلفية الحقل الأساسي
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(
        color: AppColors.grey1, // لون النصوص
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: TextStyle(color: AppColors.white), // نص أبيض أو grey1
        ),
      ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
