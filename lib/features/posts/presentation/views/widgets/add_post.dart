import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCharityNeedSheet extends StatefulWidget {
  const AddCharityNeedSheet({super.key});

  @override
  State<AddCharityNeedSheet> createState() => _AddCharityNeedSheetState();
}

class _AddCharityNeedSheetState extends State<AddCharityNeedSheet> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  int? _selectedCategory;
  int? _selectedUnit;
  int? _selectedPriority;
  File? _productImage;

  // TODO: جيب القيم دي من الـ API أو حطها static
  final List<Map<String, dynamic>> _categories = [
    {'id': 1, 'name': 'غذاء'},
    {'id': 2, 'name': 'ملابس'},
    {'id': 3, 'name': 'أدوية'},
  ];

  final List<Map<String, dynamic>> _units = [
    {'id': 6, 'name': 'كيلو'},
    {'id': 7, 'name': 'قطعة'},
    {'id': 8, 'name': 'لتر'},
  ];

  final List<Map<String, dynamic>> _priorities = [
    {'id': 1, 'name': 'منخفضة'},
    {'id': 2, 'name': 'متوسطة'},
    {'id': 3, 'name': 'عالية'},
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _productImage = File(picked.path));
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null ||
        _selectedUnit == null ||
        _selectedPriority == null) {
      // TODO: اعرض snackbar للـ user
      return;
    }

    // TODO: استدعي الـ Cubit هنا
    // context.read<PostsCubit>().createCharityNeed(
    //   category: _selectedCategory!,
    //   productName: _productNameController.text,
    //   quantity: double.parse(_quantityController.text),
    //   unit: _selectedUnit!,
    //   priority: _selectedPriority!,
    //   description: _descriptionController.text,
    //   productImagePath: _productImage?.path,
    // );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  const Text(
                    'إضافة احتياج جديد',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),

                  // Category
                  _buildDropdown(
                    label: 'الفئة',
                    value: _selectedCategory,
                    items: _categories,
                    onChanged: (v) => setState(() => _selectedCategory = v),
                  ),
                  const SizedBox(height: 14),

                  // Product Name
                  _buildTextField(
                    label: 'اسم المنتج',
                    controller: _productNameController,
                    validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                  ),
                  const SizedBox(height: 14),

                  // Quantity + Unit
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'الكمية',
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildDropdown(
                          label: 'الوحدة',
                          value: _selectedUnit,
                          items: _units,
                          onChanged: (v) => setState(() => _selectedUnit = v),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Priority
                  _buildDropdown(
                    label: 'الأولوية',
                    value: _selectedPriority,
                    items: _priorities,
                    onChanged: (v) => setState(() => _selectedPriority = v),
                  ),
                  const SizedBox(height: 14),

                  // Description
                  _buildTextField(
                    label: 'الوصف',
                    controller: _descriptionController,
                    maxLines: 3,
                    validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                  ),
                  const SizedBox(height: 14),

                  // Image Picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _productImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _productImage!,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 28,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'إضافة صورة (اختياري)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Submit
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D9E75),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'نشر الاحتياج',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required int? value,
    required List<Map<String, dynamic>> items,
    required ValueChanged<int?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        DropdownButtonFormField<int>(
          value: value,
          items: items
              .map(
                (e) => DropdownMenuItem<int>(
                  value: e['id'] as int,
                  child: Text(e['name'] as String),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }
}
