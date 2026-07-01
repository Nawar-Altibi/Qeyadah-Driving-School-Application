abstract final class Endpoints {
  static const String sampleItems = '/posts';
  static String sampleItemById(String id) => '/posts/$id';
  static const String authLogin = '/auth/login';
  static const String authRefresh = '/auth/refresh';
}
