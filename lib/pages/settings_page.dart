
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modern_transportation/utils/constants.dart';
import 'package:modern_transportation/utils/styles.dart';
import 'package:modern_transportation/widgets/header_widget.dart';


class SettingsPage extends StatelessWidget {
  static const routeName = "account-settings";

  const SettingsPage({super.key});

  _buildRowWidget(IconData iconData, String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              iconData,
              color: Constatnts.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: CustomStyles.smallLightTextStyle,
                    ),
                    Text(subtitle, style: CustomStyles.smallTextStyle)
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(right: 30),
          height: 30,
          width: 75,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'Change',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: mQ.width,
            height: mQ.height,
          ),
          NoLogoHeaderWidget(height: mQ.height * 0.5),
          Positioned(
              top: mQ.height * 0.18,
              child: SizedBox(
                height: mQ.height,
                width: mQ.width,
                child: ListView(
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffd6d6d6),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 5),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.camera,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sisay .A",
                      textAlign: TextAlign.center,
                      style: CustomStyles.cardBoldDarkTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Favourites",
                        style: CustomStyles.cardBoldDarkTextStyle2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 30),
                      child: Column(
                        children: <Widget>[
                          _buildRowWidget(
                              FontAwesomeIcons.home, "home", "California, USA"),
                          const SizedBox(
                            height: 25,
                          ),
                          _buildRowWidget(FontAwesomeIcons.businessTime, "Travel",
                              "Los Angeles, Hollywood Boulevard"),
                          const SizedBox(
                            height: 25,
                          ),
                          _buildRowWidget(
                              Icons.travel_explore, "Travel Booking", "Hollywood Boulevard"),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
            top: 50.0,
            left: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.white,
                  textColor: Colors.green,
                  padding: const EdgeInsets.all(6),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 15,
                  ),
                ),
                Text(
                  "Account Settings",
                  style: CustomStyles.cardBoldTextStyle,
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.add,
                    color: Colors.grey,
                    size: 20,
                  ),
                  Text("Add New Plaace",
                      style: CustomStyles.smallLightTextStyle),
                ],
              ))
        ],
      ),
    );
  }
}
