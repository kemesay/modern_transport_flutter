import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modern_transportation/pages/credit_card_page.dart';
import 'package:modern_transportation/pages/promo_code_page.dart';
import 'package:modern_transportation/pages/book_history_page.dart';
import 'package:modern_transportation/pages/settings_page.dart';
import 'package:modern_transportation/pages/support_page.dart';
import 'package:modern_transportation/utils/constants.dart';
import 'package:modern_transportation/utils/styles.dart';
import 'package:share_plus/share_plus.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.user,
              color: Constatnts.primaryColor,
              size: 40,
            ),
            title: const Text(
              "Good Morning",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            subtitle: Text(
              "Sisay.W",
              style: CustomStyles.cardBoldDarkDrawerTextStyle,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .popAndPushNamed(RideHistoryPage.routeName);
                  },
                  child: Text(
                    "Book History",
                    style: CustomStyles.cardBoldDarkDrawerTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Share.share(
                      "https://odatransportation.com",
                      subject: "Invite Your Friend To Oda Transportation",
                    );
                  },
                  child: Text(
                    "Invite Friends",
                    style: CustomStyles.cardBoldDarkDrawerTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .popAndPushNamed(PromoCodePage.routeName);
                  },
                  child: Text(
                    "Promo Codes",
                    style: CustomStyles.cardBoldDarkDrawerTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .popAndPushNamed(CreditCardPage.routeName);
                  },
                  child: Text(
                    "Credit Card",
                    style: CustomStyles.cardBoldDarkDrawerTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .popAndPushNamed(SettingsPage.routeName);
                  },
                  child: Text(
                    "Settings",
                    style: CustomStyles.cardBoldDarkDrawerTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .popAndPushNamed(SupportPage.routeName);
                  },
                  child: Text(
                    "Support",
                    style: CustomStyles.cardBoldDarkDrawerTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  child: Text(
                    "Log Out",
                    style: CustomStyles.cardBoldDarkTextStyle,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
