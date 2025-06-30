import 'package:active_ecommerce_flutter/custom/box_decorations.dart';
import 'package:active_ecommerce_flutter/helpers/system_config.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/product/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/shared_value_helper.dart';

class MiniProductCard extends StatefulWidget {
  final int? id;
  final String slug;
  final String? image;
  final String? name;
  final String? main_price;
  final String? stroked_price;
  final bool? has_discount;
  final bool? is_wholesale;
  final String? discount;
  MiniProductCard({
    Key? key,
    this.id,
    required this.slug,
    this.image,
    this.name,
    this.main_price,
    this.stroked_price,
    this.has_discount,
    this.is_wholesale = false,
    this.discount,
  }) : super(key: key);

  @override
  _MiniProductCardState createState() => _MiniProductCardState();
}

class _MiniProductCardState extends State<MiniProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(
            slug: widget.slug,
          );
        }));
      },
      child: Container(
        width: 135,
        decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Stack(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(6), bottom: Radius.zero),
                        child: CachedNetworkImage(
                          imageUrl: widget.image ?? 'assets/placeholder.png',
                          placeholder: (context, url) => Image.asset(
                            'assets/placeholder.png',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                              'assets/placeholder.png',
                              fit: BoxFit.cover),
                          fit: BoxFit.cover,
                        ),

                        //  FadeInImage.assetNetwork(
                        //   placeholder: 'assets/placeholder.png',
                        //   image: widget.image!,
                        //   fit: BoxFit.cover,
                        // )
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 6),
                  child: Text(
                    widget.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 12,
                        height: 1.2,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                widget.has_discount!
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row(
                          children: [
                            Text(
                              SystemConfig.systemCurrency != null
                                  ? widget.stroked_price!.replaceAll(
                                      SystemConfig.systemCurrency!.code!,
                                      SystemConfig.systemCurrency!.symbol!)
                                  : widget.stroked_price!,
                              maxLines: 1,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: MyTheme.medium_grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                            SystemConfig.systemCurrency!.symbol == "SAR" ?
                            Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: SvgPicture.asset("assets/svg/Symbol.svg",width: 15,height: 15,),
                            ) :
                            SizedBox(width: 0,),
                          ],
                        ),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Row(
                    children: [
                      Text(
                        SystemConfig.systemCurrency != null
                            ? widget.main_price!.replaceAll(
                                SystemConfig.systemCurrency!.code!,
                                SystemConfig.systemCurrency!.symbol!)
                            : widget.main_price!,
                        maxLines: 1,
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
                ),
              ]),

          // discount and wholesale
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (widget.has_discount!)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffe62e04),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x14000000),
                            offset: Offset(-1, 1),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        widget.discount ?? "",
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          height: 1.8,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                    ),
                  Visibility(
                    visible: whole_sale_addon_installed.$,
                    child: widget.is_wholesale!
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6.0),
                                bottomLeft: Radius.circular(6.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x14000000),
                                  offset: Offset(-1, 1),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              "Wholesale",
                              style: TextStyle(
                                fontSize: 10,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                height: 1.8,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              softWrap: false,
                            ),
                          )
                        : SizedBox.shrink(),
                  )
                ],
              ),
            ),
          ),

          // whole sale
        ]),
      ),
    );
  }
}

