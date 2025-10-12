import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'package:untitled/features/categories/domain/entities/category_entity.dart';
import 'package:untitled/features/categories/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:untitled/features/meals/domain/entities/meal_with_types_entity.dart';
import 'package:untitled/features/meals/presentation/cubits/delete_meal/delete_meal_cubit.dart';
import 'package:untitled/features/meals/presentation/cubits/delete_type/delete_type_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/networks/api_constant.dart';
import '../../../../core/widgets/CustomDropDown.dart';
import '../cubits/add_meal/add_meal_cubit.dart';
import '../cubits/meal_types_cubit/meal_types_cubit.dart';
import '../cubits/meals/meals_cubit.dart';
import '../widgets/customMealsHeaderRow.dart';
import '../widgets/customMealsTile.dart';
import 'mealTypes_dialog.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final branchCubit = context.read<BranchCubit>();
    final categoriesCubit = context.read<GetCategoriesCubit>();
    final mealsCubit = context.read<MealsCubit>();
    final deleteMeal = context.read<DeleteMealCubit>();
    final deleteType = context.read<DeleteTypeCubit>();
    final addMeal = context.read<AddMealCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      branchCubit.fetchBranches();
    });
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.smooky,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الوجبات',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<BranchCubit, BranchState>(
              builder: (context, branchState) {
                final branches = (branchState is BranchSuccess)
                    ? branchState.branches.branches
                    : branchCubit.branches;

                final isLoading = branchState is BranchLoading;

                return isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomDropDown(
                  value: branchCubit.selectedBranch,
                  hintText: 'اختر الفرع',
                  items: branches,
                  getLabel: (branch) => branch.branch_name ?? '',
                  onChanged: (branch) {
                    branchCubit.selectBranch(branch);
                    if (branch != null) {
                      categoriesCubit.fetchCategories(branch.id);
                    }
                  },
                );
              },
            ),

            SizedBox(height: 20),
            BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
              builder: (context, state) {
                final categories = categoriesCubit.categories; // always use cubit.categories
                final selectedCategory = categoriesCubit.selectedCategory;
                if (state is GetCategoriesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomDropDown<CategoryEntity>(
                  value: selectedCategory,
                  hintText: categories.isEmpty
                      ? (branchCubit.selectedBranch == null ? "اختر الفرع أولًا" : "لا توجد أصناف")
                      : "اختر صنف",
                  items: categories,
                  getLabel: (category) => category.name,
                  onChanged: (category) {
                    categoriesCubit.selectaCategory(category);
                    if (category != null) {
                      mealsCubit.fetchMeals(category.id);
                    }
                  },
                );
              },
            ),

            SizedBox(height: 20),

            const CustomMealsHeaderRow(),
            Expanded(
              child: BlocBuilder<MealsCubit, MealsState>(
                builder: (context, state) {
                  if (state is MealsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MealsSuccess) {
                    final meals = state.meals;
                    return ListView.builder(
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        final meal = meals[index];
                        return GestureDetector(
                          onTap: () async {
                            final mealTypesCubit = context.read<MealTypesCubit>();
                            await mealTypesCubit.getMealsTypes(meal.id);
                            final typeState = mealTypesCubit.state;

                            if (typeState is MealTypesSuccess) {
                              final mealsWithTypes = typeState.meals.cast<MealWithTypesEntity>();
                              final mealWithType = mealsWithTypes.firstWhere(
                                    (m) => m.id == meal.id,
                                orElse: () => MealWithTypesEntity(
                                  meal.id,
                                  meal.name,
                                  meal.image,
                                  meal.description,
                                  meal.maincategory_id,
                                  [],
                                ),
                              );

                              if (mealWithType.types != null && mealWithType.types!.isNotEmpty) {
                                final type = mealWithType.types!.first;
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => MealTypesDialog(
                                    mealName: mealWithType.name,
                                    mealImage: mealWithType.image,
                                    description: mealWithType.description,
                                    price: type.price,
                                    extraPrice: type.supportprice,
                                    availble: type.available.toString(),
                                    onDelete: () async {
                                      final scaffoldContext = context;
                                      try {
                                        await deleteType.deleteType(type.id);

                                        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                                          const SnackBar(
                                            content: Text("تم حذف النوع بنجاح ✅"),
                                            backgroundColor: AppColors.smooky2,
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                        final mealTypesCubit = context.read<MealTypesCubit>();
                                        await mealTypesCubit.getMealsTypes(meal.id);

                                      } catch (e) {
                                        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                                          SnackBar(
                                            content: Text("حدث خطأ أثناء الحذف ❌: $e"),
                                            backgroundColor: Colors.red,
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    onEdit: (int newPrice, int newExtraPrice) {  },
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                    backgroundColor: AppColors.smooky,
                                    content: Text(
                                      "لا توجد أنواع متاحة لهذه الوجبة 🍽️",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              }
                            }
                            else if (typeState is MealTypesFailure) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  backgroundColor: AppColors.smooky,
                                  content: Text(
                                    "حدث خطأ أثناء جلب الأنواع: ${typeState.message}",
                                    style: const TextStyle(color: Colors.redAccent),
                                  ),
                                ),
                              );
                            }
                          },
                          child: CustomMealsTile(
                            name: meal.name,
                            image: '${ApiConstant.imageBase}${meal.image}',
                            description: meal.description,
                            onDelete: () async {
                              await deleteMeal.deleteMeal(meal.id);
                              mealsCubit.fetchMeals(categoriesCubit.selectedCategory?.id ?? 0);
                            },
                            onAdd: () async {},
                          ),
                        );
                      },
                    );
                  } else if (state is MealsFailure) {
                    return Center(
                      child: Text(
                        "❌ ${state.message}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      "اختر الفرع ثم الصنف لعرض الوجبات 🍽️",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
