// Packages:
import 'package:http/http.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generated file:
import 'http_adapter_test.mocks.dart';

class HttpAdapter {
  final MockClient client;

  HttpAdapter(this.client);

  Future<void> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    await client.post(Uri.parse(url), headers: headers);
  }
}

@GenerateMocks([Client, Request, Response])
void main() {
  group('Post', () {
    test('Should call post with correct values', () async {
      final client = MockClient();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();
      final headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
      };

      when(client.post(Uri.parse(url), headers: headers))
          .thenAnswer((_) async => MockResponse());

      await sut.request(url: url, method: 'post');

      verify(client.post(Uri.parse(url), headers: headers));
    });
  });
}
