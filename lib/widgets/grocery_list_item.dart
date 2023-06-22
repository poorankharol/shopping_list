import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({super.key, required this.groceryItem});

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 20,
            width: 20,
            color: groceryItem.category.color,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(groceryItem.name),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                groceryItem.quantity.toString(),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
