import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/features/offers/data/models/offer_model.dart';

class OfferCard extends StatefulWidget {
  final OfferModel offer;

  const OfferCard({super.key, required this.offer});

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  bool isTaken = false;

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// العنوان + الصورة
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: offer.productImage != null
                      ? NetworkImage(offer.productImage!)
                      : null,
                  child: offer.productImage == null
                      ? const Icon(Icons.image)
                      : null,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    offer.donorOrganizationName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// التفاصيل
            Text(
              'المنتج: ${offer.productName}',
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 6),

            Text(
              'الكمية: ${offer.quantity}',
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 6),

            Text(
              'المحافظة: ${offer.governorate ?? "غير محدد"}',
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 6),

            Text(
              'تاريخ الانتهاء: ${offer.expiryDate}',
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 16),

            /// حالة الحصول على العرض
            if (isTaken)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: const Center(
                  child: Text(
                    'تم الحصول على العرض',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            /// الزرار
            if (!isTaken)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isTaken = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryText,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'الحصول على العرض',
                    style: TextStyle(
                      color: AppColors.fourthText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:wafer/core/utils/app_colors.dart';
// import 'package:wafer/features/offers/data/models/offer_model.dart';

// class OfferCard extends StatelessWidget {
//   final OfferModel offer;

//   const OfferCard({super.key, required this.offer});

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Container(
//         margin: const EdgeInsets.all(12),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// العنوان + صورة صغيرة
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 18,
//                   backgroundColor: Colors.grey.shade200,
//                   backgroundImage: offer.productImage != null
//                       ? NetworkImage(offer.productImage!)
//                       : null,
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     offer.donorOrganizationName,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 10),

//             /// التفاصيل
//             Text('المنتج: ${offer.productName}'),
//             Text('الكمية: ${offer.quantity}'),
//             Text('المحافظة: ${offer.governorate ?? "غير محدد"}'),
//             Text('تاريخ الانتهاء: ${offer.expiryDate}'),

//             const SizedBox(height: 12),

//             /// زرار
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryText,
//                 ),
//                 child: const Text(
//                   'الحصول على العرض',
//                   style: TextStyle(color: AppColors.fourthText),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
