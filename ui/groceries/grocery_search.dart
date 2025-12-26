import 'package:flutter/material.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';

class GrocerySearch extends StatefulWidget {
  const GrocerySearch({super.key});

  @override
  State<GrocerySearch> createState() => _GrocerySearchState();
}

class _GrocerySearchState extends State<GrocerySearch> {
  List<Grocery> foundGroceries = [];
  String? searchText;

  void onSearch(String? value) {
    setState(() {
      searchText = value;
      foundGroceries = dummyGroceryItems.any((item) => item.name.contains(searchText)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (foundGroceries.isNotEmpty) {
      //  Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: foundGroceries.length,
        itemBuilder: (context, index) =>
            GroceryTile(grocery: foundGroceries[index]),
      );
    }

    return Column(
      children: [
        TextField(
          onChanged: onSearch,
        ),
        content,
      ],
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(width: 15, height: 15, color: grocery.category.color),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
