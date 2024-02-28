// Packages:
import 'dart:convert';

import 'package:http/http.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stream_deck/data/http/http.dart';

// Generated file:
import 'http_adapter_test.mocks.dart';

class HttpAdapter implements HttpClientProject {
  final MockClient client;

  HttpAdapter(this.client);

  @override
  Future<Map> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return response.body.isEmpty ? {} : jsonDecode(response.body);
  }
}

@GenerateMocks([Client])
void main() {
  late MockClient client;
  late HttpAdapter sut;
  late String url;
  late Map<String, String> headers;

  setUp(() {
    client = MockClient();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
  });

  group('Post', () {
    test('Should call post with correct values', () async {
      when(client.post(
        Uri.parse(url),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(
        Uri.parse(url),
        headers: headers,
        body: '{"any_key":"any_value"}',
      ));
    });

    test('Should call post without body', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(url: url, method: 'post');

      verify(client.post(
        Uri.parse(url),
        headers: headers,
      ));
    });

    test('Should return data if post returns 200', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no data', () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response('', 200));

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });
  });
}
