import 'package:flutter/material.dart';
import 'package:app/shoppingApp/home.dart';
import 'package:app/shoppingApp/cart_page.dart';

class ShoppingApp extends StatefulWidget{
  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  int currentPage=0;
  List<Widget> page= const [
    ProductList(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: IndexedStack(
        index:currentPage,
        children: page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize:35,
        currentIndex:currentPage,
        onTap:(value){
          setState((){
            currentPage=value;
          });
        },
        items:const [
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label:'',
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.shopping_cart),
            label:'',
          ),
        ],
      ),
    );
  }
}