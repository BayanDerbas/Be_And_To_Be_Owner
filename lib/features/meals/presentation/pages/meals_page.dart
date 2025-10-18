import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/core/networks/api_constant.dart';
import 'package:untitled/core/constants/app_colors.dart';
import 'package:untitled/core/widgets/CustomDropDown.dart';
import 'package:untitled/features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'package:untitled/features/categories/domain/entities/category_entity.dart';
import 'package:untitled/features/categories/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:untitled/features/meals/domain/entities/meal_with_types_entity.dart';
import 'package:untitled/features/meals/presentation/cubits/add_meal/add_meal_cubit.dart';
import 'package:untitled/features/meals/presentation/cubits/delete_meal/delete_meal_cubit.dart';
import 'package:untitled/features/meals/presentation/cubits/delete_type/delete_type_cubit.dart';
import 'package:untitled/features/meals/presentation/cubits/edit_price/edit_price_cubit.dart';
import 'package:untitled/features/meals/presentation/cubits/meal_types_cubit/meal_types_cubit.dart';
import 'package:untitled/features/meals/presentation/cubits/meals/meals_cubit.dart';
import 'package:untitled/features/meals/presentation/widgets/customAddMealDialog.dart';
import 'package:untitled/features/meals/presentation/widgets/customMealsHeaderRow.dart';
import 'package:untitled/features/meals/presentation/widgets/customMealsTile.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
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
      backgroundColor: AppColors.smooky,
      appBar: AppBar(
        backgroundColor: AppColors.smooky,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الوجبات',
            style: TextStyle(
              color: AppColors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ----- Branch Dropdown -----
                      BlocBuilder<BranchCubit, BranchState>(
                        builder: (context, state) {
                          final isLoading = state is BranchLoading;
                          final branches = (state is BranchSuccess)
                              ? state.branches.branches
                              : branchCubit.branches;

                          return isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomDropDown(
                            value: branchCubit.selectedBranch,
                            hintText: 'اختر الفرع',
                            items: branches,
                            getLabel: (branch) =>
                            branch.branch_name ?? "بدون اسم",
                            onChanged: (branch) {
                              branchCubit.selectBranch(branch);
                              if (branch != null) {
                                categoriesCubit.fetchCategories(branch.id);
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 15.h),

                      // ----- Category Dropdown -----
                      BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                        builder: (context, state) {
                          final categories = categoriesCubit.categories;
                          final selectedCategory =
                              categoriesCubit.selectedCategory;

                          if (state is GetCategoriesLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          return CustomDropDown<CategoryEntity>(
                            value: selectedCategory,
                            hintText: categories.isEmpty
                                ? (branchCubit.selectedBranch == null
                                ? "اختر الفرع أولًا"
                                : "لا توجد أصناف")
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

                      // ----- Add Meal Button -----
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.amber,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 18.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            "إضافة وجبة",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => CustomAddMealDialog(
                                onAdd: ({
                                  required String mealName,
                                  required String description,
                                  required XFile image,
                                  required int price,
                                  required int extraPrice,
                                  required int tExtraPrice,
                                  int? hasTypes,
                                  List<String>? typeNames,
                                  List<int>? typePrices,
                                  List<int>? typeExtraPrices,
                                }) async {
                                  final scaffoldContext = context;
                                  try {
                                    await addMeal.addMeal(
                                      hasTypes: hasTypes,
                                      mealName: mealName,
                                      description: description,
                                      image: image,
                                      mainCategoryId:
                                      categoriesCubit.selectedCategory!.id,
                                      price: price,
                                      extraPrice: tExtraPrice,
                                      tExtraPrice: extraPrice,
                                      typeNames: typeNames,
                                      typePrices: typePrices,
                                      typeExtraPrices: typeExtraPrices,
                                    );
                                    ScaffoldMessenger.of(scaffoldContext)
                                        .showSnackBar(const SnackBar(
                                      content:
                                      Text("تمت إضافة الوجبة بنجاح ✅"),
                                      backgroundColor: AppColors.smooky2,
                                      duration: Duration(seconds: 2),
                                    ));
                                    mealsCubit.fetchMeals(categoriesCubit
                                        .selectedCategory?.id ??
                                        0);
                                  } catch (e) {
                                    ScaffoldMessenger.of(scaffoldContext)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "حدث خطأ أثناء الإضافة ❌: $e"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 25.h),

                      // ----- Header + List Scroll Together -----
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: ResponsiveConfig.of(context).isMobile
                              ? 950
                              : ResponsiveConfig.of(context).isTablet
                              ? 1150
                              : MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomMealsHeaderRow(),
                              SizedBox(height: 10.h),

                              BlocBuilder<MealsCubit, MealsState>(
                                builder: (context, state) {
                                  if (state is MealsLoading) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (state is MealsSuccess) {
                                    final meals = state.meals;
                                    if (meals.isEmpty) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            "لا توجد وجبات متاحة 🍴",
                                            style: TextStyle(
                                                color: AppColors.grey1),
                                          ),
                                        ),
                                      );
                                    }

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemCount: meals.length,
                                      itemBuilder: (context, index) {
                                        final meal = meals[index];
                                        return GestureDetector(
                                          onTap: () async {
                                            final mealTypesCubit = context
                                                .read<MealTypesCubit>();
                                            await mealTypesCubit
                                                .getMealsTypes(meal.id);
                                            final typeState =
                                                mealTypesCubit.state;

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


                                              if (mealWithType.types != null &&
                                                  mealWithType
                                                      .types!.isNotEmpty) {
                                                final type =
                                                    mealWithType.types!.first;
                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      MealTypesDialog(
                                                        mealName:
                                                        mealWithType.name,
                                                        mealImage:
                                                        mealWithType.image,
                                                        description: mealWithType
                                                            .description,
                                                        price: type.price,
                                                        extraPrice:
                                                        type.supportprice,
                                                        availble: type.available
                                                            .toString(),
                                                        onDelete: () async {
                                                          await deleteType
                                                              .deleteType(type.id);
                                                          mealsCubit.fetchMeals(
                                                              categoriesCubit
                                                                  .selectedCategory
                                                                  ?.id ??
                                                                  0);
                                                        },
                                                        onEdit: (newPrice,
                                                            newExtraPrice) async {
                                                          final editPriceCubit =
                                                          context.read<
                                                              EditPriceCubit>();
                                                          await editPriceCubit
                                                              .editPrice(
                                                              type.id,
                                                              newPrice,
                                                              newExtraPrice);
                                                          mealsCubit.fetchMeals(
                                                              categoriesCubit
                                                                  .selectedCategory
                                                                  ?.id ??
                                                                  0);
                                                        },
                                                      ),
                                                );
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                  const AlertDialog(
                                                    backgroundColor:
                                                    AppColors.smooky,
                                                    content: Text(
                                                      "لا توجد أنواع متاحة لهذه الوجبة 🍽️",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child: Card(
                                            color: AppColors.smooky2,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 6.h),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(12.r),
                                            ),
                                            child: CustomMealsTile(
                                              name: meal.name,
                                              description: meal.description,
                                              image:
                                              '${ApiConstant.imageBase}${meal.image}',
                                              onDelete: () async {
                                                await deleteMeal
                                                    .deleteMeal(meal.id);
                                                mealsCubit.fetchMeals(
                                                    categoriesCubit
                                                        .selectedCategory
                                                        ?.id ??
                                                        0);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else if (state is MealsFailure) {
                                    return Center(
                                      child: Text(
                                        "❌ ${state.message}",
                                        style: const TextStyle(
                                            color: Colors.red),
                                      ),
                                    );
                                  }
                                  return const Center(
                                    child: Text(
                                      "اختر الفرع ثم الصنف لعرض الوجبات 🍽️",
                                      style:
                                      TextStyle(color: AppColors.grey1),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
