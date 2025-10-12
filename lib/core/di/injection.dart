import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/features/admins/data/data_sources/admin_service.dart';
import 'package:untitled/features/admins/data/repositories/admin_repository_impl.dart';
import 'package:untitled/features/admins/domain/repositories/admin_repository.dart';
import 'package:untitled/features/admins/domain/usecases/add_admin_usecase.dart';
import 'package:untitled/features/admins/domain/usecases/get_admins_usecase.dart';
import 'package:untitled/features/admins/presentation/cubits/admin_cubit.dart';
import 'package:untitled/features/branches/domain/usecases/add_branch_usecase.dart';
import 'package:untitled/features/branches/domain/usecases/edit_branch_usecase.dart';
import 'package:untitled/features/branches/presentation/cubits/add_branch/add_branch_cubit.dart';
import 'package:untitled/features/branches/presentation/cubits/edit_branch/edit_branch_cubit.dart';
import 'package:untitled/features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'package:untitled/features/categories/data/data_sources/categories_service.dart';
import 'package:untitled/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:untitled/features/categories/domain/repositories/categories_repository.dart';
import 'package:untitled/features/categories/domain/usecases/add_main_category_usecase.dart';
import 'package:untitled/features/categories/domain/usecases/delete_main_category_usecase.dart';
import 'package:untitled/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:untitled/features/categories/presentation/cubits/delete_category/delete_category_cubit.dart';
import 'package:untitled/features/categories/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:untitled/features/meals/data/data_sources/meal_service.dart';
import 'package:untitled/features/meals/data/data_sources/meal_types_service.dart';
import 'package:untitled/features/meals/data/repositories/meal_repository_impl.dart';
import 'package:untitled/features/meals/data/repositories/meal_types_repository_impl.dart';
import 'package:untitled/features/meals/domain/repositories/get_types_of_meal_repository.dart';
import 'package:untitled/features/meals/domain/repositories/meal_repository.dart';
import 'package:untitled/features/meals/domain/usecases/get_meals_of_category_usecase.dart';
import 'package:untitled/features/meals/domain/usecases/get_types_of_meal_usecase.dart';
import 'package:untitled/features/meals/presentation/cubits/meal_types_cubit/meal_types_cubit.dart';
import 'package:untitled/features/meals/presentation/cubits/meals/meals_cubit.dart';
import '../../features/auth/data/data_sources/login/login_service.dart';
import '../../features/auth/data/data_sources/logout/logout_service.dart';
import '../../features/auth/data/data_sources/refresh/refresh_service.dart';
import '../../features/auth/data/data_sources/register/register_service.dart';
import '../../features/auth/data/repositories/login/login_repository_impl.dart';
import '../../features/auth/data/repositories/logout/logout_repository_impl.dart';
import '../../features/auth/data/repositories/refresh/refresh_respository_impl.dart';
import '../../features/auth/data/repositories/register/register_repository_impl.dart';
import '../../features/auth/domain/repositories/login/login_repository.dart';
import '../../features/auth/domain/repositories/logout/logout_repository.dart';
import '../../features/auth/domain/repositories/refresh/refresh_repository.dart';
import '../../features/auth/domain/repositories/register/register_repository.dart';
import '../../features/auth/domain/usecases/login/login_usecase.dart';
import '../../features/auth/domain/usecases/logout/logout_usecase.dart';
import '../../features/auth/domain/usecases/refresh/refresh_usecase.dart';
import '../../features/auth/domain/usecases/register/register_usecase.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';
import '../../features/auth/presentation/cubit/logout/logout_cubit.dart';
import '../../features/auth/presentation/cubit/refresh/refresh_cubit.dart';
import '../../features/branches/data/data_sources/branches_service.dart';
import '../../features/branches/data/repositories/branches_repository_impl.dart';
import '../../features/branches/domain/repositories/branches_repository.dart';
import '../../features/branches/domain/usecases/branches_usecase.dart';
import '../../features/categories/presentation/cubits/add_category/categories_cubit.dart';
import '../networks/dio_factory.dart';

final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Dio
  final dio = await DioFactory.getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  // Data sources
  sl.registerLazySingleton<RegisterService>(() => RegisterService(sl<Dio>()));
  sl.registerLazySingleton<LoginService>(() => LoginService(sl<Dio>()));
  sl.registerLazySingleton<LogoutService>(() => LogoutService(sl<Dio>()));
  sl.registerLazySingleton<RefreshService>(() => RefreshService(sl<Dio>()));
  sl.registerLazySingleton<BranchesService>(() => BranchesService(sl<Dio>()));
  sl.registerLazySingleton<CategoriesService>(() => CategoriesService(sl<Dio>()),);
  sl.registerLazySingleton<AdminService>(() => AdminService(sl<Dio>()));
  sl.registerLazySingleton<MealService>(() => MealService(sl<Dio>()));
  sl.registerLazySingleton<MealTypesService>(() => MealTypesService(sl<Dio>()));

  // Repositories
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(sl<RegisterService>()),);
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl<LoginService>()),);
  sl.registerLazySingleton<LogoutRepository>(() => LogoutRepositoryImpl(sl<LogoutService>()),);
  sl.registerLazySingleton<RefreshRepository>(() => RefreshRepositoryImpl(sl<RefreshService>()),);
  sl.registerLazySingleton<BranchesRepository>(() => BranchesRepositoryImpl(sl<BranchesService>()),);
  sl.registerLazySingleton<CategoriesRepository>(() => CategoriesRepositoryImpl(sl<CategoriesService>()),);
  sl.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl(service: sl<AdminService>()));
  sl.registerLazySingleton<MealRepository>(() => MealRepositoryImpl(sl<MealService>()));
  sl.registerLazySingleton<MealTypesRepository>(() => MealTypesRepositoryImpl(sl<MealTypesService>()));

  // UseCases
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl<RegisterRepository>()),);
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<LoginRepository>()),);
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl<LogoutRepository>()),);
  sl.registerLazySingleton<RefreshUseCase>(() => RefreshUseCase(sl<RefreshRepository>()),);
  sl.registerLazySingleton<BranchesUseCase>(() => BranchesUseCase(sl<BranchesRepository>()),);
  sl.registerLazySingleton<AddMainCategotryUseCase>(() => AddMainCategotryUseCase(sl<CategoriesRepository>()),);
  sl.registerLazySingleton<GetAdminsUseCase>(() => GetAdminsUseCase(sl<AdminRepository>()),);
  sl.registerLazySingleton<AddAdminUseCase>(() => AddAdminUseCase(sl<AdminRepository>()),);
  sl.registerLazySingleton<GetCategoriesUseCase>(() => GetCategoriesUseCase(sl<CategoriesRepository>()),);
  sl.registerLazySingleton<DeleteMainCategotryUseCase>(() => DeleteMainCategotryUseCase(sl<CategoriesRepository>()),);
  sl.registerLazySingleton<AddBranchUseCase>(() => AddBranchUseCase(repository: sl<BranchesRepository>()),);
  sl.registerLazySingleton<EditBranchUseCase>(() => EditBranchUseCase(sl<BranchesRepository>()),);
  sl.registerLazySingleton<GetMealOfCategoryUseCase>(() => GetMealOfCategoryUseCase(sl<MealRepository>()),);
  sl.registerLazySingleton<GetTypesOfMealUseCase>(() => GetTypesOfMealUseCase(sl<MealTypesRepository>()),);

  // Cubits
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(sl<LoginUseCase>()));
  sl.registerLazySingleton<LogoutCubit>(() => LogoutCubit(sl<LogoutUseCase>()));
  sl.registerLazySingleton<RefreshCubit>(() => RefreshCubit(sl<RefreshUseCase>()),);
  sl.registerLazySingleton<BranchCubit>(() => BranchCubit(sl<BranchesUseCase>()),);
  sl.registerLazySingleton<CategoriesCubit>(() => CategoriesCubit(sl<AddMainCategotryUseCase>()),);
  sl.registerLazySingleton<AdminCubit>(() => AdminCubit(sl<GetAdminsUseCase>(),sl<AddAdminUseCase>()),);
  sl.registerLazySingleton<GetCategoriesCubit>(() => GetCategoriesCubit(sl<GetCategoriesUseCase>()),);
  sl.registerLazySingleton<DeleteCategoryCubit>(() => DeleteCategoryCubit(sl<DeleteMainCategotryUseCase>()));
  sl.registerLazySingleton<AddBranchCubit>(() => AddBranchCubit(addBranchUseCase: sl<AddBranchUseCase>()));
  sl.registerLazySingleton<EditBranchCubit>(() => EditBranchCubit(sl<EditBranchUseCase>()));
  sl.registerLazySingleton<MealsCubit>(() => MealsCubit(sl<GetMealOfCategoryUseCase>()));
  sl.registerLazySingleton<MealTypesCubit>(() => MealTypesCubit(sl<GetTypesOfMealUseCase>()));

}
