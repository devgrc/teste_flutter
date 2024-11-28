import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemplo de capital (pode ser substituído por dados reais)
    double capital = 1200.50;  // Saldo do usuário
    String senha = "senhaCorreta"; // Senha para visualização (pode ser uma variável dinâmica)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        titleTextStyle: AppTextStyles.KodchasanAddTandaction,
        backgroundColor: Color(0xFF003617), // Cor #003617 (verde escuro)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda
          children: [
            // Foto de perfil
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
            ),
            const SizedBox(height: 16),

            // Nome do usuário
            Center(
              child: const Text(
                'João da Silva',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // E-mail do usuário
            Center(
              child: const Text(
                'joao.silva@email.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Container para o Capital
            Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Color(0xFF003617)),
                title: const Text('Capital'),
                subtitle: Text('R\$${capital.toStringAsFixed(2)}'),
              ),
            ),

            // Container para a Senha
            Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.lock, color: Color(0xFF003617)),
                title: const Text('Senha'),
                subtitle: Text(senha),
              ),
            ),

            // Informações adicionais (Telefone)
            Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const ListTile(
                leading: Icon(Icons.phone, color: Color(0xFF003617)), // Cor verde escuro para ícones
                title: Text('Telefone'),
                subtitle: Text('+55 11 98765-4321'),
              ),
            ),

            // Informações adicionais (Endereço)
            Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const ListTile(
                leading: Icon(Icons.location_on, color: Color(0xFF003617)), // Cor verde escuro para ícones
                title: Text('Endereço'),
                subtitle: Text('Rua Exemplo, 123 - Cidade, Estado'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
