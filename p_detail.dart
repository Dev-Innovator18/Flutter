import 'package:app/shoppingApp/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget{
  final Map<String, Object> product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize=0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:const Text(
          'Details',
          selectionColor: Colors.black,
        ),
      ),
      body:Column(
        children:[
          Text(
            widget.product['title'] as String,
            style: const TextStyle(
              fontWeight:FontWeight.bold,
              fontSize:35,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl'] as String,height:250),
          ),
          const Spacer(flex:2),
          Container(
            height:250,
            decoration: BoxDecoration(
              color:const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                Text(
                  '\$${widget.product['price']}',
                  style: const TextStyle(
                    fontWeight:FontWeight.bold,
                    fontSize:35,
                  ),
                ),
                const SizedBox(
                  height:10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection:Axis.horizontal,
                    itemCount: (widget.product['Sizes'] as List<int>).length,
                    itemBuilder: (context,index){
                      final int sizes=(widget.product['Sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:(){
                            setState((){
                              selectedSize=sizes;
                            });
                          },
                          child: Chip(
                            label:Text(sizes.toString()),
                            backgroundColor: selectedSize==sizes ? const Color.fromARGB(255, 245, 221, 8) : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    onPressed: (){
                      if(selectedSize!=0){
                        Provider.of<CartProvider>(context,listen:false).addProduct(
                          {
                            'id':widget.product['id'],
                            'title':widget.product['title'],
                            'price':widget.product['price'],
                            'Size':selectedSize,
                            'company':widget.product['company'],
                            'imageUrl':widget.product['imageUrl'],
                          }
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:Text(
                              'Product added successfully!',
                            ),
                          ),
                        );
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:Text(
                              'Please select your shoe size!',
                            ),
                          ),
                        );
                      }
                    },
                    style:ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 245, 221, 8),
                      fixedSize: const Size(350,50),
                    ),
                    icon: const Icon(Icons.shopping_cart),
                    label:const Text(
                      'Add To Cart',
                      style:TextStyle(
                        color:Color.fromARGB(163, 0, 0, 0),
                        fontSize:16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*ElevatedButton(
                    onPressed:(){},
                    style:ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 245, 221, 8),
                      minimumSize: const Size(double.infinity,50),
                    ),
                    child:*/