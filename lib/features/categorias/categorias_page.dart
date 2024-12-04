import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:teste_flutter/common/app_text_styles.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  final List<Map<String, dynamic>> _categories =
      []; // Lista de categorias com ícones
  final TextEditingController _categoryController = TextEditingController();
  IconData? _selectedIcon;

  final List<IconData> _iconList = [
    Ionicons.home,
    Ionicons.car, // Adicionado
    Ionicons.bicycle, // Adicionado
    Ionicons.body, // Adicionado
    Ionicons.star,
    Ionicons.heart,
    Ionicons.person,
    Ionicons.settings,
    Ionicons.camera,
    Ionicons.phone_portrait,
    Ionicons.cart,
    Ionicons.bookmark,
    Ionicons.calendar,
    Ionicons.aperture, // Adicionado
    Ionicons.airplane, // Adicionado
    Ionicons.game_controller, // Adicionado
    Ionicons.location, // Adicionado
    Ionicons.pizza, // Adicionado
    Ionicons.pulse, // Adicionado
    Ionicons.map, // Adicionado
    Ionicons.chatbubble, // Adicionado
    Ionicons.gift, // Adicionado
    Ionicons.fast_food, // Adicionado
    Ionicons.wallet, // Adicionado
    Ionicons.ribbon, // Adicionado
    Ionicons.hammer, // Adicionado
    Ionicons.moon, // Adicionado
    Ionicons.sunny, // Adicionado
    Ionicons.cube, // Adicionado
    Ionicons.cloud, // Adicionado
    Ionicons.code, // Adicionado
    Ionicons.cog, // Adicionado
    Ionicons.umbrella, // Adicionado
    Ionicons.business, // Adicionado
    Ionicons.trending_up, // Adicionado
    Ionicons.earth, // Adicionado
    Ionicons.mic, // Adicionado
    Ionicons.battery_full, // Adicionado
    Ionicons.pencil, // Adicionado
    Ionicons.clipboard, // Adicionado
    Ionicons.tv, // Adicionado
    Ionicons.headset, // Adicionado
    Ionicons.paw, // Adicionado
  ];

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  void _addCategory() {
    if (_categoryController.text.isNotEmpty && _selectedIcon != null) {
      setState(() {
        _categories.add({
          'name': _categoryController.text,
          'icon': _selectedIcon,
        });
      });
      _categoryController.clear();
      _selectedIcon = null;
      Navigator.of(context).pop();
    }
  }

  void _editCategory(int index) {
    _categoryController.text = _categories[index]['name'];
    _selectedIcon = _categories[index]['icon'];
    showDialog(
      context: context,
      builder: (context) => _buildCategoryDialog(
        title: "Editar Categoria",
        onConfirm: () {
          setState(() {
            _categories[index] = {
              'name': _categoryController.text,
              'icon': _selectedIcon,
            };
          });
          _categoryController.clear();
          _selectedIcon = null;
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmação"),
        content:
            const Text("Você tem certeza que deseja excluir esta categoria?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor:
                  const Color.fromARGB(255, 0, 0, 0), // Cor do texto
            ),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF850000),
              foregroundColor: Colors.white, // Cor do texto
            ),
            onPressed: () {
              setState(() {
                _categories.removeAt(index);
              });
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
                    foregroundColor: Colors.black, // Cor do texto
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
            foregroundColor: Colors.black, // Cor do texto
          ),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_selectedIcon != null) {
              onConfirm();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF003617), // Cor do botão
            foregroundColor: Colors.white, // Cor do texto
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
          color: Colors.white, // Define a cor branca para o ícone de voltar
        ),
      ),
      body: Container(
        color: const Color(0x33B8EFCB), // Fundo com 20% de opacidade
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) => Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.white, // Fundo branco para o card
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(
                            0x6030BE6D), // Verde com 38% de opacidade
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        _categories[index]['icon'],
                        color: const Color(0xFF003617),
                      ),
                    ),
                    title: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(
                            0x6030BE6D), // Verde com 38% de opacidade
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _categories[index]['name'],
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), // Cor do texto
                        ),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Ionicons.create_outline,
                              color: Color(0xFF003617)),
                          onPressed: () => _editCategory(index),
                        ),
                        IconButton(
                          icon: const Icon(Ionicons.trash_outline,
                              color: Color(0xFF850000)),
                          onPressed: () => _confirmDelete(index),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003617), // Cor do botão
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _buildCategoryDialog(
                      title: "Adicionar Categoria",
                      onConfirm: _addCategory,
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
