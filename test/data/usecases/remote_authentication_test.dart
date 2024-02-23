import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class RemoteAuthentication {
  final HttpClientProject httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {}
}

abstract class HttpClientProject {
  Future<void> request({required String url});
}

class HttpClientSpy extends Mock implements HttpClientProject {}

void main() {
  test('Should call HttpClient with corrent URL', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();

    final sut = RemoteAuthentication(httpClient: httpClient, url: url);

    await sut.auth();

    verify(httpClient.request(url: url));
  });
}
