import 'dart:convert';

import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

Future initiate(BaseClient client) async {
  // Make API call to Hackernews homepage
  Response response = await client.get('https://news.ycombinator.com');

  if (response.statusCode != 200) return response.body;

  // Use html parser
  var document = parse(response.body);
  List<Element> links = document.querySelectorAll('td.title > a.storylink');
  List<Map<String, dynamic>> linkMap = [];

  for (var link in links) {
    linkMap.add({
      'title': link.text,
      'href': link.attributes['href'],
    });
  }

  return json.encode(linkMap);
}
