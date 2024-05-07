import 'package:test/test.dart';
import 'package:butlerbot/butlerbot.dart';

void main() {
  group('loadFAQEntries', () {
    test('loads FAQ entries from a YAML file', () async {
      // Assuming loadFAQEntries function uses a file path to load the YAML data
      List<FAQEntry> faqs = await loadFAQEntries('lib/faq.yml');

      // Verify the expected output
      expect(faqs[0].command, "buy");
      expect(faqs[0].description, "Where to buy Peercoin?");
      expect(faqs[0].answer,
          "Coinmarketcap has the most up to date list of exchanges where PPC is traded and you can purchase PPC from: https://coinmarketcap.com/currencies/peercoin/#Markets");
    });
  });
}
