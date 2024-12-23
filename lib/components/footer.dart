import 'package:dca/pages/explore_page.dart';
import 'package:dca/pages/home_page.dart';
import 'package:dca/pages/submit_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _urlPrivacy = Uri.parse('https://thrive.framer.media/privacy');
final Uri _urlBluesky = Uri.parse('https://bsky.app/profile/digitalcodeawards.bsky.social');
final Uri _urlThreads = Uri.parse('https://www.threads.net/@digital.code.awards');
final Uri _urlInstagram = Uri.parse('https://www.instagram.com/digital.code.awards/');
final Uri _urlPosts = Uri.parse('https://posts.cv/digital.code.awards');

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrlPrivacy() async {
  if (!await launchUrl(_urlPrivacy)) {
    throw Exception('Could not launch');
  }
}

Future<void> _launchUrlBluesky() async {
  if (!await launchUrl(_urlBluesky)) {
    throw Exception('Could not launch');
  }
}

Future<void> _launchUrlThreads() async {
  if (!await launchUrl(_urlThreads)) {
    throw Exception('Could not launch');
  }
}

Future<void> _launchUrlInstagram() async {
  if (!await launchUrl(_urlInstagram)) {
    throw Exception('Could not launch');
  }
}

Future<void> _launchUrlPosts() async {
  if (!await launchUrl(_urlPosts)) {
    throw Exception('Could not launch');
  }
}

final mediaQueryData = MediaQuery.of(context);
    return // FOOTER
            Container(
              width: mediaQueryData.size.width,
              height: 230,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 16, 15, 15),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                
                    // Pages
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          child: SelectableText(
                            "Pages",
                            style: TextStyle(
                              color: Color.fromARGB(255, 158, 158, 151),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                        ),
                
                          InkWell(
                            onTap: () {
                              Navigator.push(context, PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => HomePage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                            ),);
                            },
                            child: Text("Home", style: TextStyle(
                              color: Color.fromARGB(255, 206, 205, 195),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                
                          InkWell(
                            onTap: () {
                              Navigator.push(context, PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => ExplorePage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                            ),
                                );
                            },
                            child: Text("Explore", style: TextStyle(
                              color: Color.fromARGB(255, 206, 205, 195),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                
                          InkWell(
                            onTap: () {
                              Navigator.push(context, PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => SubmitPage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                            ),);
                            },
                            child: Text("Submit", style: TextStyle(
                              color: Color.fromARGB(255, 206, 205, 195),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                      ],
                    ),

                    SizedBox(width: 30,),

                    // Connect
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            
                          },
                          child: SelectableText(
                            "Connect",
                            style: TextStyle(
                              color: Color.fromARGB(255, 158, 158, 151),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                        ),
                
                          InkWell(
                            onTap: () {
                              _launchUrlBluesky();
                            },
                            child: Text("Bluesky", style: TextStyle(
                              color: Color.fromARGB(255, 206, 205, 195),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                
                          InkWell(
                            onTap: () {
                              _launchUrlThreads();
                            },
                            child: Text("Threads", style: TextStyle(
                              color: Color.fromARGB(255, 206, 205, 195),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                
                          InkWell(
                            onTap: () {
                              _launchUrlPosts();
                            },
                            child: Text("Posts.cv", style: TextStyle(
                              color: Color.fromARGB(255, 206, 205, 195),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),

                          InkWell(
                            onTap: () {
                              _launchUrlInstagram();
                            },
                            child: Text("Instagram", style: TextStyle(
                              color: Color.fromARGB(255, 206, 205, 195),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                      ],
                    ),

                    SizedBox(width: 30,),

                    // Legal Terms
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            
                          },
                          child: SelectableText(
                            "Legal Terms",
                            style: TextStyle(
                              color: Color.fromARGB(255, 158, 158, 151),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                        ),

                        InkWell(
                            onTap: () {
                              _launchUrlPrivacy();
                            },
                            child: Text("Privacy Policy", style: TextStyle(
                              color: Color.fromARGB(255, 206, 205, 195),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
  }
}