import 'package:dca/components/footer.dart';
import 'package:dca/components/my_app_bar.dart';
import 'package:dca/pages/explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ad_manager_web/flutter_ad_manager_web.dart';
import 'package:go_router/go_router.dart';
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
    final currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          // APP BAR
          Padding(
        padding: 
        currentWidth > 1200 ? 
        const EdgeInsets.only(left: 270, right: 270, top: 20) : 
        const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: const MyAppBar(),
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


        currentWidth > 1200 ? SizedBox(height: 140,) : SizedBox(height: 70,),

              Container(
              width: currentWidth > 1200 ? 1600 : 400,
              height: currentWidth > 1200 ? 930 : 233,
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

            currentWidth > 1200 ? SizedBox(height: 180,) : SizedBox(height: 90,),

            currentWidth > 1363 ? SelectableText("NOMINEES", style: TextStyle(
            color: Color.fromARGB(255, 206, 205, 195),
            fontSize: currentWidth > 1200 ? 180 : 90,
            fontWeight: FontWeight.bold
          ),) : Text(""),

          SizedBox(height: 1,),

          currentWidth > 1363 ? SelectableText("Vote now for the best Project in these categories", style: TextStyle(
            color: Color.fromARGB(255, 158, 158, 151),
            fontSize: currentWidth > 1200 ? 25 : 15,
            fontWeight: FontWeight.w600
          ),) : Text(""),

          SizedBox(height: 90,),

          // CATEGORIES
          currentWidth > 1363 ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // WEBSITES
              InkWell(
                onTap: () {GoRouter.of(context).go('/explore');},
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
                onTap: () {GoRouter.of(context).go('/explore');},
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
          ) : Row(),

          SizedBox(height: 20,),

          // SECOND CATEGORIES
            currentWidth > 1363 ? Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // PACKAGES
                  InkWell(
                    onTap: () {GoRouter.of(context).go('/explore');},
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
                    onTap: () {GoRouter.of(context).go('/explore');},
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
            ) : Row(),

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