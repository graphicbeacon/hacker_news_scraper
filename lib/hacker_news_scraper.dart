import 'dart:io';
import 'dart:convert';

import 'package:html/parser.dart';
import 'package:html/dom.dart';

initiate() async {
  // Create HttpClient
  HttpClientRequest client =
      await HttpClient().getUrl(Uri.parse('https://news.ycombinator.com'));

  // Make API call to Hackernews homepage
  HttpClientResponse response = await client.close();

  // Use html parser
  var markup = '';

  await for (var data in response.transform(Utf8Decoder())) {
    markup += data;
  }

  var document = parse(markup);
  List<Element> links = document.querySelectorAll('td.title a.storylink');
  List<Map<String, dynamic>> linkMap = [];

  for (var link in links) {
    linkMap.add({
      'title': link.text,
      'href': link.attributes['href'],
    });
  }

  // Output
  print(json.encode(linkMap));
}
