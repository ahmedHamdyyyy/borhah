import 'package:active_ecommerce_flutter/custom/box_decorations.dart';
import 'package:active_ecommerce_flutter/helpers/system_config.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/product/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListProductCard extends StatefulWidget {
  final int? id;
  final String slug;
  final String? image;
  final String? name;
  final String? main_price;
  final String? stroked_price;
  final bool? has_discount;

  ListProductCard(
      {Key? key,
      this.id,
      required this.slug,
      this.image,
      this.name,
      this.main_price,
      this.stroked_price,
      this.has_discount})
      : super(key: key);

  @override
  _ListProductCardState createState() => _ListProductCardState();
}

class _ListProductCardState extends State<ListProductCard> {
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
        decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(6), right: Radius.zero),
                child: CachedNetworkImage(
                  imageUrl: widget.image ?? 'assets/placeholder.png',
                  placeholder: (context, url) => Image.asset(
                    'assets/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/placeholder.png', fit: BoxFit.cover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 14,
                          height: 1.6,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              SystemConfig.systemCurrency!.code != null
                                  ? widget.main_price!.replaceAll(
                                      SystemConfig.systemCurrency!.code!,
                                      SystemConfig.systemCurrency!.symbol == "SAR" ? "" : SystemConfig.systemCurrency!.symbol!)
                                  : widget.main_price!,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyTheme.accent_color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            if (SystemConfig.systemCurrency!.symbol == "SAR")
                              Padding(
                                padding: const EdgeInsets.only(right: 3),
                                child: SvgPicture.asset("assets/svg/Symbol.svg", width: 15, height: 15),
                              ),
                          ],
                        ),
                        if (widget.has_discount!)
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  SystemConfig.systemCurrency!.code != null
                                      ? widget.stroked_price!.replaceAll(
                                          SystemConfig.systemCurrency!.code!,
                                          SystemConfig.systemCurrency!.symbol == "SAR" ? "" : SystemConfig.systemCurrency!.symbol!)
                                      : widget.stroked_price!,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: MyTheme.medium_grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                if (SystemConfig.systemCurrency!.symbol == "SAR")
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: SvgPicture.asset("assets/svg/Symbol.svg", width: 10, height: 10),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

