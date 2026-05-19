import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';

class RequestCard extends StatefulWidget {
  final String title;
  final String description;
  final String phone;
  final String location;

  const RequestCard({
    super.key,
    required this.title,
    required this.description,
    required this.phone,
    required this.location,
  });

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  String? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title Row
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/test.png'),
              ),
              const SizedBox(width: 10),
              Text(widget.title, style: Styles.textStyle18),
            ],
          ),

          const SizedBox(height: 10),

          /// Details
          Text("العرض: ${widget.description}", style: Styles.textStyle14),

          const SizedBox(height: 6),

          Text("· رقم التواصل: ${widget.phone}", style: Styles.textStyle14),

          const SizedBox(height: 6),

          Text("· الموقع: ${widget.location}", style: Styles.textStyle14),

          const SizedBox(height: 14),

          /// Status Container
          if (status != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              decoration: BoxDecoration(
                color: status == "تم قبول العرض"
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: status == "تم قبول العرض" ? Colors.green : Colors.red,
                ),
              ),
              child: Center(
                child: Text(
                  status!,
                  style: TextStyle(
                    color: status == "تم قبول العرض"
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

          if (status != null) const SizedBox(height: 14),

          /// Action Buttons
          if (status == null)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        status = "تم قبول العرض";
                      });
                    },
                    child: const Text(
                      "قبول",
                      style: TextStyle(
                        color: AppColors.fourthText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        status = "تم رفض العرض";
                      });
                    },
                    child: const Text(
                      "رفض",
                      style: TextStyle(
                        color: AppColors.fourthText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:wafer/core/utils/app_colors.dart';
// import 'package:wafer/core/utils/styles.dart';

// class RequestCard extends StatefulWidget {
//   final String title;
//   final String description;
//   final String phone;
//   final String location;

//   const RequestCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.phone,
//     required this.location,
//   });

//   @override
//   State<RequestCard> createState() => _RequestCardState();
// }

// class _RequestCardState extends State<RequestCard> {
//   String? status;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withValues(alpha: 0.15),
//             blurRadius: 8,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Title Row
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 24,
//                 backgroundImage: AssetImage('assets/images/test.png'),
//               ),
//               const SizedBox(width: 10),
//               Text(widget.title, style: Styles.textStyle18),
//             ],
//           ),

//           const SizedBox(height: 10),

//           /// Details
//           Text("العرض: ${widget.description}", style: Styles.textStyle14),
//           const SizedBox(height: 6),
//           Text("· رقم التواصل: ${widget.phone}", style: Styles.textStyle14),
//           const SizedBox(height: 6),
//           Text("· الموقع: ${widget.location}", style: Styles.textStyle14),

//           const SizedBox(height: 14),

//           /// Status Message
//           if (status != null)
//             Center(
//               child: Text(
//                 status!,
//                 style: TextStyle(
//                   color: status == "تم قبول العرض" ? Colors.green : Colors.red,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ),

//           if (status != null) const SizedBox(height: 14),

//           /// Action Buttons
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade700,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       status = "تم قبول العرض";
//                     });
//                   },
//                   child: const Text(
//                     "قبول",
//                     style: TextStyle(
//                       color: AppColors.fourthText,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(width: 10),

//               Expanded(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red.shade600,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       status = "تم رفض العرض";
//                     });
//                   },
//                   child: const Text(
//                     "رفض",
//                     style: TextStyle(
//                       color: AppColors.fourthText,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
