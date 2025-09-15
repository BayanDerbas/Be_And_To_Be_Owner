import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/branches/domain/entities/branch_entity.dart';
import 'package:untitled/features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import 'package:untitled/features/categories/presentation/widgets/CustomCategoriesHeaderRow.dart';
import 'package:untitled/features/categories/presentation/widgets/CustomCategoriesTile.dart';
import 'package:untitled/features/categories/presentation/widgets/CustomEditCategoriesDialog.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart' as di;
import '../cubits/categories_cubit.dart';
import '../widgets/CustomAddCategoriesDialog.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CategoriesCubit>()),
        BlocProvider(create: (_) => di.sl<BranchCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.smooky,
              title: const Text(
                'Categories',
                style: TextStyle(color: AppColors.amber),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.amber,
              onPressed: () {
                final nameController = TextEditingController();

                showDialog(
                  context: context,
                  builder: (context) {
                    XFile? pickedImage;
                    BranchEntity? selectedBranch;

                    return StatefulBuilder(
                      builder: (context, setState) {
                        return BlocBuilder<BranchCubit, BranchState>(
                          builder: (context, state) {
                            if (state is BranchLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is BranchSuccess) {
                              final branches = state.branches.branches;

                              return CustomAddCategoriesDialog(
                                nameController: nameController,
                                pickedImagePath: pickedImage,
                                onPickImage: () async {
                                  final picker = ImagePicker();
                                  final picked = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (picked != null) {
                                    setState(() {
                                      pickedImage = picked; // XFile
                                    });
                                  }
                                },
                                branches: branches,
                                selectedBranch: selectedBranch,
                                onBranchSelected: (branch) {
                                  setState(() {
                                    selectedBranch = branch;
                                  });
                                },
                                onAdd: () {
                                  if (pickedImage != null &&
                                      selectedBranch != null) {
                                    context.read<CategoriesCubit>().addCategory(
                                      nameController.text,
                                      selectedBranch!.id,
                                      pickedImage!,
                                    );
                                    context.pop();
                                  }
                                },
                              );
                            } else if (state is BranchesFailure) {
                              return AlertDialog(
                                backgroundColor: AppColors.smooky,
                                title: const Text("خطأ",
                                    style: TextStyle(color: Colors.red)),
                                content: Text(state.message,
                                    style:
                                    const TextStyle(color: Colors.white)),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        );
                      },
                    );
                  },
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
            body: Column(
              children: [
                const CustomCategoriesHeaderRow(),
                Expanded(
                  child: BlocListener<CategoriesCubit, CategoriesState>(
                    listener: (context, state) {
                      if (state is CategoriesSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Category added successfully ✅}")),
                        );
                      } else if (state is CategoriesFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to add category ❌\n${state.message} ")),
                        );
                      }
                    },
                    child: BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesSuccess) {
                          final categories = state.categories;
                          return ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return CustomCategoriesTile(
                                name: category['name'] ?? '',
                                image: category['image'] ?? 'assets/images/pizza.png',
                                branch: category['branch'] ?? '',
                                onEdit: () {},
                                onDelete: () {},
                              );
                            },
                          );
                        }
                        return const Center(child: Text("Main Categories🥪"));
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
