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
import '../../../notifications/data/services/notification_service.dart';
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

                      SizedBox(
                        width: containerWidth,
                        height: 45,
                        child: CustomButton(
                          text: "تسجيل الدخول",
                          onPressed: () {
                            final device_token = NotificationService.fcm_Token ?? " ";
                            context.read<LoginCubit>().login(
                              phonenumber: phoneController.text,
                              password: passwordController.text,
                              device_token: device_token,
                            );
                            print("Device_token : $device_token\n\n");
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
              CustomBackButton(onTap: () => context.go('/home')),
            ],
          ),
        ),
      ),
    );
  }
}

