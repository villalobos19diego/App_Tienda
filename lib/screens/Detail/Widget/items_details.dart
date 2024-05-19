

import 'package:authenticationapp/View/product_view.dart';
import 'package:authenticationapp/constants.dart';
import 'package:authenticationapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsDetails extends StatelessWidget {
  final Product product;
  const ItemsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // for rating
                  Row(
                    children: [
                      Container(
                         width: 55,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kprimaryColor,
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              product.rate.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(width: 5),
                     Expanded(
                        child: StreamBuilder<int>(
                         stream: product.id != null && product.id.isNotEmpty
                      ? Provider.of<ProductViewsProvider>(context).watchViews(product.id)
                      : null,
                  builder: (context, snapshot) {
                           if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                            if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                              final views = snapshot.data ?? 0;
                               return Text(
                               'Vistas: $views',
                            style: const TextStyle(
                           color: Colors.grey,
                           fontSize: 15,
                      ),
                    );
                  },
                ),
              ),

                    ],
                  )
                ],
              ),
            ),
            // const Spacer(),
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       const TextSpan(
            //         text: "Vendedor ",
            //         style: TextStyle(fontSize: 16),
            //       ),
            //       TextSpan(
            //         text: product.seller,
            //         style: const TextStyle(
            //             fontSize: 16, fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}
