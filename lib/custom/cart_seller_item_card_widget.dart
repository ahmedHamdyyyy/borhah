import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/system_config.dart';
import '../my_theme.dart';
import '../presenter/cart_provider.dart';
import 'box_decorations.dart';
import 'device_info.dart';

class CartSellerItemCardWidget extends StatelessWidget {
  final int sellerIndex;
  final int itemIndex;
  final CartProvider cartProvider;

  const CartSellerItemCardWidget(
      {Key? key,
      required this.cartProvider,
      required this.sellerIndex,
      required this.itemIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: DeviceInfo(context).width! / 4,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(6), right: Radius.zero),
                  child: CachedNetworkImage(
                    imageUrl: cartProvider.shopList[sellerIndex]
                            .cartItems[itemIndex].productThumbnailImage ??
                        'assets/placeholder.png',
                    placeholder: (context, url) => Image.asset(
                      'assets/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                        'assets/placeholder.png',
                        fit: BoxFit.cover),
                    fit: BoxFit.cover,
                  ),
                  // FadeInImage.assetNetwork(
                  //   placeholder: 'assets/placeholder.png',
                  //   image: cartProvider.shopList[sellerIndex]
                  //       .cartItems[itemIndex].productThumbnailImage,
                  //   fit: BoxFit.cover,
                  // )
                )),
            Container(
              //color: Colors.red,
              width: DeviceInfo(context).width! / 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cartProvider.shopList[sellerIndex].cartItems[itemIndex]
                          .productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 23.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                SystemConfig.systemCurrency != null
                                    ? cartProvider.shopList[sellerIndex]
                                        .cartItems[itemIndex].price
                                        .replaceAll(
                                            SystemConfig.systemCurrency!.code,
                                            SystemConfig.systemCurrency!.symbol == "SAR" ? "" : SystemConfig.systemCurrency!.symbol)
                                    : cartProvider.shopList[sellerIndex]
                                        .cart_items[itemIndex].price,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: MyTheme.accent_color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            SystemConfig.systemCurrency!.symbol == "SAR" ?
                            Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: SvgPicture.asset("assets/svg/Symbol.svg",width: 15,height: 15,),
                            ) :
                            SizedBox(width: 0,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 32,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.onPressDelete(
                        context,
                        cartProvider
                            .shopList[sellerIndex].cartItems[itemIndex].id
                            .toString(),
                      );
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: Image.asset(
                          'assets/trash.png',
                          height: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (cartProvider.shopList[sellerIndex]
                              .cartItems[itemIndex].auctionProduct ==
                          0) {
                        cartProvider.onQuantityIncrease(
                            context, sellerIndex, itemIndex);
                      }
                      return null;
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration:
                          BoxDecorations.buildCartCircularButtonDecoration(),
                      child: Icon(
                        Icons.add,
                        color: cartProvider.shopList[sellerIndex]
                                    .cartItems[itemIndex].auctionProduct ==
                                0
                            ? MyTheme.accent_color
                            : MyTheme.grey_153,
                        size: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      cartProvider
                          .shopList[sellerIndex].cartItems[itemIndex].quantity
                          .toString(),
                      style:
                          TextStyle(color: MyTheme.accent_color, fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (cartProvider.shopList[sellerIndex]
                              .cartItems[itemIndex].auctionProduct ==
                          0) {
                        cartProvider.onQuantityDecrease(
                            context, sellerIndex, itemIndex);
                      }
                      return null;
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration:
                          BoxDecorations.buildCartCircularButtonDecoration(),
                      child: Icon(
                        Icons.remove,
                        color: cartProvider.shopList[sellerIndex]
                                    .cartItems[itemIndex].auctionProduct ==
                                0
                            ? MyTheme.accent_color
                            : MyTheme.grey_153,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}

