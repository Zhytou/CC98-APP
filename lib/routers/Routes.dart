import 'package:fluro/fluro.dart';

import 'RouteHandler.dart';

class Routes {
  static String root = '/';
  static String help = '/help';
  static String search = '/search';
  static String write = '/write';
  static String reply = '/reply';

  static String topic = '/topic';
  static String board = '/board';
  static String user = '/user';

  static String me = '/me';
  static void configureRoutes(FluroRouter router) {
    router.define(help, handler: helpHandler);
    router.define(search, handler: searchHandler);
    router.define(write, handler: writeHandler);
    router.define(reply, handler: replyHandler);

    router.define(topic, handler: topicHandler);
    router.define(board, handler: boardHandler);
    router.define(user, handler: userHandler);
    router.define(me, handler: meHandler);
    router.notFoundHandler = emptyHandler;
  }
}
