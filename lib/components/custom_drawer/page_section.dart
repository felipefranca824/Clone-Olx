import 'package:clone_olx/components/custom_drawer/page_tile.dart';
import 'package:flutter/material.dart';

class PageSection extends StatelessWidget {
  const PageSection({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTile(
          label: 'Anúncios',
          iconData: Icons.list,
          onTap: (){},
          highLighted: false,
        ),
        PageTile(
          label: 'Inserir Anúncio',
          iconData: Icons.edit,
          onTap: (){},
          highLighted: false,
        ),
        PageTile(
          label: 'Chat',
          iconData: Icons.chat,
          onTap: (){},
          highLighted: false,
        ),
        PageTile(
          label: 'Favoritos',
          iconData: Icons.favorite,
          onTap: (){},
          highLighted: false,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person,
          onTap: (){},
          highLighted: true,
        ),
      ],
    );
  }
}