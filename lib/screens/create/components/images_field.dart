import 'dart:io';

import 'package:clone_olx/screens/create/components/image_dialog.dart';
import 'package:clone_olx/screens/create/components/image_source_modal.dart';
import 'package:clone_olx/stores/create/create_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ImagesField extends StatelessWidget {
  const ImagesField(this.createStore);

  final CreateStore createStore;

  final int maxImages = 5;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File? image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Container(
        color: Colors.grey[200],
        height: 120,
        child: Observer(
          builder: (_) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: createStore.images.length < maxImages
                  ? createStore.images.length + 1
                  : maxImages,
              itemBuilder: (_, index) {
                if (index == createStore.images.length)
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: GestureDetector(
                      onTap: () {
                        if (Platform.isAndroid) {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => ImageSourceModal(
                                    onImageSelected,
                                  ));
                        } else {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => ImageSourceModal(onImageSelected),
                          );
                        }
                      },
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.white,
                            ),
                            Text(
                              '+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                else
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        8, 16, (index == maxImages - 1) ? 16 : 0, 16),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ImageDialog(
                            image: createStore.images[index],
                            onDelete: () => createStore.images.removeAt(index),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 44,
                        backgroundImage: FileImage(createStore.images[index]),
                      ),
                    ),
                  );
              },
            );
          },
        ));
  }
}
