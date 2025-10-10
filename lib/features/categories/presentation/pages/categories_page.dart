import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/core/networks/api_constant.dart';
import 'package:untitled/features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'package:untitled/features/categories/presentation/cubits/get_categories/get_categories_cubit.dart';
import 'package:untitled/features/categories/presentation/widgets/CustomCategoriesHeaderRow.dart';
import 'package:untitled/features/categories/presentation/widgets/CustomCategoriesTile.dart';
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

    return Scaffold(
      backgroundColor: AppColors.smooky,
      appBar: AppBar(
        backgroundColor: AppColors.smooky,
        title: const Text(
          'الأصناف',
          style: TextStyle(color: AppColors.amber, fontSize: 20),
        ),
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.amber,
        onPressed: () {
          final nameController = TextEditingController();
          XFile? pickedImage;

          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: branchCubit,
                child: CustomAddCategoriesDialog(
                  nameController: nameController,
                  pickedImagePath: pickedImage,
                  onPickImage: () async {
                    final picker = ImagePicker();
                    final picked = await picker.pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      pickedImage = picked;
                    }
                  },
                  branches: branchCubit.branches,
                  selectedBranch: branchCubit.selectedBranch,
                  onBranchSelected: (branch) {
                    branchCubit.selectBranch(branch);
                  },
                  onAdd: () {
                    if (pickedImage != null && branchCubit.selectedBranch != null) {
                      categoriesCubit.addCategory(
                        nameController.text,
                        branchCubit.selectedBranch!.id,
                        pickedImage!,
                      );
                      context.pop();
                    }
                  },
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            BlocBuilder<BranchCubit, BranchState>(
              builder: (context, state) {
                if (state is BranchLoading) {
                  return const SizedBox.shrink();
                } else if (state is BranchSuccess || state is BranchSelected) {
                  final branches = branchCubit.branches;

                  return CustomDropDown(
                    value: branchCubit.selectedBranch, // 👈 stays persistent
                    hintText: "اختر الفرع",
                    items: branches,
                    getLabel: (branch) => branch.branch_name ?? "بدون اسم",
                    onChanged: (branch) {
                      branchCubit.selectBranch(branch);
                      if (branch != null) {
                        getCategoriesCubit.fetchCategories(branch.id);
                      }
                    },
                  );
                } else if (state is BranchesFailure) {
                  return Text(
                    "فشل تحميل الفروع: ${state.message}",
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            SizedBox(height: 10.h),
            CustomCategoriesHeaderRow(),
            SizedBox(height: 20.h),

            Expanded(
              child: BlocListener<CategoriesCubit, CategoriesState>(
                listener: (context, state) {
                  if (state is CategoriesSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("تمت إضافة الصنف بنجاح ✅")),
                    );
                  } else if (state is CategoriesFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("فشل في إضافة الصنف ❌\n${state.message}")),
                    );
                  }
                },
                child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                  builder: (context, state) {
                    if (state is GetCategoriesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetCategoriesSuccess) {
                      final categories = state.categories;
                      if (categories.isEmpty) {
                        return const Center(
                          child: Text("لا توجد أصناف لهذا الفرع.",
                              style: TextStyle(color: AppColors.grey1)),
                        );
                      }
                      return ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Card(
                            color: AppColors.smooky2,
                            margin: EdgeInsets.symmetric(vertical: 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: CustomCategoriesTile(
                              name: category.name ?? '',
                              image: '${ApiConstant.imageBase}${category.image}',
                              branch: branchCubit.selectedBranch?.branch_name ?? '—',
                              onEdit: () {},
                              onDelete: () {},
                            ),
                          );
                        },
                      );
                    } else if (state is GetCategoriesFailure) {
                      return const Center(
                        child: Text("فشل في تحميل الأصناف ❌",
                            style: TextStyle(color: Colors.red)),
                      );
                    }
                    return const Center(
                      child: Text("يرجى اختيار فرع 🍴",
                          style: TextStyle(color: AppColors.grey1)),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
