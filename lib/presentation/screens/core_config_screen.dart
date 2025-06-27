import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/config/menu/menu_items.dart';

class CoreConfigScreen extends StatelessWidget {
  const CoreConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: _CoreConfigView(),
    );
  }
}

class _CoreConfigView extends StatelessWidget {
  const _CoreConfigView();

  final menuItems = appMenuItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menuItems.length,
      itemBuilder: (BuildContext context, int index) {
        return ConfigMenuItem(
          menuItem: menuItems[index],
        );
      },
    );
  }
}

class ConfigMenuItem extends StatelessWidget {
  final MenuItem menuItem;

  const ConfigMenuItem({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(
        menuItem.icon,
        color: colors.primary,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: colors.primary,
      ),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subtitle),
      onTap: () {
        context.push(menuItem.link);
      },
    );
  }
}
