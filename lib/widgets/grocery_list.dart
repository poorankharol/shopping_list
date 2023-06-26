import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final dio = Dio();
  List<GroceryItem> _groceryItem = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    _loadItem();
  }

  void _loadItem() async {
    //dio.options.headers['content-Type'] = 'application/json';
    //final response = await dio.get('https://flutter-prep-6a73a-default-rtdb.firebaseio.com/shopping-list.json');
    final url = Uri.https(
        'flutter-prep-6a73a-default-rtdb.firebaseio.com', 'shopping-list.json');
    try{
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = "Failed to fetch data.";
        });
      }
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      print(json.decode(response.body));

      final Map<String, dynamic> listData = json.decode(response.body);

      List<GroceryItem> loadedList = [];
      for (var item in listData.entries) {
        final category = categories.entries
            .firstWhere((element) => element.value.name == item.value['category'])
            .value;
        loadedList.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category));

        setState(() {
          _isLoading = false;
          _groceryItem = loadedList;
        });
      }
    }catch(err){
      setState(() {
        _error = "Something went wrong! Failed to fetch data.";
      });
    }

  }

  void _newItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItemScreen()));
    //_loadItem();
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removeItem(GroceryItem groceryItem) async {
    final index = _groceryItem.indexOf(groceryItem);
    setState(() {
      _groceryItem.remove(groceryItem);
    });
    final url = Uri.https('flutter-prep-6a73a-default-rtdb.firebaseio.com',
        'shopping-list/${groceryItem.id}.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItem.insert(index,groceryItem);
      });
    }
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

    if (_isLoading) {
      mainContent = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItem.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_groceryItem[index]),
            onDismissed: (direction) {
              _removeItem(_groceryItem[index]);
            },
            background: Container(
              color: Colors.red,
            ),
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

    if (_error != null) {
      mainContent = Center(child: Text(_error.toString()));
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
