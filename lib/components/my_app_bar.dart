import 'package:dca/pages/submit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ad_manager_web/flutter_ad_manager_web.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
        ),
      backgroundColor: Color.fromARGB(255, 16, 15, 15),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset(
            "lib/assets/DCA_logo.png",
            width: 20,
            height: 20,
            ),
      ),
          actions: [

              SizedBox(width: 15,),

            InkWell(
              onTap: () {
              },
              child: Text("Explore", style: TextStyle(
                color: Color.fromARGB(255, 206, 205, 195),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                 ),),
            ),

            SizedBox(width: 15,),

              SizedBox(width: 15,),

              InkWell(
              onTap: () {},
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
                  child: Text(
                    "Support Us", 
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
              onTap: () {
                Navigator.push(context, PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => SubmitPage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                            ),);
              },
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