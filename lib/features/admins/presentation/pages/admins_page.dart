import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../branches/presentation/cubits/get_branches/branch_cubit.dart';
import '../../../branches/domain/usecases/branches_usecase.dart';
import '../../domain/entities/admin_entity.dart';
import '../../presentation/cubits/admin_cubit.dart';
import '../widgets/CustomAddAdminDialog.dart';
import '../widgets/CustomAdminHeaderRow.dart';
import '../widgets/CustomAdminTile.dart';
import '../widgets/CustomEditAdminDialog.dart';
import '../../../../core/di/injection.dart';

class AdminsPage extends StatelessWidget {
  const AdminsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AdminCubit>()..fetchAdmins()),
        BlocProvider(create: (_) => BranchCubit(sl<BranchesUseCase>())..fetchBranches()),
      ],
      child: Builder(builder: (context) {
        final branchCubit = context.read<BranchCubit>();
        final adminCubit = context.read<AdminCubit>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.smooky,
            title: const Text('الادارة', style: TextStyle(color: AppColors.white)),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.amber,
            onPressed: () {
              final nameController = TextEditingController();
              final phoneController = TextEditingController();
              final passwordController = TextEditingController();
              showDialog(
                context: context,
                builder: (_) => CustomAddAdminDialog(
                  nameController: nameController,
                  phoneController: phoneController,
                  passwordController: passwordController,
                  branches: branchCubit.branches,
                  selectedBranch: branchCubit.selectedBranch,
                  onBranchSelected: branchCubit.selectBranch,
                  onAdd: () {
                    if (branchCubit.selectedBranch != null) {
                      final branchName = branchCubit.selectedBranch!.branch_name;
                      final selectedBranchId = branchCubit.selectedBranch!.id;
                      adminCubit.addAdmin(
                          fullname: nameController.text,
                          password: passwordController.text,
                          phonenumber: phoneController.text,
                          branch_id: selectedBranchId,
                      );
                    }
                    context.pop();
                  },
                ),
              );
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: Column(
            children: [
              const CustomAdminHeaderRow(),
              Expanded(
                child: BlocBuilder<AdminCubit, AdminState>(
                  builder: (context, state) {
                    if (state is AdminLoading || state is AdminInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is AdminError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }

                    if (state is AdminSuccess) {
                      return ListView.builder(
                        itemCount: state.admins.length,
                        itemBuilder: (context, index) {
                          final AdminEntity admin = state.admins[index];

                          return CustomAdminTile(
                            name: admin.fullname,
                            phone: admin.phonenumber,
                            branch: admin.branchName,
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}