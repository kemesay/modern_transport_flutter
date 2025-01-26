
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modern_transportation/utils/constants.dart';
import 'package:modern_transportation/utils/styles.dart';
import 'package:modern_transportation/widgets/header_widget.dart';

class SupportPage extends StatelessWidget {
  static const routeName = "support";

  const SupportPage({super.key});

  _buildRowWidgets(IconData iconData, String title, String subtitle) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          color: Constatnts.primaryColor,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(subtitle, style: CustomStyles.smallTextStyle)
          ],
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
                height: 500,
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
                          const BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 5),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.headset,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Contact us@",
                      textAlign: TextAlign.center,
                      style: CustomStyles.cardBoldDarkTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 30),
                      child: Column(
                        children: <Widget>[
                          _buildRowWidgets(FontAwesomeIcons.telegram,
                              "telegram", "https://t.me/@SisayLA"),
                          const SizedBox(
                            height: 25,
                          ),
                               _buildRowWidgets(FontAwesomeIcons.link, "Web-site",
                              "https://odatransportation.com"),
                          const SizedBox(
                            height: 25,
                          ),
                          _buildRowWidgets(FontAwesomeIcons.facebook,
                              "facebook", "https://web.facebook.com/Oda.Transportation"),
                          const SizedBox(
                            height: 25,
                          ),
                          _buildRowWidgets(FontAwesomeIcons.twitter, "twitter/X",
                              "https://x.com/odatransport?s=21"),
                          const SizedBox(
                            height: 25,
                          ),
                          _buildRowWidgets(FontAwesomeIcons.instagram,
                              "instagram", "https://www.instagram.com/odatransportation/profilecard/?igsh=NTc4MTIwNjQ2YQ=="),
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
                  "Call Center",
                  style: CustomStyles.cardBoldTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
