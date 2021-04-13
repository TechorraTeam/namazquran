import 'package:Nimaz_App_Demo/constants/my_textstyle.dart';
import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            'Review Our App',
            style: myTextStyle,
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent
            ),
              onPressed: (){
                AppReview.storeListing.then((value){
                  print(value);
                });
              },
              child: Text('Review')),
          SizedBox(height: 50,),
          Text(
            'Contact Us',
            style: myTextStyle,
          ),

          SizedBox(height: 10,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent
              ),
              onPressed: (){
                final Uri _emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'contact@alquranonline.net',
                    queryParameters: {
                      'subject': 'App Experience of Al-Quran Online!'
                    }
                );

// ...

// mailto:smith@example.com?subject=Example+Subject+%26+Symbols+are+allowed%21
                launch(_emailLaunchUri.toString());
              },
              child: Text('Contact Us')),

        ],
      ),
    );
  }
}
