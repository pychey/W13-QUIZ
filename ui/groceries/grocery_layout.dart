import 'package:flutter/material.dart';
import 'package:myapp/W13-Flutter-QUIZ/data/mock_grocery_repository.dart';
import 'package:myapp/W13-Flutter-QUIZ/models/grocery.dart';
import 'package:myapp/W13-Flutter-QUIZ/ui/groceries/grocery_form.dart';
import 'package:myapp/W13-Flutter-QUIZ/ui/groceries/grocery_list.dart';
import 'package:myapp/W13-Flutter-QUIZ/ui/groceries/grocery_search.dart';

class GroceryLayout extends StatefulWidget {
  const GroceryLayout({super.key});

  @override
  State<GroceryLayout> createState() => _GroceryLayoutState();
}

enum GroceryTab { displayTab, searchTab }

class _GroceryLayoutState extends State<GroceryLayout> {
  GroceryTab _currentTab = GroceryTab.displayTab;

  void onCreate() async {
    // Navigate to the form screen using the Navigator push
    Grocery? newGrocery = await Navigator.push<Grocery>(
      context,
      MaterialPageRoute(builder: (context) => const GroceryForm()),
    );
    if (newGrocery != null) {
      setState(() {
        dummyGroceryItems.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: onCreate, icon: const Icon(Icons.add))],
      ),
      body: IndexedStack(
        index: _currentTab.index,
        children: [
          GroceryList(),
          GrocerySearch()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentTab.index,
        onTap: (index) {
          setState(() {
            _currentTab = GroceryTab.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Groceries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), 
            label: 'Search'
          ),
        ],
      ),
    );
  }
}