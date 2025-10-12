import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/admins/presentation/cubits/admin_cubit.dart';
import 'package:untitled/features/branches/presentation/cubits/add_branch/add_branch_cubit.dart';
import 'package:untitled/features/branches/presentation/cubits/edit_branch/edit_branch_cubit.dart';
import 'package:untitled/features/categories/presentation/cubits/delete_category/delete_category_cubit.dart';
import 'package:untitled/features/categories/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:untitled/features/meals/presentation/cubits/meal_types_cubit/meal_types_cubit.dart';
import 'package:untitled/features/meals/presentation/cubits/meals/meals_cubit.dart';
import 'config/ResponsiveUI/responsiveConfig.dart';
import 'config/theme/app_theme.dart';
import 'core/di/injection.dart' as di;
import 'core/di/injection.dart';
import 'core/firebase/firebase_options.dart';
import 'core/routes/appRouter.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/cubit/login/login_cubit.dart';
import 'features/auth/presentation/cubit/logout/logout_cubit.dart';
import 'features/auth/presentation/cubit/refresh/refresh_cubit.dart';
import 'features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'features/categories/presentation/cubits/add_category/categories_cubit.dart';
import 'features/notifications/data/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  await NotificationService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
            BlocProvider<RefreshCubit>(create: (_) => di.sl<RefreshCubit>()),
            BlocProvider<LogoutCubit>(create: (_) => di.sl<LogoutCubit>()),
            BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
            BlocProvider<BranchCubit>(create: (_) => di.sl<BranchCubit>()..fetchBranches(),),
            BlocProvider<CategoriesCubit>(create: (_) => di.sl<CategoriesCubit>()),
            BlocProvider<AdminCubit>(create: (_) => di.sl<AdminCubit>()),
            BlocProvider<DeleteCategoryCubit>(create: (_) => di.sl<DeleteCategoryCubit>()),
            BlocProvider<GetCategoriesCubit>(create: (_) => di.sl<GetCategoriesCubit>()),
            BlocProvider<AddBranchCubit>(create: (_) => di.sl<AddBranchCubit>()),
            BlocProvider<EditBranchCubit>(create: (_) => di.sl<EditBranchCubit>()),
            BlocProvider<MealsCubit>(create: (_) => di.sl<MealsCubit>()),
            BlocProvider<MealTypesCubit>(create: (_) => di.sl<MealTypesCubit>()),

          ],
          child: Builder(
            builder: (context) {
              return ResponsiveConfig(
                context: context,
                child: MaterialApp.router(
                  theme: AppTheme.lightTheme,
                  routerConfig: AppRouter.router,
                  debugShowCheckedModeBanner: false,
                  builder: (context, child) {
                    return ResponsiveConfig.of(context).isDesktop ||
                        ResponsiveConfig.of(context).isTablet
                        ? child!
                        : Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: child,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
//         BlocProvider<RefreshCubit>(create:(_) => di.sl<RefreshCubit>()),
//         BlocProvider<LogoutCubit>(create: (_) => di.sl<LogoutCubit>()),
//         BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
//         BlocProvider<BranchCubit>(create: (_) => di.sl<BranchCubit>()..fetchBranches(),),
//         BlocProvider<CategoriesCubit>(create: (_) => di.sl<CategoriesCubit>()),
//         BlocProvider<AdminCubit>(create: (_) => di.sl<AdminCubit>()),
//         BlocProvider<GetCategoriesCubit>(create: (_) => di.sl<GetCategoriesCubit>()),
//       ],
//       child: Builder(
//         builder: (context) {
//           return ResponsiveConfig(
//             context: context,
//             child: MaterialApp.router(
//               theme: AppTheme.lightTheme,
//               routerConfig: AppRouter.router,
//               debugShowCheckedModeBanner: false,
//               builder: (context, child) {
//                 return ResponsiveConfig.of(context).isDesktop ||
//                     ResponsiveConfig.of(context).isTablet
//                     ? child!
//                     : Center(
//                   child: ConstrainedBox(
//                     constraints: const BoxConstraints(maxWidth: 500),
//                     child: child,
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

