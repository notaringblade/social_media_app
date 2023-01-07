import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/auth/auth_page.dart';
import 'package:social_media_app/config/router_constants.dart';
import 'package:social_media_app/screens/followers_screen.dart';
import 'package:social_media_app/screens/other_user_screen.dart';
import 'package:social_media_app/screens/random_screen.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const AuthPage();
        },
        routes: <GoRoute>[
          GoRoute(
            path: 'user/:id',
            name: RouteConstants.user,
            builder: (BuildContext context, GoRouterState state) {
              return OtherUserScreen(
                userId: state.params['id']!,
              );
            },
          ),
          GoRoute(
            path: 'random',
            name: 'random',
            builder: (BuildContext context, GoRouterState state) {
              return const RandomScreen(
              );
            },
          ),
          GoRoute(
            path: 'followes/:id',
            name: RouteConstants.followers,
            builder: (BuildContext context, GoRouterState state) {
              return FollowersScreen(
                userId: state.params['id']!,
              );
            },
          ),
        ],
      ),
    ],
  );
}
