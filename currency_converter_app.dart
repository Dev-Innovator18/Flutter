import 'package:flutter/material.dart';

class CurrencyConverterMaterialApp extends StatefulWidget{
  const CurrencyConverterMaterialApp({super.key});
  @override
  State<CurrencyConverterMaterialApp> createState() => _MaterialeApp();
}

final TextEditingController textEditingController = TextEditingController();

class _MaterialeApp extends State<CurrencyConverterMaterialApp>{
  double result=0.0;

  @override
  Widget build(BuildContext context){
    return Directionality(
      textDirection:TextDirection.ltr,
      child:Scaffold(
        appBar:AppBar(
          title:const Text('Currency Converter App'),
          backgroundColor:const Color.fromARGB(255, 87, 209, 227),
        ),
        backgroundColor:const Color.fromARGB(255, 87, 209, 227),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text(
                'INR value is ${result!=0 ? result.toStringAsFixed(2) : 0}',
                style:const TextStyle(
                  fontWeight:FontWeight.w900,
                  fontSize: 25.0,
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(10),
                child:TextField(
                  controller:textEditingController,
                  decoration:const InputDecoration(
                    hintText:'Enter the amount in USD',
                    prefixIcon:Icon(Icons.monetization_on_outlined),
                    filled:true,
                    fillColor:Colors.white,
                    enabledBorder:InputBorder.none,
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.0,
                      ),
                    ),
                  ),
                  keyboardType:const TextInputType.numberWithOptions(decimal:true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child:TextButton(
                  style:const ButtonStyle(
                    backgroundColor:WidgetStatePropertyAll(Colors.black),
                    foregroundColor:WidgetStatePropertyAll(Colors.white),
                    minimumSize: WidgetStatePropertyAll(Size(double.infinity,50)),
                    shape:WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius:BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  onPressed: (){
                    setState(() {
                      result=double.parse(textEditingController.text)*83.55;
                    });
                  },
                  child:const Text('Convert'),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}