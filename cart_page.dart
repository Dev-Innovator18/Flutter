import 'package:app/shoppingApp/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget{
  const CartPage({super.key});

  @override
  Widget build(BuildContext context){
    final cart = Provider.of<CartProvider>(context).kart;

    return Scaffold(
      appBar:AppBar(
        title:const Text(
          'Cart',
          style:TextStyle(
            fontWeight:FontWeight.bold,
          ),
        ),
      ),
      body:ListView.builder(
        itemCount:cart.length,
        itemBuilder:(context,index){
          final cartItem=cart[index];
          return ListTile(
            leading:CircleAvatar(
              backgroundImage:AssetImage(cartItem['imageUrl'] as String),
              radius:35,
            ),
            trailing:IconButton(
              onPressed:(){
                showDialog(
                  context: context ,
                  builder: (context){
                    return AlertDialog(
                      title: const Text(
                        'Delete Product',
                        style:TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize:16,
                        ),
                      ),
                      content: const Text('Are you sure you want to delete the product from the cart?'),
                      actions:[
                        TextButton(
                          onPressed:() {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed:() {
                            Provider.of<CartProvider>(context,listen:false).removeProduct(cartItem);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  } 
                );
              },
              icon: const Icon(
                Icons.delete,
                color:Colors.red,
              ),
            ),
            title:Text(
              cartItem['title'].toString(),
              style:const TextStyle(
                fontWeight:FontWeight.bold,
                fontSize:16,
              ),
            ),
            subtitle:Text(
              'Size: ${cartItem['Size']}',
            ),
          ); 
        }
      ),
    );
  }
}