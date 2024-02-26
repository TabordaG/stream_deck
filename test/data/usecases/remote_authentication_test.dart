import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'remote_authentication_test.mocks.dart';

class RemoteAuthentication {
  final HttpClientProject httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(
      url: url,
      method: 'post',
    );
  }
}

abstract class HttpClientProject {
  Future<void> request({
    required String url,
    required String method,
  });
}

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([HttpClientProject])
void main() {
  late RemoteAuthentication sut;
  late MockHttpClientProject httpClientMock;
  late String url;

  setUp(() {
    httpClientMock = MockHttpClientProject();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClientMock, url: url);
  });

  test('Should call HttpClient with corrent values', () async {
    when(httpClientMock.request(
      url: url,
      method: 'post',
    )).thenAnswer((_) => Future.value());

    await sut.auth();

    verify(httpClientMock.request(
      url: url,
      method: 'post',
    ));
  });
}
