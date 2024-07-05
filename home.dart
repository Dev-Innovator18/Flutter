import 'package:flutter/material.dart';
import 'package:app/shoppingApp/global.dart';
import 'package:app/shoppingApp/product.dart';
import 'package:app/shoppingApp/p_detail.dart';

class ProductList extends StatefulWidget{
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filter= [
    'All',
    'Adidas',
    'Nike',
    'Bata'
  ];
  late String selectedFilter;
  int currentPage=0;

  @override
  void initState() {
    super.initState();
    selectedFilter=filter[0];
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children:[
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Shoes\nCollection',
                  style:TextStyle(
                    fontWeight:FontWeight.w500,
                    fontSize:35,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration:InputDecoration(
                    hintText:'Search',
                    prefixIcon:Icon(Icons.search),
                    border:OutlineInputBorder(
                      borderSide:BorderSide(
                        color:Color.fromRGBO(122, 118, 118, 1),
                      ),
                      borderRadius:BorderRadius.horizontal(
                        left:Radius.circular(50),
                      ),
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(
                        color:Color.fromRGBO(122, 118, 118, 1),
                      ),
                      borderRadius:BorderRadius.horizontal(
                        left:Radius.circular(50),
                      ),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide:BorderSide(
                        color:Color.fromRGBO(122, 118, 118, 1),
                      ),
                      borderRadius:BorderRadius.horizontal(
                        left:Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height:120,
            child: ListView.builder(
              scrollDirection:Axis.horizontal,
              itemCount: filter.length,
              itemBuilder: (context,index){
                final filters=filter[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal:12.0),
                  child: GestureDetector(
                    onTap:(){
                      setState((){
                        selectedFilter=filters;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter==filters? const Color.fromRGBO(254, 206, 1, 1) : const Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1)
                      ),
                      label:Text(filter[index]),
                      labelStyle: const TextStyle(
                        fontSize:16,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal:10,vertical:10),
                      shape:RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder:(context,constraints){
                if(constraints.maxWidth>1080){
                  return GridView.builder(
                    itemCount:product.length,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                      childAspectRatio: 2,
                    ),
                    itemBuilder:(context,index){
                      final products=product[index];
                      return GestureDetector(
                        onTap:(){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context){
                                return ProductDetails(
                                  product: products,
                                );
                              },
                            ),
                          );
                        },
                        child: ProductApp(
                          title:products['title'] as String,
                          price:products['price'] as double,
                          image: products['imageUrl'] as String,
                          color: index%2==0 ? const Color.fromRGBO(216 , 240 , 253 , 1) : const Color.fromRGBO(245, 247, 249 ,1),
                        ),
                      );
                    },
                  );
                }
                else{
                  return ListView.builder(
                    itemCount:product.length,
                    itemBuilder:(context,index){
                      final products=product[index];
                      return GestureDetector(
                        onTap:(){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context){
                                return ProductDetails(
                                  product: products,
                                );
                              },
                            ),
                          );
                        },
                        child: ProductApp(
                          title:products['title'] as String,
                          price:products['price'] as double,
                          image: products['imageUrl'] as String,
                          color: index%2==0 ? const Color.fromRGBO(216 , 240 , 253 , 1) : const Color.fromRGBO(245, 247, 249 ,1),
                        ),
                      );
                    },
                  );
                }
              }
            )
          ),
        ],
      ),
    );
  }
}