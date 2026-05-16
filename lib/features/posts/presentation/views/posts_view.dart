import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';
import 'package:wafer/features/posts/presentation/manager/cubit/posts_cubit.dart';
import 'package:wafer/features/posts/presentation/manager/cubit/posts_state.dart';
import 'widgets/custom_card.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  int role = -1;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    role = prefs.getInt('accountType') ?? -1;
  });
  print('Role loaded: $role');
}

  String _getCategoryName(int category) {
    switch (category) {
      case 0:
        return 'مواد غذائية';
      case 1:
        return 'ملابس';
      case 2:
        return 'أدوية';
      case 3:
        return 'أثاث';
      default:
        return 'أخرى';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsCubit()..getPosts(),
      child: Scaffold(
        backgroundColor: AppColors.logohHaderColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// Header
                CustomAppBar(
                  title: 'المنشورات !',
                  firstIcon: Icons.add,
                  secondIcon: Icons.notifications_none,
                ),

                const SizedBox(height: 20),

                /// Filter
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BlocBuilder<PostsCubit, PostsState>(
                        builder: (context, state) {
                          return DropdownButton<int?>(
                            value: null,
                            underline: const SizedBox(),
                            style: Styles.textStyle14,
                            items: const [
                              DropdownMenuItem(
                                value: null,
                                child: Text("جميع المنشورات"),
                              ),
                              DropdownMenuItem(
                                value: 0,
                                child: Text("قيد المراجعة"),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text("مقبولة"),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text("مرفوضة"),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text("مكتملة"),
                              ),
                            ],
                            onChanged: (value) {
                              context
                                  .read<PostsCubit>()
                                  .getPosts(status: value);
                                  },
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "عرض المنشورات :",
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                /// List
                Expanded(
                  child: BlocConsumer<PostsCubit, PostsState>(
                    listener: (context, state) {
                      if (state is PostsApplySuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم التقدم بنجاح!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else if (state is PostsError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is PostsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryText,
                          ),
                        );
                      }

                      if (state is PostsSuccess) {
                        if (state.posts.isEmpty) {
                          return Center(
                            child: Text(
                              'لا توجد منشورات',
                              style: Styles.textStyle16,
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            final post = state.posts[index];
                            return CustomCard(
                              title: post.charityName ?? post.productName ?? '',
                              category: _getCategoryName(post.category ?? 0),
                              description: post.description ?? '',
                              imagePath: post.imageUrl,
                              time: post.createdAt ?? '',
                              status: post.status,
                              postId: post.id,
                              onFulfill: role == 0
                                  ? () {
                                      context
                                          .read<PostsCubit>()
                                          .fulfillPost(post.id!);
                                    }
                                  : null,
                              onApply: role == 1
                                  ? () {
                                      context
                                          .read<PostsCubit>()
                                          .applyToPost(post.id!);
                                    }
                                  : null,
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}