import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/l10n/app_localizations.dart';

import '../my_theme.dart';
import 'box_decorations.dart';

class HomeSearchBox extends StatelessWidget {
  const HomeSearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.search_anything,
              style: const TextStyle(
                  fontSize: 13.0,
                  color: MyTheme.textfield_grey
              ),
            ),
            Image.asset(
              'assets/search.png',
              height: 16,
              color: MyTheme.dark_grey,
            ),
          ],
        ),
      ),
    );
  }
}


