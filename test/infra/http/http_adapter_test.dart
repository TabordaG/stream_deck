// Packages:
import 'dart:io';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generated file:
import 'http_adapter_test.mocks.dart';

class HttpAdapter {
  final MockHttpClient client;

  HttpAdapter(this.client);

  Future<void> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    await client.post(url, null, null);
  }
}

@GenerateMocks([HttpClient, HttpClientRequest, HttpClientResponse])
void main() {
  group('Post', () {
    test('Should call post with correct values', () async {
      final client = MockHttpClient();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      when(client.post(
        url,
        null,
        null,
      )).thenAnswer((_) async => MockHttpClientRequest());

      await sut.request(url: url, method: 'post');

      verify(client.post(url, null, null));
    });
  });
}
