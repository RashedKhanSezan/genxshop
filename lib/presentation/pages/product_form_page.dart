import 'package:flutter/material.dart';
import 'package:genxshop/presentation/widgets/upload_box.dart';
import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../controllers/product_controller.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final name = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final brand = TextEditingController();
  final discount = TextEditingController();
  final stock = TextEditingController();

  final RxString selectedCategory = 'Electronics'.obs;
  final RxString selectedStatus = 'Active'.obs;
  ProductModel? product;
  final productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    product = Get.arguments as ProductModel?;
    if (product != null) {
      name.text = product!.name;
      description.text = product!.description;
      price.text = product!.price.toString();
      stock.text = product!.stock.toString();
      brand.text = product!.brand;
      discount.text = product!.discountPercent.toString();
      selectedCategory.value = product!.category;
      selectedStatus.value = product!.isActive ? 'Active' : 'Inactive';
    }
  }

  void _handleSubmit() {
    final Map<String, dynamic> productData = {
      "name": name.text.trim(),
      "description": description.text.trim(),
      "price": double.tryParse(price.text) ?? 0.0,
      "stock": int.tryParse(stock.text) ?? 0,
      "category": selectedCategory.value,
      "brand": brand.text.trim(),
      "isDiscounted": (int.tryParse(discount.text) ?? 0) > 0,
      "discountPercent": int.tryParse(discount.text) ?? 0,
      "isActive": selectedStatus.value == 'Active',
      "tags": ["audio", "gadget"],
      "image": product?.image ??
          "https://kiwiears.com/cdn/shop/products/kiwiears-1.webp?v=1673340882&width=823",
    };

    if (product == null) {
      productController.addProduct(productData);
    } else {
      productController.updateProduct(product!.id, productData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          product == null ? "Create Product" : "Edit Product",
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const UploadBox(),
            const SizedBox(height: 20),
            _buildInputField("Product Name", name, Icons.shopping_bag_outlined),
            _buildInputField(
                "Description", description, Icons.description_outlined,
                maxLines: 3),
            Row(
              children: [
                Expanded(
                    child: _buildInputField("Price", price, Icons.attach_money,
                        isNumber: true)),
                const SizedBox(width: 15),
                Expanded(
                    child: _buildInputField(
                        "Stock", stock, Icons.inventory_2_outlined,
                        isNumber: true)),
              ],
            ),
            _buildInputField("Brand", brand, Icons.branding_watermark_outlined),
            _buildInputField("Discount %", discount, Icons.percent,
                isNumber: true),
            const SizedBox(height: 10),
            const Text("Category",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 10),
            Obx(() => _buildDropdown(
                ['Electronics', 'Audio', 'Accessories'],
                selectedCategory.value,
                (val) => selectedCategory.value = val!)),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Obx(() => ElevatedButton(
                    onPressed: productController.isLoading.value
                        ? null
                        : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF246BFE),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: productController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            product == null ? "Create Product" : "Save Changes",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                  )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, IconData icon,
      {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF246BFE), size: 20),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFFF8F9FE),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF246BFE), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      List<String> items, String value, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
