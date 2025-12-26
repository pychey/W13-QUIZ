import 'package:flutter/material.dart';
import 'package:myapp/W13-Flutter-QUIZ/data/mock_grocery_repository.dart';
import 'package:myapp/W13-Flutter-QUIZ/models/grocery.dart';
import 'package:myapp/W13-Flutter-QUIZ/ui/groceries/grocery_form.dart';
import 'package:myapp/W13-Flutter-QUIZ/ui/groceries/grocery_list.dart';
import 'package:myapp/W13-Flutter-QUIZ/ui/groceries/grocery_search.dart';


void main() {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

enum GroceryTab { displayTab, searchTab }

class _MyAppState extends State<MyApp> {
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Groceries',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      home: Scaffold(
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
      ),
    );
  }
}
