import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/networks/api_constant.dart';
import 'package:untitled/features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'package:untitled/features/categories/presentation/cubits/delete_category/delete_category_cubit.dart';
import 'package:untitled/features/categories/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:untitled/features/categories/presentation/widgets/CustomCategoriesHeaderRow.dart';
import 'package:untitled/features/categories/presentation/widgets/CustomCategoriesTile.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/CustomDropDown.dart';
import '../cubits/add_category/categories_cubit.dart';
import '../widgets/CustomAddCategoriesDialog.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final branchCubit = context.read<BranchCubit>();
    final categoriesCubit = context.read<CategoriesCubit>();
    final getCategoriesCubit = context.read<GetCategoriesCubit>();
    final deleteCategory = context.read<DeleteCategoryCubit>();

    return Scaffold(
      backgroundColor: AppColors.smooky,
      appBar: AppBar(
        backgroundColor: AppColors.smooky,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الأصناف',
            style: TextStyle(color: AppColors.amber, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.amber,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          final nameController = TextEditingController();

          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: branchCubit,
                child: CustomAddCategoriesDialog(
                  nameController: nameController,
                  branches: branchCubit.branches,
                  onBranchSelected: (branch) {
                    branchCubit.selectBranch(branch);
                  },
                  onAdd: (name, image, branch) {
                    categoriesCubit.addCategory(name, branch.id, image);
                  },
                ),
              );
            },
          );
        },
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
                    children: [
                      BlocBuilder<BranchCubit, BranchState>(
                        builder: (context, state) {
                          if (state is BranchLoading) return const SizedBox.shrink();
                          if (state is BranchSuccess || state is BranchSelected) {
                            final branches = branchCubit.branches;
                            return CustomDropDown(
                              value: branchCubit.selectedBranch,
                              hintText: "اختر الفرع",
                              items: branches,
                              getLabel: (branch) => branch.branch_name ?? "بدون اسم",
                              onChanged: (branch) {
                                branchCubit.selectBranch(branch);
                                if (branch != null) getCategoriesCubit.fetchCategories(branch.id);
                              },
                            );
                          }
                          if (state is BranchesFailure) {
                            return Text(
                              "فشل تحميل الفروع: ${state.message}",
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      SizedBox(height: 20.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: ResponsiveConfig.of(context).isMobile
                              ? 900
                              : ResponsiveConfig.of(context).isTablet
                              ? 1100
                              : MediaQuery.of(context).size.width * 0.75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomCategoriesHeaderRow(),
                              SizedBox(height: 10.h),
                              ExpandedSection(
                                child: MultiBlocListener(
                                  listeners: [
                                    BlocListener<CategoriesCubit, CategoriesState>(
                                      listener: (context, state) {
                                        if (state is CategoriesSuccess) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("تمت إضافة الصنف بنجاح ✅")),
                                          );
                                          final branchId = branchCubit.selectedBranch?.id;
                                          if (branchId != null) getCategoriesCubit.fetchCategories(branchId);
                                        }
                                        if (state is CategoriesFailure) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("فشل في إضافة الصنف ❌\n${state.message}")),
                                          );
                                        }
                                      },
                                    ),
                                    BlocListener<DeleteCategoryCubit, DeleteCategoryState>(
                                      listener: (context, state) {
                                        if (state is DeleteCategorySuccess) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("تم حذف الصنف بنجاح ✅")),
                                          );
                                          final branchId = branchCubit.selectedBranch?.id;
                                          if (branchId != null) getCategoriesCubit.fetchCategories(branchId);
                                        }
                                        if (state is DeleteCategoryFailure) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("فشل في حذف الصنف ❌\n${state.message}")),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                  child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                                    builder: (context, state) {
                                      if (state is GetCategoriesLoading) {
                                        return const Center(child: CircularProgressIndicator());
                                      }

                                      if (state is GetCategoriesSuccess) {
                                        final categories = state.categories;

                                        if (categories.isEmpty) {
                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Text(
                                                "لا توجد أصناف لهذا الفرع.",
                                                style: TextStyle(color: AppColors.grey1),
                                              ),
                                            ),
                                          );
                                        }

                                        return RefreshIndicator(
                                          onRefresh: () async {
                                            final branchId = branchCubit.selectedBranch?.id;
                                            if (branchId != null) await getCategoriesCubit.fetchCategories(branchId);
                                          },
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: categories.length,
                                            itemBuilder: (context, index) {
                                              final category = categories[index];
                                              return Card(
                                                color: AppColors.smooky2,
                                                margin: EdgeInsets.symmetric(vertical: 6.h),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12.r),
                                                ),
                                                child: CustomCategoriesTile(
                                                  name: category.name ?? '',
                                                  image: '${ApiConstant.imageBase}${category.image}',
                                                  branch: branchCubit.selectedBranch?.branch_name ?? '—',
                                                  onDelete: () => deleteCategory.deleteCategory(category.id!),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }

                                      if (state is GetCategoriesFailure) {
                                        return const Center(
                                          child: Text(
                                            "فشل في تحميل الأصناف ❌",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        );
                                      }

                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            "يرجى اختيار فرع 🍴",
                                            style: TextStyle(color: AppColors.grey1),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
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

class ExpandedSection extends StatelessWidget {
  final Widget child;
  const ExpandedSection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: const BoxConstraints(),
          child: child,
        );
      },
    );
  }
}
