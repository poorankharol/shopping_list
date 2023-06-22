import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItem = [];

  void _newItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItemScreen()));
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removeItem(GroceryItem groceryItem)
  {
    setState(() {
      _groceryItem.remove(groceryItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    Widget mainContent = Center(
      child: Text(
        "Nothing here...",
        style: textTheme.titleLarge,
      ),
    );

    if (_groceryItem.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_groceryItem[index]),
            onDismissed: (direction){
              _removeItem(_groceryItem[index]);
            },
            background: Container(color: Colors.red,),
            child: ListTile(
              title: Text(
                _groceryItem[index].name,
                style: textTheme.titleLarge,
              ),
              leading: Container(
                height: 20,
                width: 20,
                color: _groceryItem[index].category.color,
              ),
              trailing: Text(
                _groceryItem[index].quantity.toString(),
                style: textTheme.titleLarge,
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Your groceries", style: textTheme.titleLarge),
        actions: [
          IconButton(
              onPressed: () {
                _newItem();
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: mainContent,
    );
  }
}
