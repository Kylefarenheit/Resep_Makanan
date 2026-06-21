import 'package:flutter/material.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  // Perbaikan: gunakan List<Map<String, String>> dengan benar
  final List<Map<String, String>> _ingredients = [
    {'name': 'Ayam', 'quantity': '250gr'},
    {'name': 'Wortel', 'quantity': '150gr'},
    {'name': 'Item name', 'quantity': 'Quantity'},
  ];

  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _servesController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recipeNameController.text = 'Ayam Sayur';
    _servesController.text = '01';
    _cookingTimeController.text = '45 min';
  }

  @override
  void dispose() {
    _recipeNameController.dispose();
    _servesController.dispose();
    _cookingTimeController.dispose();
    super.dispose();
  }

  void _addNewIngredient() {
    setState(() {
      _ingredients.add({'name': 'Item name', 'quantity': 'Quantity'});
    });
  }

  void _updateIngredient(int index, String field, String value) {
    setState(() {
      _ingredients[index][field] = value;
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Buat Resep',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecipeNameSection(),
            const SizedBox(height: 24),
            _buildServesAndTimeSection(),
            const SizedBox(height: 32),
            _buildIngredientsSection(),
            const SizedBox(height: 24),
            _buildAddIngredientButton(),
            const SizedBox(height: 32),
            _buildSaveButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nama Resep',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _recipeNameController,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            hintText: 'Masukkan nama resep',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }

  Widget _buildServesAndTimeSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Serves',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        int currentValue = int.tryParse(_servesController.text) ?? 1;
                        if (currentValue > 1) {
                          _servesController.text = (currentValue - 1).toString().padLeft(2, '0');
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.remove, size: 20),
                      constraints: const BoxConstraints(minWidth: 32),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _servesController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        int currentValue = int.tryParse(_servesController.text) ?? 1;
                        _servesController.text = (currentValue + 1).toString().padLeft(2, '0');
                        setState(() {});
                      },
                      icon: const Icon(Icons.add, size: 20),
                      constraints: const BoxConstraints(minWidth: 32),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'waktu masak',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cookingTimeController,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '45 min',
                          isDense: true,
                        ),
                      ),
                    ),
                    const Icon(Icons.access_time, size: 20, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: const [
              Expanded(flex: 2, child: Text('Bahan', style: TextStyle(fontWeight: FontWeight.w500))),
              Expanded(flex: 1, child: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.w500))),
              SizedBox(width: 40),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _ingredients.length,
          itemBuilder: (context, index) {
            return _buildIngredientRow(index);
          },
        ),
      ],
    );
  }

  Widget _buildIngredientRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(text: _ingredients[index]['name'] ?? ''),
                ),
                onChanged: (value) => _updateIngredient(index, 'name', value),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  isDense: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(text: _ingredients[index]['quantity'] ?? ''),
                ),
                onChanged: (value) => _updateIngredient(index, 'quantity', value),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  isDense: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _removeIngredient(index),
            child: Container(
              width: 36,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.close, size: 18, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddIngredientButton() {
    return GestureDetector(
      onTap: _addNewIngredient,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 20, color: Colors.red),
            SizedBox(width: 8),
            Text(
              'Add new ingredient',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Simpan Resep?'),
            content: Text('Apakah Anda yakin ingin menyimpan resep "${_recipeNameController.text}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Resep berhasil disimpan!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Simpan Resepku',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}