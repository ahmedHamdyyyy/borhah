import 'package:active_ecommerce_flutter/custom/btn.dart';
import 'package:active_ecommerce_flutter/custom/text_styles.dart';
import 'package:active_ecommerce_flutter/custom/useful_elements.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/helpers/system_config.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/presenter/cart_counter.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:active_ecommerce_flutter/app_config.dart';

import '../../custom/cart_seller_item_list_widget.dart';
import '../../presenter/cart_provider.dart';

class Cart extends StatefulWidget {
  Cart(
      {Key? key,
      this.has_bottomnav,
      this.from_navigation = false,
      this.counter})
      : super(key: key);
  final bool? has_bottomnav;
  final bool from_navigation;
  final CartCounter? counter;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final String whatsappNumber = "+967778821618"; // ضع رقم الواتساب هنا
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, _) {
      return Directionality(
        textDirection:
            app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: cartProvider.scaffoldKey,
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: Stack(
            children: [
              RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                onRefresh: () => cartProvider.onRefresh(context),
                displacement: 0,
                child: CustomScrollView(
                  controller: cartProvider.mainScrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: buildCartSellerList(cartProvider, context),
                          ),
                          Container(
                            height: widget.has_bottomnav! ? 140 : 100,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: buildBottomContainer(cartProvider),
              ),
              //SizedBox(height: 100),
              // إضافة زر المشاركة عبر واتساب
            ],
          ),
        ),
      );
    });
  }

  Container buildBottomContainer(cartProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: widget.has_bottomnav!
          ? 250
          : 240, // قم بزيادة الارتفاع لاستيعاب الزر الإضافي
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: MyTheme.soft_accent_color,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.total_amount_ucf,
                      style: TextStyle(
                        //color: MyTheme.dark_font_grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          cartProvider.cartTotalString.replaceAll(SystemConfig.systemCurrency!.code,
                                    SystemConfig.systemCurrency!.symbol == "SAR" ? "" : SystemConfig.systemCurrency!.symbol),
                          style: TextStyle(
                            color: MyTheme.accent_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
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
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 58,
                    width: (MediaQuery.of(context).size.width - 48),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyTheme.accent_color, width: 1),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Btn.basic(
                      minWidth: MediaQuery.of(context).size.width,
                      color: MyTheme.accent_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.proceed_to_shipping_ucf,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        cartProvider.onPressProceedToShipping(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            // زر "مواصلة الشراء عبر واتساب"
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 58,
                    width: (MediaQuery.of(context).size.width - 48),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green, width: 1),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Btn.basic(
                      minWidth: MediaQuery.of(context).size.width,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        "مواصلة الشراء عبر واتساب",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        _shareCartOnWhatsApp(
                            cartProvider); // استدعاء دالة المشاركة عبر واتساب
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) => widget.from_navigation
            ? UsefulElements.backToMain(context, go_back: false)
            : UsefulElements.backButton(context),
      ),
      title: Text(
        AppLocalizations.of(context)!.shopping_cart_ucf,
        style: TextStyles.buildAppBarTexStyle(),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildCartSellerList(cartProvider, context) {
    // for guest checkout log in to see cart items is disabled.
    // if (is_logged_in.$ == false) {
    //   return Container(
    //       height: 100,
    //       child: Center(
    //           child: Text(
    //         AppLocalizations.of(context)!.please_log_in_to_see_the_cart_items,
    //         style: TextStyle(color: MyTheme.font_grey),
    //       )));
    // } else
    if (cartProvider.isInitial && cartProvider.shopList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (cartProvider.shopList.length > 0) {
// تحقق من وجود بائعين في عربة التسوق
      // تحقق من وجود بائعين في عربة التسوق
      // تحقق من وجود بائعين في عربة التسوق
      if (cartProvider.shopList.length > 0) {
        for (var shop in cartProvider.shopList) {
          print("Shop Name: ${shop.name}");

          if (shop.cartItems != null && shop.cartItems.isNotEmpty) {
            for (var item in shop.cartItems) {
              print("Product Name: ${item.productName}");
              print("Product Price: ${item.price}");

              print("Product Quantity: ${item.quantity}");
            }
          } else {
            print("No products in this shop.");
          }
        }
      } else {
        print("No shops in the cart.");
      }

      return SingleChildScrollView(
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 26,
          ),
          itemCount: cartProvider.shopList.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Text(
                        cartProvider.shopList[index].name,
                        style: TextStyle(
                            color: MyTheme.dark_font_grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            cartProvider.shopList[index].subTotal.replaceAll(
                                    SystemConfig.systemCurrency!.code,
                                    SystemConfig.systemCurrency!.symbol == "SAR" ? "" : SystemConfig.systemCurrency!.symbol) ??
                                '',
                            style: TextStyle(
                                color: MyTheme.accent_color,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
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
                CartSellerItemListWidget(
                  sellerIndex: index,
                  cartProvider: cartProvider,
                  context: context,
                ),
              ],
            );
          },
        ),
      );
    } else if (!cartProvider.isInitial && cartProvider.shopList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.cart_is_empty,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  void _shareCartOnWhatsApp(CartProvider cartProvider) async {
    String message = 'طلب جديد من تطبيق برهه 🛍️\n\n';
    double totalPrice = 0.0;

    for (var shop in cartProvider.shopList) {
      message += "المتجر: ${shop.name}\n";
      message += "-------------------\n";
      
      for (var item in shop.cartItems) {
        double itemPrice = double.tryParse(
                item.price.replaceAll(RegExp(r'[^\d.]'), '')) ??
            0.0;
        
        message += "🏷️ المنتج: ${item.productName}\n";
        message += "💰 السعر: ${itemPrice.toStringAsFixed(2)} ريال\n";
        message += "📦 الكمية: ${item.quantity}\n";
        
        // إضافة رابط المنتج
        message += "🔗 رابط المنتج: ${AppConfig.RAW_BASE_URL}/product/${item.productId}\n";
        
        // إضافة رابط الصورة
        if (item.productThumbnailImage != null && item.productThumbnailImage!.isNotEmpty) {
          message += "🖼️ صورة المنتج: ${item.productThumbnailImage}\n";
        }

        if (item.variation != null && item.variation!.isNotEmpty) {
          message += "🎨 المواصفات: ${item.variation}\n";
        }
        
        message += "-------------------\n";
        totalPrice += itemPrice * (item.quantity ?? 1);
      }
    }

    message += "\n💵 السعر الإجمالي: ${totalPrice.toStringAsFixed(2)} ريال\n";
    message += "\nشكراً لاختياركم برهه 🌟";

    final String whatsappNumber = "+967778821618";
    final String whatsappUrl = "https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(message)}";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("لا يمكن فتح تطبيق واتساب"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


}

