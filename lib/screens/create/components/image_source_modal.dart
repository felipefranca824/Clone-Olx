import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  ImageSourceModal(this.onImageSelected);

  final void Function(File?) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: getFromCamera,
              child: const Text(
                'Câmera',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: getFromGallery,
              child: const Text(
                'Galeria',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: Text('Selecionar imagem para o anúncio'),
        message: Text('Escolha a origem da imagem'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: getFromCamera,
            child: const Text(
              'Câmera',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: getFromGallery,
            child: const Text(
              'Galeria',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      );
  }

  Future<void> getFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if(pickedFile == null) return;
    final image = File(pickedFile.path);
    imageSelected(image);
  }

  Future<void> getFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile == null) return;
    final image = File(pickedFile.path);
    imageSelected(image);
  }

  Future<void> imageSelected(File image) async {
    final croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Editar Imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      ),
    );

    if(croppedFile != null)
      onImageSelected(croppedFile);
  }
}
