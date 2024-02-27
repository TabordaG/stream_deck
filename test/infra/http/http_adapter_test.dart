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
      when(client.post(Uri.parse(url), headers: headers))
          .thenAnswer((_) async => MockResponse());

      await sut.request(url: url, method: 'post');

      verify(client.post(Uri.parse(url), headers: headers));
    });
  });
}
