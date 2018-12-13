import 'dart:convert';

import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:hacker_news_scraper/hacker_news_scraper.dart'
    as hacker_news_scraper;

void main() {
  MockClient client = null;

  test('calling initiate(client) returns a list of storylinks', () async {
    // Arrange
    client = MockClient((req) => Future(() => Response('''
      <body>
        <table><tbody><tr>
        <td class="title">
          <a class="storylink" href="https://google.com">Story title</a>
        </td>
        </tr></tbody></table>
      </body>
    ''', 200)));

    // Act
    var response = await hacker_news_scraper.initiate(client);

    // Assert
    expect(
        response,
        equals(json.encode([
          {
            'title': 'Story title',
            'href': 'https://google.com',
          }
        ])));
  });

  test('calling initiate(client) should silently fail', () async {
    // Arrange
    client = MockClient((req) => Future(() => Response('Failed', 400)));

    // Act
    var response = await hacker_news_scraper.initiate(client);

    // Assert
    expect(response, equals('Failed'));
  });
}
