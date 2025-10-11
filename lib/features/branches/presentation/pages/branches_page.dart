import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/config/animations/loading.dart';
import 'package:untitled/core/networks/api_constant.dart';
import 'package:untitled/features/branches/presentation/cubits/edit_branch/edit_branch_cubit.dart';
import 'package:untitled/features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'package:untitled/features/branches/presentation/widgets/CustomAddBranchDialog.dart';
import 'package:untitled/features/branches/presentation/widgets/CustomBranchesHeaderRow.dart';
import 'package:untitled/features/branches/presentation/widgets/CustomBranchesTile.dart';
import '../../../../core/constants/app_colors.dart';
import '../cubits/add_branch/add_branch_cubit.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final branchCubit = context.read<BranchCubit>();
    final addbranch = context.read<AddBranchCubit>();
    final editbranch = context.read<EditBranchCubit>();
    Future.microtask(() => branchCubit.fetchBranches());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.smooky,
        title: const Text(
          'الفروع',
          style: TextStyle(color: AppColors.amber, fontSize: 20),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.white, size: 30.r),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: addbranch,
                child: BlocListener<AddBranchCubit, AddBranchState>(
                  listener: (context, state) {
                    if (state is AddBranchSuccess) {
                      branchCubit.fetchBranches();
                      context.pop();
                    }
                  },
                  child: CustomAddBranchDialog(
                    onAdd: ({
                      required String name,
                      required String length,
                      required String width,
                      required String instagramtoken,
                      required String facebooktoken,
                      required List<String> phones,
                      required XFile image,
                    }) {
                      final double? parsedLength = double.tryParse(length);
                      final double? parsedWidth = double.tryParse(width);

                      if (name.isEmpty || parsedLength == null ||
                          parsedWidth == null || phones.isEmpty ||
                          image.path.isEmpty) {
                        return;
                      }
                      context.read<AddBranchCubit>().addBranch(
                        branchName: name,
                        image: image,
                        numbers: phones,
                        length: parsedLength,
                        width: parsedWidth,
                        facebooktoken: facebooktoken,
                        instagramtoken: instagramtoken,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            children: [
              const CustomBranchesHeaderRow(),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<EditBranchCubit, EditBranchState>(
                  builder: (context, state) {
                    return BlocBuilder<BranchCubit, BranchState>(
                      builder: (context, state) {
                        if (state is BranchLoading) {
                          return const Center(child: LoadinDount());
                        }

                        if (state is BranchSuccess) {
                          final branches = state.branches.branches;
                          if (branches.isEmpty) {
                            return const Center(
                              child: Text(
                                "لا يوجد فروع.",
                                style: TextStyle(color: AppColors.grey1),
                              ),
                            );
                          }

                          return RefreshIndicator(
                            onRefresh: () async {
                              await branchCubit.fetchBranches();
                            },
                            child: ListView.builder(
                              itemCount: branches.length,
                              itemBuilder: (context, index) {
                                final branch = branches[index];
                                final phoneNumbers = branch.phonenumbers
                                    .map((n) => n.phone.toString())
                                    .join('\n');

                                final hasValidLocation =
                                    branch.length != null &&
                                        branch.width != null &&
                                        branch.length != 0 &&
                                        branch.width != 0;

                                final locationUrl = hasValidLocation
                                    ? 'https://maps.google.com/?q=${branch
                                    .length},${branch.width}'
                                    : '';

                                return Card(
                                  color: AppColors.smooky2,
                                  margin: EdgeInsets.symmetric(vertical: 6.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: CustomBranchesTile(
                                    name: branch.branch_name ?? 'بدون اسم',
                                    image:
                                    '${ApiConstant.imageBase}${branch.image}',
                                    socialmediaInstagram:
                                    branch.instagramtoken ?? '',
                                    socialmediaFacebook:
                                    branch.facebooktoken ?? '',
                                    onEdit: () {
                                      final nameController = TextEditingController(text: branch.branch_name ?? '');

                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: editbranch,
                                            child: BlocListener<EditBranchCubit, EditBranchState>(
                                              listener: (context, state) {
                                                if (state is EditBranchSuccess) {
                                                  branchCubit.fetchBranches();
                                                  context.pop();
                                                } else if (state is EditBranchFailure) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('فشل التعديل: ${state.message}')),
                                                  );
                                                }
                                              },
                                              child: AlertDialog(
                                                backgroundColor: AppColors.smooky,
                                                title: Text(
                                                  "تعديل اسم الفرع",
                                                  style: TextStyle(color: AppColors.amber),
                                                  textAlign: TextAlign.end,
                                                ),
                                                content: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TextField(
                                                    controller: nameController,
                                                    style: const TextStyle(color: Colors.white),
                                                    decoration: const InputDecoration(
                                                      hintText: "الاسم الجديد",
                                                      hintStyle: TextStyle(color: AppColors.grey1),
                                                      filled: true,
                                                      fillColor: AppColors.smooky2,
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => context.pop(),
                                                    child: const Text(
                                                      "إلغاء",
                                                      style: TextStyle(color: AppColors.grey1),
                                                    ),
                                                  ),
                                                  BlocBuilder<EditBranchCubit, EditBranchState>(
                                                    builder: (context, state) {
                                                      if (state is EditBranchLoading) {
                                                        return const CircularProgressIndicator(color: AppColors.amber);
                                                      }
                                                      return ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: AppColors.amber,
                                                        ),
                                                        onPressed: () {
                                                          final newName = nameController.text.trim();
                                                          if (newName.isEmpty) return;

                                                          context.read<EditBranchCubit>().edit_branch(
                                                            new_name: newName,
                                                            branch_id: branch.id ?? 0,
                                                          );
                                                        },
                                                        child: const Text(
                                                          "حفظ",
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    location: locationUrl,
                                    numbers: phoneNumbers,
                                  ),
                                );
                              },
                            ),
                          );
                        }

                        return const Center(
                          child: Text(
                            "حدث خطأ في تحميل الفروع",
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
