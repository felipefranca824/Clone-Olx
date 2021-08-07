import 'package:clone_olx/screens/category/category_screen.dart';
import 'package:clone_olx/stores/create/create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CategoryField extends StatelessWidget {
  const CategoryField(this.createStore);

  final CreateStore createStore;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListTile(
            title: Text(
              'Categoria *',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: createStore.category == null
                    ? FontWeight.w800
                    : FontWeight.w700,
                fontSize: createStore.category == null ? 18 : 14,
              ),
            ),
            subtitle: createStore.category == null
                ? null
                : Text(
                    '${createStore.category?.description}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () async {
              final category = await showDialog(
                context: context,
                builder: (context) => CategoryScreen(
                  showAll: false,
                  selected: createStore.category,
                ),
              );

              if (category != null) {
                createStore.setCategory(category);
                print(createStore.category?.description);
              }
            });
      },
    );
  }
}
