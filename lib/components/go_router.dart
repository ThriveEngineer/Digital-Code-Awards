import 'package:dca/pages/explore_page.dart';
import 'package:dca/pages/explore_page_jury.dart';
import 'package:dca/pages/home_page.dart';
import 'package:dca/pages/nomination_page.dart';
import 'package:dca/pages/submission_detail_page.dart';
import 'package:dca/pages/submit_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';

GoRouter router = GoRouter(
  routes: [

    // Home
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      pageBuilder: GoTransitions.none,
      ),

      // Explore
      GoRoute(
      path: '/explore',
      builder: (context, state) => const ExplorePage(),
      pageBuilder: GoTransitions.none,
      ),

      // Submit
      GoRoute(
      path: '/submit',
      builder: (context, state) => SubmitPage(),
      pageBuilder: GoTransitions.none,
      ),

      // Explore Jury
      GoRoute(
      path: '/explorejury',
      pageBuilder: GoTransitions.none,
      builder: (context, state) => const ExplorePageJury(),
      ),

      // Nomination
      GoRoute(
      path: '/nominationjury',
      pageBuilder: GoTransitions.none,
      builder: (context, state) => const NominationPage(),
      ),
  ],
);