abstract class StatusCodes {
  // 400 -> 499
  static int get unauthorized => 401;
  static int get forbidden => 403;
  static int get notFound => 404;
  static int get timeout => 408;
  // 500 -> 599
  static int get internalServerError => 500;
}
