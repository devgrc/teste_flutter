import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'user',
        'message': _controller.text,
      });

      _messages.add({
        'sender': 'bot',
        'message': "Oi, eu sou o NEO, sou seu assistente financeiro. Como posso ajudar você?",
      });
    });

    // Após adicionar as mensagens, animar a inserção delas
    _listKey.currentState?.insertItem(0); // Inserir a mensagem do usuário
    _listKey.currentState?.insertItem(1); // Inserir a mensagem do bot

    _controller.clear();
  }

  Widget _buildMessage(String sender, String message, int index) {
    bool isUser = sender == 'user';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Material(
          color: isUser
              ? const Color(0xFF003617) // Cor da mensagem do usuário (verde escuro)
              : const Color(0xFFD9D9D9), // Cor da mensagem do bot (cinza claro)
          borderRadius: BorderRadius.circular(15),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              message,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black, // Cor do texto
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Digite uma mensagem...',
                filled: true,
                fillColor: const Color(0xFFB8EFCB).withOpacity(0.25), // Cor de fundo com 25% de opacidade
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              // Acionar o envio quando o usuário pressionar Enter
              onSubmitted: (value) {
                _sendMessage();
              },
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send, color: Color(0xFF003617)), // Cor do ícone de envio
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Esta propriedade centraliza o título
        title: const Text(
          'NeoChat', 
          style: AppTextStyles.KodchasanAddTandaction, // Você pode ajustar o estilo do texto do título aqui
        ),
        backgroundColor: const Color(0xFF003617), // Cor do AppBar (verde escuro)
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              reverse: true, // Para a lista começar do final (mais recente)
              initialItemCount: _messages.length,
              itemBuilder: (context, index, animation) {
                final message = _messages[index];
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(animation),
                    child: _buildMessage(message['sender']!, message['message']!, index),
                  ),
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }
}
