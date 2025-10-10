import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/config/animations/loading.dart';
import 'package:untitled/core/networks/api_constant.dart';
import 'package:untitled/features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'package:untitled/features/branches/presentation/widgets/CustomBranchesHeaderRow.dart';
import 'package:untitled/features/branches/presentation/widgets/CustomBranchesTile.dart';
import '../../../../core/constants/app_colors.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final branchCubit = context.read<BranchCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.smooky,
        title: const Text(
          'الفروع',
          style: TextStyle(color: AppColors.amber, fontSize: 20),
        ),
        elevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            children: [
              CustomBranchesHeaderRow(),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<BranchCubit, BranchState>(
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

                      return ListView.builder(
                        itemCount: branches.length,
                        itemBuilder: (context, index) {
                          final branch = branches[index];
                          final phoneNumbers = branch.phonenumbers
                              .map((n) => n.phone.toString())
                              .join('\n');
                          final hasValidLocation = branch.length != null &&
                              branch.width != null &&
                              branch.length != 0 &&
                              branch.width != 0;

                          final locationUrl = hasValidLocation
                              ? 'https://maps.google.com/?q=${branch.length},${branch.width}'
                              : '';
                          return Card(
                            color: AppColors.smooky2,
                            margin: EdgeInsets.symmetric(vertical: 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: CustomBranchesTile(
                              name: branch.branch_name ?? 'بدون اسم',
                              image: '${ApiConstant.imageBase}${branch.image}',
                              socialmedia:
                              '${branch.instagramtoken ?? ""}:Instagram\n${branch.facebooktoken ?? ""}:Facebook',
                              onDelete: () {},
                              location:locationUrl,
                              numbers: phoneNumbers,
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: Text(
                        "حدث خطأ في تحميل الفروع",
                        style: TextStyle(color: Colors.red),
                      ),
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
