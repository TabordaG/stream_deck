// Packages:
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

// Data Layer:
import 'package:stream_deck/data/http/http.dart';
import 'package:stream_deck/data/usecases/usecases.dart';

// Domain Layer:
import 'package:stream_deck/domain/helpers/helpers.dart';
import 'package:stream_deck/domain/usecases/usecases.dart';

// Generated file:
import 'remote_authentication_test.mocks.dart';

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
      body: anyNamed('body'),
    )).thenAnswer((_) => Future.value());

    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
    await sut.auth(params);

    verify(httpClientMock.request(
      url: url,
      method: 'post',
      body: {
        'email': params.email,
        'password': params.secret,
      },
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    when(httpClientMock.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      body: anyNamed('body'),
    )).thenThrow(HttpError.badRequest);

    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
