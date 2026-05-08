import 'package:flutter/material.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';

class RequestView extends StatelessWidget {
  const RequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomAppBar(
                title: 'الـــطـــلـــبـــات',
                firstIcon: Icons.search,
                secondIcon: Icons.add,
              ),
            ],
          ),
        ),
      ),
    );
  }
}