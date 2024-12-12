import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'categorias_state.dart'; // Importe o arquivo do provider

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  final TextEditingController _categoryController = TextEditingController();
  IconData? _selectedIcon;

  final List<IconData> _iconList = [
    Ionicons.home,
    Ionicons.car,
    Ionicons.bicycle,
    Ionicons.body,
    Ionicons.star,
    Ionicons.heart,
    Ionicons.person,
    Ionicons.settings,
    Ionicons.camera,
    Ionicons.phone_portrait,
    Ionicons.cart,
    Ionicons.bookmark,
    Ionicons.calendar,
    Ionicons.aperture,
    Ionicons.airplane,
    Ionicons.game_controller,
    Ionicons.location,
    Ionicons.pizza,
    Ionicons.pulse,
    Ionicons.map,
    Ionicons.chatbubble,
    Ionicons.gift,
    Ionicons.fast_food,
    Ionicons.wallet,
    Ionicons.ribbon,
    Ionicons.hammer,
    Ionicons.moon,
    Ionicons.sunny,
    Ionicons.cube,
    Ionicons.cloud,
    Ionicons.code,
    Ionicons.cog,
    Ionicons.umbrella,
    Ionicons.business,
    Ionicons.trending_up,
    Ionicons.earth,
    Ionicons.mic,
    Ionicons.battery_full,
    Ionicons.pencil,
    Ionicons.clipboard,
    Ionicons.tv,
    Ionicons.headset,
    Ionicons.paw,
  ];

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _addCategory(BuildContext context) {
    if (_categoryController.text.isEmpty) {
      _showSnackBar(context, "Por favor, insira um nome para a categoria.");
      return;
    }
    if (_selectedIcon == null) {
      _showSnackBar(context, "Por favor, selecione um ícone para a categoria.");
      return;
    }

    final category = Category(
      name: _categoryController.text,
      icon: _selectedIcon!,
    );
    Provider.of<CategoryProvider>(context, listen: false).addCategory(category);
    _categoryController.clear();
    _selectedIcon = null;
    Navigator.of(context).pop();
  }

  void _editCategory(BuildContext context, int index) {
    _categoryController.text = Provider.of<CategoryProvider>(context, listen: false).categories[index].name;
    _selectedIcon = Provider.of<CategoryProvider>(context, listen: false).categories[index].icon;
    showDialog(
      context: context,
      builder: (context) => _buildCategoryDialog(
        title: "Editar Categoria",
        onConfirm: () {
          if (_categoryController.text.isEmpty) {
            _showSnackBar(context, "Por favor, insira um nome para a categoria.");
            return;
          }
          if (_selectedIcon == null) {
            _showSnackBar(context, "Por favor, selecione um ícone para a categoria.");
            return;
          }

          final category = Category(
            name: _categoryController.text,
            icon: _selectedIcon!,
          );
          Provider.of<CategoryProvider>(context, listen: false).editCategory(index, category);
          _categoryController.clear();
          _selectedIcon = null;
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmação"),
        content: const Text("Você tem certeza que deseja excluir esta categoria?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF850000),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false).removeCategory(index);
              Navigator.of(context).pop();
            },
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
  }

  void _showIconPickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Escolha um ícone"),
              content: SizedBox(
                width: double.maxFinite,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: _iconList.map((icon) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon = icon;
                        });
                      },
                      child: Icon(
                        icon,
                        size: 32,
                        color: _selectedIcon == icon
                            ? const Color(0xFF003617).withOpacity(0.85)
                            : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Selecionar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCategoryDialog({
    required String title,
    required VoidCallback onConfirm,
  }) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _categoryController,
            decoration: const InputDecoration(
              hintText: "Digite o nome da categoria",
            ),
          ),
          const SizedBox(height: 16),
          const Text("Escolha um ícone"),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _showIconPickerDialog,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedIcon != null
                    ? const Color(0xFFB8EFCB).withOpacity(0.75)
                    : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: _selectedIcon != null
                  ? Icon(
                      _selectedIcon,
                      size: 32,
                    )
                  : const Icon(
                      Icons.add,
                      size: 32,
                    ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _categoryController.clear();
            _selectedIcon = null;
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF003617),
            foregroundColor: Colors.white,
          ),
          child: const Text("Salvar"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorias"),
        titleTextStyle: AppTextStyles.KodchasanAddTandaction,
        backgroundColor: const Color(0xFF003617),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        color: const Color(0x33B8EFCB),
        child: Column(
          children: [
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.categories.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.white,
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0x6030BE6D),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            provider.categories[index].icon,
                            color: const Color(0xFF003617),
                          ),
                        ),
                        title: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0x6030BE6D),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            provider.categories[index].name,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Ionicons.create_outline, color: Color(0xFF003617)),
                              onPressed: () => _editCategory(context, index),
                            ),
                            IconButton(
                              icon: const Icon(Ionicons.trash_outline, color: Color(0xFF850000)),
                              onPressed: () => _confirmDelete(context, index),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003617),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _buildCategoryDialog(
                      title: "Adicionar Categoria",
                      onConfirm: () => _addCategory(context),
                    ),
                  );
                },
                child: const Text(
                  "Adicionar Categoria",
                  style: AppTextStyles.ButtonAddCatego,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
