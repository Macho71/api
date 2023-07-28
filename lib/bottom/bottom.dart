import 'package:flutter/material.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currnetIndex = 0;
  List<Widget> body = const [Icon(Icons.home), Icon(Icons.delete)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bottom"),
      ),
      body: Center(child: body[_currnetIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currnetIndex,
        onTap: ((int index) {
          setState(
            () {
              _currnetIndex = index;
            },
          );
        }),
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Delete", icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}
