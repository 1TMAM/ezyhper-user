import 'package:flutter/material.dart';

class SlideFromLeftPageRoute extends PageRouteBuilder {
  Widget widget;
  SlideFromLeftPageRoute({this.widget}) : super(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}
class SlideFromBottomPageRoute extends PageRouteBuilder {
  final Widget widget;

  SlideFromBottomPageRoute({this.widget}) : super(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, 1.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      }
  );
}

class SlideFromRightPageRoute extends PageRouteBuilder {
  final Widget widget;

  SlideFromRightPageRoute({this.widget}) : super(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      }
  );
}
class SlideFromTopRoute extends PageRouteBuilder {
  final Widget widget;

  SlideFromTopRoute({this.widget}) : super(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, -1.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      }
  );
}



