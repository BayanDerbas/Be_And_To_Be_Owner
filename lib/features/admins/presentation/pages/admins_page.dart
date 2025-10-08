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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../branches/presentation/cubits/get_branches/branch_cubit.dart';
import '../../../branches/domain/usecases/branches_usecase.dart';
import '../../domain/entities/admin_entity.dart'; // <--- استخدام Entity
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
        // 1. حقن AdminCubit واستدعاء fetchAdmins()
        BlocProvider(create: (_) => sl<AdminCubit>()..fetchAdmins()),
        BlocProvider(create: (_) => BranchCubit(sl<BranchesUseCase>())..fetchBranches()),
      ],
      child: Builder(builder: (context) {
        final adminCubit = context.read<AdminCubit>();
        final branchCubit = context.read<BranchCubit>();

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
                      // افتراض أن branch_name هو الاسم الصحيح في BranchModel
                      final branchName = branchCubit.selectedBranch!.branch_name;
                      // يجب تحديث adminCubit.addAdmin لاستخدام الـ Entity
                      // adminCubit.addAdmin(nameController.text, phoneController.text, branchName);

                      // استخدام دالة مساعدة مؤقتة للـ Local Add
                      // adminCubit.addAdminLocally(AdminEntity(
                      //   id: DateTime.now().millisecondsSinceEpoch,
                      //   fullname: nameController.text,
                      //   phonenumber: phoneController.text,
                      //   branchName: branchName,
                      //   branchImage: '', // يجب تعويض هذه القيمة من الفرع
                      // )
                      // );
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

                            onEdit: () {
                              final nameController = TextEditingController(text: admin.fullname);
                              final phoneController = TextEditingController(text: admin.phonenumber);
                              final passwordController = TextEditingController();

                              showDialog(
                                context: context,
                                builder: (_) => BlocBuilder<BranchCubit, BranchState>(
                                  builder: (context, branchState) {
                                    return CustomEditAdminDialog(
                                      nameController: nameController,
                                      phoneController: phoneController,
                                      branches: branchCubit.branches,
                                      selectedBranch: branchCubit.selectedBranch,
                                      onBranchSelected: branchCubit.selectBranch,
                                      branchController: TextEditingController(text: admin.branchName),
                                      onSave: () {
                                        final branchName = branchCubit.selectedBranch?.branch_name ?? admin.branchName;
                                        // adminCubit.editAdminLocally(
                                        //     index,
                                        //     AdminEntity(
                                        //       id: admin.id,
                                        //       fullname: nameController.text,
                                        //       phonenumber: phoneController.text,
                                        //       branchName: branchName,
                                        //       branchImage: admin.branchImage,
                                        //     )
                                        // );

                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                            // 5. استخدام index للحذف (للتوافق مع دالة deleteAdminLocally)
                            onDelete: () => adminCubit.deleteAdminLocally(index),
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
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../branches/presentation/cubits/get_branches/branch_cubit.dart';
// import '../../../branches/domain/usecases/branches_usecase.dart';
// import '../../presentation/cubits/admin_cubit.dart';
// import '../widgets/CustomAddAdminDialog.dart';
// import '../widgets/CustomAdminHeaderRow.dart';
// import '../widgets/CustomAdminTile.dart';
// import '../widgets/CustomEditAdminDialog.dart';
// import '../../../../core/di/injection.dart';
//
// class AdminsPage extends StatelessWidget {
//   const AdminsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => AdminCubit()),
//         BlocProvider(create: (_) => BranchCubit(sl<BranchesUseCase>())..fetchBranches()),
//       ],
//       child: Builder(builder: (context) {
//         final adminCubit = context.read<AdminCubit>();
//         final branchCubit = context.read<BranchCubit>();
//
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.smooky,
//             title: const Text('الادارة', style: TextStyle(color: AppColors.white)),
//           ),
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: AppColors.amber,
//             onPressed: () {
//               final nameController = TextEditingController();
//               final phoneController = TextEditingController();
//               final passwordController = TextEditingController();
//               showDialog(
//                 context: context,
//                 builder: (_) => CustomAddAdminDialog(
//                   nameController: nameController,
//                   phoneController: phoneController,
//                   passwordController: passwordController,
//                   branches: branchCubit.branches,
//                   selectedBranch: branchCubit.selectedBranch,
//                   onBranchSelected: branchCubit.selectBranch,
//                   onAdd: () {
//                     if (branchCubit.selectedBranch != null) {
//                       final branchName = branchCubit.selectedBranch!.branch_name;
//                       // adminCubit.addAdmin(nameController.text, phoneController.text, branchName.toString());
//                     }
//                     context.pop();
//                   },
//                 ),
//               );
//             },
//             child: const Icon(Icons.add, color: Colors.white),
//           ),
//           body: Column(
//             children: [
//               const CustomAdminHeaderRow(),
//               Expanded(
//                 child: BlocBuilder<AdminCubit, AdminState>(
//                   builder: (context, state) {
//                     if (state is AdminSuccess) {
//                       return ListView.builder(
//                         itemCount: state.admins.length,
//                         itemBuilder: (context, index) {
//                           final admin = state.admins[index];
//                           return CustomAdminTile(
//                             // name: admin['name']!,
//                             // phone: admin['phone']!,
//                             // password: admin['password'] ?? '',
//                             // branch: admin['branch'] ?? '',
//                             onEdit: () {
//                               final nameController = TextEditingController(text: admin['name']);
//                               final phoneController = TextEditingController(text: admin['phone']);
//                               final passwordController = TextEditingController();
//
//                               showDialog(
//                                 context: context,
//                                 builder: (_) => BlocBuilder<BranchCubit, BranchState>(
//                                   builder: (context, state) {
//                                     return CustomEditAdminDialog(
//                                       nameController: nameController,
//                                       phoneController: phoneController,
//                                       passwordController: passwordController,
//                                       branches: branchCubit.branches,
//                                       selectedBranch: branchCubit.selectedBranch,
//                                       onBranchSelected: branchCubit.selectBranch,
//                                       branchController: TextEditingController(text: admin['branch'] ?? ''),
//                                       onSave: () {
//                                         final branchName = branchCubit.selectedBranch?.branch_name ?? admin['branch'] ?? '';
//                                         adminCubit.editAdmin(index, nameController.text, phoneController.text, branchName);
//                                         Navigator.pop(context);
//                                       },
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                             onDelete: () => adminCubit.deleteAdmin(index),
//                           );
//                         },
//                       );
//                     }
//                     return const Center(child: CircularProgressIndicator());
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
// fetch the page plz