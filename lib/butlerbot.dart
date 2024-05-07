import 'dart:io';
import 'package:yaml/yaml.dart';

class FAQEntry {
  // stores FAQ entry

  String command;
  String description;
  String answer;

  FAQEntry(
      {required this.command, required this.description, required this.answer});

  @override
  String toString() {
    return 'command: $command\ndescription: $description\nAnswer: $answer';
  }
}

Future<List<FAQEntry>> loadFAQEntries(String filePath) async {
  // Read the YAML file
  var yamlString = await File(filePath).readAsString();
  var yamlData = loadYaml(yamlString);

  // Parse the YAML data into a list of FAQEntry objects
  List<FAQEntry> entries = [];
  for (var entry in yamlData['faq']) {
    entries.add(FAQEntry(
      command: entry['command'],
      description: entry['description'],
      answer: entry['answer'],
    ));
  }
  return entries;
}
