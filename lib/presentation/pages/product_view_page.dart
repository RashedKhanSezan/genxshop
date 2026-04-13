import 'package:flutter/material.dart';
import 'package:genxshop/presentation/controllers/product_controller.dart';
import 'package:genxshop/routes/app_routes.dart';
import 'package:get/get.dart';
import '../../data/models/product_model.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    if (args == null || args is! ProductModel) {
      return const Scaffold(body: Center(child: Text("No product data found")));
    }

    final ProductModel product = args;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(product),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSection(product),
                    const SizedBox(height: 20),
                    _buildHeader(product),
                    const SizedBox(height: 10),
                    const Divider(
                        color: Colors.grey, thickness: 0.5, height: 30),
                    _buildTagsSection(product),
                    const SizedBox(height: 24),
                    _buildDescription(product),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _buildBottomButton(product),
    );
  }

  Widget _buildAppBar(ProductModel product) {
    final productController = Get.find<ProductController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
            style: IconButton.styleFrom(backgroundColor: Colors.grey.shade100),
          ),
          const Text(
            "Service Detail",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Delete Product",
                middleText: "Are you sure you want to delete this product?",
                textConfirm: "Delete",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back();
                  productController.deleteProduct(product.id);
                  Get.back();
                },
                textCancel: "Cancel",
              );
            },
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            style: IconButton.styleFrom(backgroundColor: Colors.red.shade50),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(ProductModel product) {
    const String defaultImageUrl =
        "https://kiwiears.com/cdn/shop/products/kiwiears-1.webp?v=1673340882&width=823";

    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(product.image ?? defaultImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              product.category.toUpperCase(),
              style: const TextStyle(
                  color: Colors.indigo,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      product.isActive ? "active" : "inactive",
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "\$${product.price}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.check, color: Colors.green, size: 16),
                const SizedBox(width: 4),
                Text(
                  product.stock > 0 ? "In Stock" : "Out of Stock",
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (product.isDiscounted)
              Text(
                "Discount: ${product.discountPercent}%",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTagsSection(ProductModel product) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _customChip(product.category),
        _customChip(product.brand),
        _customChip("Stock: ${product.stock}"),
        ...product.tags.map((tag) => _customChip(tag)),
      ],
    );
  }

  Widget _customChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildDescription(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: TextStyle(color: Colors.grey.shade600, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildBottomButton(ProductModel product) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.productForm, arguments: product);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF246BFE),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: const Text(
            "Edit Product",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
