import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CustomAppBar(
                  title: 'تعديل الملف الشخصي',
                  firstIcon: Icons.search,
                  secondIcon: Icons.notifications_outlined,
                ),

                const SizedBox(height: 20),

                /// Logo Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/misr_el_kheir_logo.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 16),

                /// Action Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red, size: 30),
                    const SizedBox(width: 24),
                    Icon(
                      Icons.edit_outlined,
                      color: AppColors.tertiaryText,
                      size: 30,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Username
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('اسم المستخدم', style: Styles.textStyle18),
                ),

                const SizedBox(height: 10),

                _buildTextField(hintText: 'مصر الخير_011'),

                const SizedBox(height: 6),

                const Text(
                  '(لا يمكن تغييره إلا بعد 30 يوم)',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.right,
                ),

                const SizedBox(height: 20),

                /// الجمعية
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('اسم الجمعية', style: Styles.textStyle18),
                ),

                const SizedBox(height: 10),

                _buildTextField(hintText: 'جمعية مصر الخير'),

                const SizedBox(height: 20),

                /// Phone
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('رقم الهاتف', style: Styles.textStyle18),
                ),

                const SizedBox(height: 10),

                _buildTextField(hintText: '010 xxxx xxxx'),

                const SizedBox(height: 20),

                /// Email
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('البريد الإلكتروني', style: Styles.textStyle18),
                ),

                const SizedBox(height: 10),

                _buildTextField(hintText: 'example@gmail.com'),
                const SizedBox(height: 20),

                /// Address
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('العنوان', style: Styles.textStyle18),
                ),

                const SizedBox(height: 10),

                _buildTextField(hintText: 'محور 79 - التجمع الخامس - القاهرة'),

                const SizedBox(height: 6),

                const Text(
                  '(لا يمكن تعديله)',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                  textAlign: TextAlign.right,
                ),

                const SizedBox(height: 24),

                /// Description Title
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('وصف الجمعية الخيرية', style: Styles.textStyle18),
                ),

                const SizedBox(height: 12),

                /// Description Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    'أنشئت مؤسسة مصر الخير عام 2007 بهدف الاستمرار لأكثر من 500 عام وذلك بالاستناد على هيكل مؤسسي لا يعتمد على الأشخاص بل على العمل المؤسسي، حيث تعمل بأحدث منهجيات العمل المؤسسي التنموي والحرفية من أجل تنمية الإنسان في خمس مجالات أساسية (التكافل الاجتماعي والتعليم والصحة والبحث العلمي ومناحي الحياة) تحت مظلة واحدة هي مؤسسة مصر الخير وتعتبر مؤسسة مصر الخير مؤسسة أهلية غير هادفة للربح مشهرة تحت رقم 555 لعام 2007 طبقاً لأحكام القانون رقم 84 لسنة 2002 وتهدف إلى خدمة وتطوير وتمكين المجتمع المصري من أجل العودة للحياة الكريمة في جميع ربوع مصر.',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.8,
                      color: AppColors.tertiaryText,
                    ),
                  ),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hintText}) {
    return TextField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.edit_outlined),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.primaryText),
        ),
      ),
    );
  }
}
