import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/utils/secure_storage.dart';
import 'package:untitled/features/branches/presentation/pages/branches_page.dart';
import 'package:untitled/features/categories/presentation/pages/categories_page.dart';
import 'package:untitled/features/meals/presentation/pages/meals_page.dart';
import '../../features/admins/presentation/cubits/admin_cubit.dart';
import '../../features/auth/presentation/pages/login&signup.dart';
import '../../features/branches/domain/usecases/branches_usecase.dart';
import '../../features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import '../../features/dashboard/presentation/dashboard_home/pages/dashboard_home/dashboard.dart';
import '../../features/admins/presentation/pages/admins_page.dart';
import '../di/injection.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login_signup',
    routes: [
      GoRoute(
        path: '/login_signup',
        builder: (context, state) => Login_SignupPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => DashboardPage(child: child),
        routes: [
          GoRoute(
            path: '/dash',
            builder:
                (context, state) =>
                    const Center(child: Text("🍔 محتوى الصفحة الرئيسية")),
          ),
          GoRoute(path: '/admin', builder: (context, state) => AdminsPage()),
          GoRoute(
            path: '/branches',
            builder:
                (context, state) =>
                    BranchesPage(),
          ),
          GoRoute(
            path: '/categories',
            builder: (context, state) => CategoriesPage(),
          ),
          GoRoute(
            path: '/meals',
            builder: (context, state) => MealsPage(),
          ),
        ],
      ),
    ],
  );
}
