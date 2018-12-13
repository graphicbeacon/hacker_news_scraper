import 'package:http/http.dart';
import 'package:hacker_news_scraper/hacker_news_scraper.dart'
    as hacker_news_scraper;

Future main(List<String> arguments) async {
  print(await hacker_news_scraper.initiate(Client()));
}
