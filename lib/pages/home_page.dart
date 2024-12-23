import 'package:dca/components/footer.dart';
import 'package:dca/components/my_app_bar.dart';
import 'package:dca/pages/explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ad_manager_web/flutter_ad_manager_web.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _urlPrivacy = Uri.parse('https://thrive.framer.media/privacy');

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> _launchUrlPrivacy() async {
  if (!await launchUrl(_urlPrivacy)) {
    throw Exception('Could not launch');
  }
}

    final mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          // APP BAR
          Padding(
        padding: const EdgeInsets.only(left: 270, right: 270, top: 20),
        child: MyAppBar(),
      ),

      // SITE
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
          padding: const EdgeInsets.only(top: 200),
          child: SelectableText("Site of the Week", style: TextStyle(
            color: Color.fromARGB(255, 206, 205, 195),
            fontSize: 50,
            fontWeight: FontWeight.w600
          ),),
        ),

        SizedBox(height: 20,),

          SelectableText("Luis Schröder", style: TextStyle(
            color: Color.fromARGB(255, 158, 158, 151),
            fontSize: 25,
            fontWeight: FontWeight.w600
          ),),


        SizedBox(height: 140,),

              Container(
              width: 1600,
              height: 930,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color.fromARGB(255, 206, 205, 195),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "lib/assets/example.png",
                  width: 1200,
                  height: 930,
                  ),
              ),
                      ),

            SizedBox(height: 180,),

            SelectableText("NOMINEES", style: TextStyle(
            color: Color.fromARGB(255, 206, 205, 195),
            fontSize: 180,
            fontWeight: FontWeight.bold
          ),),

          SizedBox(height: 1,),

          SelectableText("Vote now for the best Project in these categories", style: TextStyle(
            color: Color.fromARGB(255, 158, 158, 151),
            fontSize: 25,
            fontWeight: FontWeight.w600
          ),),

          SizedBox(height: 90,),

          // CATEGORIES
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // WEBSITES
              InkWell(
                onTap: () {
                  
                },
                child: Stack(
                  children: [
                    Container(
                        width: 600,
                        height: 348,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromARGB(255, 206, 205, 195),
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "lib/assets/example.png",
                            width: 600,
                            height: 348,
                            ),
                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 200, right: 200, top: 150),
                                  child: SelectableText("W E B S I T E S", style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),),
                                ),
                  ],
                ),
              ),

              SizedBox(width: 20,),

              // MOBILE APPS
              InkWell(
                onTap: () {
                  
                },
                child: Stack(
                  children: [
                    Container(
                        width: 600,
                        height: 348,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromARGB(255, 206, 205, 195),
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "lib/assets/example.png",
                            width: 600,
                            height: 348,
                            ),
                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 200, right: 200, top: 150),
                                  child: SelectableText("M O B I L E   A P P S", style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),),
                                ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20,),

          // SECOND CATEGORIES
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // PACKAGES
                  InkWell(
                    onTap: () {
                      
                    },
                    child: Stack(
                      children: [
                        Container(
                            width: 600,
                            height: 348,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color.fromARGB(255, 206, 205, 195),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "lib/assets/example.png",
                                width: 600,
                                height: 348,
                                ),
                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 200, right: 200, top: 150),
                                      child: SelectableText("P A C K A G E S", style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                    ),
                      ],
                    ),
                  ),
              
                  SizedBox(width: 20,),
            
                  // DESKTOP APPS
                  InkWell(
                    onTap: () {
                      
                    },
                    child: Stack(
                      children: [
                        Container(
                            width: 600,
                            height: 348,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color.fromARGB(255, 206, 205, 195),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "lib/assets/example.png",
                                width: 600,
                                height: 348,
                                ),
                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 200, right: 200, top: 150),
                                      child: SelectableText("D E S K T O P   A P P S", style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                    ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 100,),

            Footer(),

            ],
          ),
        ),
      )
        ],
      )
    );
  }
}