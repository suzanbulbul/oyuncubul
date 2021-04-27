import 'package:flutter/material.dart';
import 'package:oyuncubul/components/constants.dart';
import '../../../models/product.dart';
import '../../details/details_screen.dart';
import 'product_card.dart';

class Deneme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Stack(
          children: <Widget>[
            // Our background
            Container(
              margin: EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
            ListView.builder(
              // here we use our demo procuts list
              itemCount: products.length,
              itemBuilder: (context, index) => ProductCard(
                itemIndex: index,
                product: products[index],
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        product: products[index],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
