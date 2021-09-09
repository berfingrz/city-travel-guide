import 'package:flutter/material.dart';
import '../widgets/maindrawer.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      drawer: Drawer(child: MainDrawer()),
    );
  }
}
