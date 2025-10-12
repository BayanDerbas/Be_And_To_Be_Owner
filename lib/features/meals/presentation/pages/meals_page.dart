import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'package:untitled/features/categories/domain/entities/category_entity.dart';
import 'package:untitled/features/categories/presentation/cubits/get_categories/get_categories_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/networks/api_constant.dart';
import '../../../../core/widgets/CustomDropDown.dart';
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

    // Fetch branches once
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

            SizedBox(height: 20.h),
            BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
              builder: (context, state) {
                final categories = categoriesCubit.categories; // always use cubit.categories
                final selectedCategory = categoriesCubit.selectedCategory;

                // Show loading
                if (state is GetCategoriesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Show dropdown even after selecting a category
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

            SizedBox(height: 20.h),

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
                          onTap: () {
                            final mealTypesCubit =
                            context.read<MealTypesCubit>();
                            mealTypesCubit.getMealsTypes(meal.id);
                            showDialog(
                              context: context,
                              builder: (_) {
                                return BlocProvider.value(
                                  value: mealTypesCubit,
                                  child: MealTypesDialog(
                                    mealName: meal.name,
                                    mealImage: meal.image,
                                  ),
                                );
                              },
                            );
                          },
                          child: CustomMealsTile(
                            name: meal.name,
                            image: '${ApiConstant.imageBase}${meal.image}',
                            description: meal.description,
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
