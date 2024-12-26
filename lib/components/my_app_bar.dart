import 'package:dca/pages/explore_page.dart';
import 'package:dca/pages/submit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ad_manager_web/flutter_ad_manager_web.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _urlKofi = Uri.parse('https://ko-fi.com/thriveengineer');

class MyAppBar extends StatelessWidget {

  Future<void> _launchUrlKofi() async {
  if (!await launchUrl(_urlKofi)) {
    throw Exception('Could not launch');
  }
}

  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    final currentWidth = MediaQuery.of(context).size.width;
    
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
        ),
      backgroundColor: Color.fromARGB(255, 16, 15, 15),
      leading: Padding(
        padding: currentWidth > 600 ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(left: 0),
        child: currentWidth > 600 ? Image.asset(
            "lib/assets/DCA_logo.png",
            width: 20,
            height: 20,
            ) : null,
      ),
          actions: [

              SizedBox(width: 15,),

            currentWidth > 600 ?InkWell(
              onTap: () {GoRouter.of(context).go('/explore');},
              child: Text("Explore", style: TextStyle(
                color: Color.fromARGB(255, 206, 205, 195),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                 ),),
            ) : SizedBox(width: 0,),

            currentWidth > 1200 ? 
            SizedBox(width: 15,) : 
            SizedBox(width: 0,),

              SizedBox(width: 15,),

              InkWell(
              onTap: currentWidth > 600 ? () {
                _launchUrlKofi();
              } : () {
                GoRouter.of(context).go('/explore');
              },
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 28, 27, 26),
                  boxShadow: null,
                  border: Border.all(color: Color.fromARGB(255, 52, 51, 49), width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: currentWidth > 600 ? Text(
                    "Support Us", 
                    style: TextStyle(
                      color: Color.fromARGB(255, 206, 205, 195),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )
                  ) : Text(
                    "Explore", 
                    style: TextStyle(
                      color: Color.fromARGB(255, 206, 205, 195),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )
                  )
                     ),
              ),
            ),

            SizedBox(width: 15,),

            InkWell(
              onTap: () {GoRouter.of(context).go('/submit');},
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 16, 15, 15),
                  border: Border.all(color: Color.fromARGB(255, 52, 51, 49), width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Submit", 
                    style: TextStyle(
                      color: Color.fromARGB(255, 206, 205, 195),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                       ),
                      )
                     ),
              ),
            ),

            SizedBox(width: 20,),

          ],
    );
  }
}