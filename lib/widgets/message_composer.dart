import 'package:flutter/material.dart';

class MessageComposer extends StatefulWidget {
  final Function({String message}) sendMessage;
  const MessageComposer(this.sendMessage, {super.key});

  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  bool isTextFill = false;
  final TextEditingController _controller = TextEditingController();

  void _resetFields() {
    _controller.clear();
    setState(() {
      isTextFill = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.photo_camera_rounded)),
          Expanded(
              child: TextField(
            controller: _controller,
            decoration:
                const InputDecoration.collapsed(hintText: 'Enviar mensagem'),
            onChanged: (value) => {
              setState(() {
                isTextFill = value.isNotEmpty;
              })
            },
            onSubmitted: (value) =>
                {widget.sendMessage(message: _controller.text), _resetFields()},
          )),
          IconButton(
            icon: const Icon(Icons.send),
            color: isTextFill ? Colors.green : Colors.grey,
            onPressed: isTextFill
                ? () => {
                      widget.sendMessage(message: _controller.text),
                      _resetFields()
                    }
                : null,
          )
        ],
      ),
    );
  }
}
