import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageComposer extends StatefulWidget {
  final Function({String message, File image}) sendMessage;
  const MessageComposer(this.sendMessage, {super.key});

  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  bool isTextFill = false;
  final TextEditingController _controller = TextEditingController();
  XFile? _img;

  Future<void> _imgFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _img = image;
      sendImage();
    });
  }

  Future<void> _imgFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _img = image;
      sendImage();
    });
  }

  void sendImage() {
    if (_img == null) return;
    widget.sendMessage(image: File(_img!.path));
    _img = null;
  }

  void _resetFields() {
    _controller.clear();
    setState(() {
      isTextFill = false;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return SafeArea(
              child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galeria'),
                  onTap: () => {_imgFromGallery(), Navigator.of(context).pop()},
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera_rounded),
                  title: const Text('Câmera'),
                  onTap: () => {_imgFromCamera(), Navigator.of(context).pop()},
                ),
                ListTile(
                  leading: const Icon(Icons.clear, color: Colors.red),
                  title: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () => {Navigator.of(context).pop()},
                )
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
              onPressed: () => {_showPicker(context)},
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
