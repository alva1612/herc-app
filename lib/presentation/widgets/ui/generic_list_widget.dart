import 'package:flutter/material.dart';

class GenericListItem {
  final String title;
  final String subtitle;

  GenericListItem({required this.title, required this.subtitle});
}

class GenericListWidget extends StatelessWidget {
  final List<GenericListItem> items;
  final Function? onDelete;
  const GenericListWidget({super.key, required this.items, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) => GenericRow(
        item: items[index],
        onDelete: onDelete,
      ),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 16,
      ),
    ));
  }
}

class GenericRow extends StatelessWidget {
  final GenericListItem item;
  final Function? onDelete;

  const GenericRow({
    required this.item,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.title, // Assuming T has a meaningful toString() method
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(item.subtitle),
      trailing: onDelete != null
          ? IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                onDelete!();
              },
            )
          : null,
    );
  }
}
