import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String category;
  final String description;
  final String? imagePath;
  final String time;
  final int? status;
  final String? postId;
  final VoidCallback? onFulfill;
  final VoidCallback? onApply;

  const CustomCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    this.imagePath,
    required this.time,
    this.status,
    this.postId,
    this.onFulfill,
    this.onApply,
  });

  String _formatDate(String date) {
    try {
      final DateTime dt = DateTime.parse(date);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (e) {
      return date;
    }
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return 'قيد المراجعة';
      case 1:
        return 'مقبولة';
      case 2:
        return 'مرفوضة';
      case 3:
        return 'مكتملة';
      default:
        return '';
    }
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      case 3:
        return AppColors.primaryText;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: imagePath != null
                    ? NetworkImage(imagePath!)
                    : const AssetImage('assets/images/test.png')
                          as ImageProvider,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Styles.textStyle18),
                    const SizedBox(height: 3),
                    Text(
                      _formatDate(time),
                      style: Styles.textStyle14.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Category
          Text(
            category,
            textAlign: TextAlign.right,
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),

          const SizedBox(height: 8),

          /// Description
          Text(
            description,
            textAlign: TextAlign.right,
            style: Styles.textStyle14.copyWith(
              color: Colors.grey.shade800,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 10),
          Text(
            "عرض المزيد",
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryText,
            ),
          ),

          /// Status Badge
          if (status != null) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(status!).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _getStatusColor(status!)),
                ),
                child: Text(
                  _getStatusText(status!),
                  style: Styles.textStyle14.copyWith(
                    color: _getStatusColor(status!),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],

          /// Fulfill Button - للـ Charity لما status == 1
          if (status == 1 && onFulfill != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onFulfill,
                child: Text(
                  'تم الاستلام - مكتملة',
                  style: Styles.textStyle14.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],

          /// Apply Button - للـ Donor
          if (onApply != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onApply,
                child: Text(
                  'تقدم الآن',
                  style: Styles.textStyle14.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
