import 'package:flutter/widgets.dart';

extension NavigationExtensions on BuildContext {
  /// Pushes a new named route onto the navigation stack
  Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

//pushNamedAndRemoveAllExceptFirst
  /// Pushes a new named route and removes all routes except the first
  // Future<T?> pushNamedAndRemoveAllExceptFirst<T extends Object?>(
  //     String routeName,
  //     {Object? arguments}) {
  //   return Navigator.of(this).pushNamedAndRemoveUntil<T>(
  //     routeName,
  //     (route) => route.isFirst,
  //     arguments: arguments,
  //   );
  // }

  /// Pushes a new route and removes all previous routes that do not satisfy [predicate]
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    required RoutePredicate predicate,
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  /// Replaces the current route with a new named route
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
    );
  }

  /// Pops routes until the first one
  void popUntilFirst() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  /// Pops the top-most route
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// Pops current screen and returns true to the previous screen
  void popWithTrueResult() {
    Navigator.of(this).pop(true);
  }

  /// Pushes a route and waits for a result
  Future<T?> pushNamedForResult<T extends Object?>(String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Goes back until reaching the route with the specified name
  void popUntilRouteName(String name) {
    Navigator.of(this).popUntil((route) => route.settings.name == name);
  }

  /// Replaces all routes and pushes the named route
  Future<T?> pushNamedAndRemoveAll<T extends Object?>(String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
