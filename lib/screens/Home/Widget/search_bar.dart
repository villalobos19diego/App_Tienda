
import 'package:authenticationapp/constants.dart';
import 'package:authenticationapp/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MySearchBAR extends StatefulWidget {
  final List<Product> allProducts;
  const MySearchBAR({Key? key,  required this.allProducts}) : super(key: key,);

  @override
  _MySearchBARState createState() => _MySearchBARState();
}

class _MySearchBARState extends State<MySearchBAR> {
  late TextEditingController _searchController;
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredProducts = widget.allProducts;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  void filterProducts(String query) {
    setState(() {
      _filteredProducts = widget.allProducts.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: kprimaryColor,
            size: 30,
          ),
          SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: TextField(
              controller: _searchController,
              onChanged: filterProducts,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: kprimaryColor,),

                border: InputBorder.none,

              ),
            ),
          ),
          Container(
            height: 25,
            width: 1.5,
            color: kprimaryColor,
          ),
          IconButton(
            onPressed: () {
              // Implementa la lógica para abrir un menú desplegable o un diálogo de filtro aquí.
              // Por ejemplo, puedes mostrar un menú de opciones para que el usuario seleccione una categoría de productos.
            },
            icon: Icon(
              Icons.tune,
              color: kprimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}