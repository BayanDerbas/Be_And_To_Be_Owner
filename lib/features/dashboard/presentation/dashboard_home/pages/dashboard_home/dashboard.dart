import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/utils/secure_storage.dart';
import '../../../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../widgets/custom_menu_item.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveConfig.of(context).isDesktop;
    final isTablet = ResponsiveConfig.of(context).isTablet;
    final isMobile = ResponsiveConfig.of(context).isMobile;
    final sidebarWidth = isMobile ? 150.0 : 220.0;

    return FutureBuilder(
        future: SecureStorage.getToken(),
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          final token = snapshot.hasData;
          if (token == null){
            Future.microtask(() => context.go('/login_signup'));
            return const SizedBox.shrink();
          }
          return Scaffold(
            body: Row(
              children: [
                Container(
                  width: sidebarWidth,
                  color: AppColors.smooky,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "لوحة التحكم",
                                  style: TextStyle(
                                    color: AppColors.amber,
                                    fontSize: isMobile ? 15 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 3),
                                IconButton(
                                  onPressed: () => context.go('/dash'),
                                  icon: Icon(
                                    Icons.water_damage_sharp,
                                    size: isMobile ? 25 : 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          CustomMenuItem(
                            icon: Icons.admin_panel_settings,
                            title: "الادارة",
                            onTap: () => context.go('/admin'),
                          ),
                          CustomMenuItem(
                            icon: Icons.store,
                            title: "الفروع",
                            onTap: () => context.go('/branches'),
                          ),
                          CustomMenuItem(
                            icon: Icons.fastfood,
                            title: "الأصناف",
                            onTap: () => context.go('/categories'),
                          ),
                          CustomMenuItem(
                            icon: Icons.restaurant_outlined,
                            title: "الوجبات",
                            onTap: () => context.go('/meals'),
                          ),
                          SizedBox(height: isMobile ? 20 : 50),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await SecureStorage.deleteToken();
                                context.go('/login_signup');
                              },
                              icon: const Icon(Icons.logout, color: AppColors.white),
                              label: const Text(
                                'Logout',
                                style: TextStyle(color: AppColors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.smooky2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Main Content
                Expanded(
                  child: Container(
                    color: AppColors.smooky2,
                    child: child,
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
}
