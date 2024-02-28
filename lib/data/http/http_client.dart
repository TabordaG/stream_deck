abstract class HttpClientProject {
  Future<Map?> request({
    required String url,
    required String method,
    Map body,
  });
}
