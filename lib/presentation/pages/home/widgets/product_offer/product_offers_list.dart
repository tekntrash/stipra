import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/models/product_model.dart';
import '../../../../../shared/app_theme.dart';
import 'product_offer_card.dart';

class ProductOffersList extends StatelessWidget {
  final List<ProductModel> products;
  const ProductOffersList({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Win Points',
            style: AppTheme.largeParagraphBoldText,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: products.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  child: ProductOfferCard(
                    product: products[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
