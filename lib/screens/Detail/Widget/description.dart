
import 'package:authenticationapp/View/product_view.dart';
import 'package:authenticationapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Description extends StatelessWidget {
  final String description;

  const Description({super.key, required this.description });

  @override
  Widget build(BuildContext context) {



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Center(
                  child: const Text(
                    "Descripcion",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            const Text(
              "Detalles",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
             Text(
              "Vista",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Center(child: const SizedBox(height: 20)),
        Center(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
