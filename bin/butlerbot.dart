import 'dart:io';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';
import 'package:butlerbot/butlerbot.dart';

List<BotCommand> assembleBotCommands(List<FAQEntry> faqs) {
  List<BotCommand> commands = [];

  for (var faq in faqs) {
    // Assuming you might want to format the question to a command-friendly format
    String command =
        faq.command.toLowerCase().replaceAll(' ', '_').replaceAll('?', '');

    // Create a new BotCommand using the question as command and description as description
    commands.add(BotCommand(command: command, description: faq.description));
  }

  return commands;
}

FAQEntry searchFAQs(List<FAQEntry> faqs, String keyword) {
  // Find the first FAQ where the transformed 'question' appears like a command containing the keyword
  return faqs.firstWhere((faq) => faq.command.contains(keyword));
}

void setupCommands(Bot bot, List<FAQEntry> faqs) {
  // programatically set bot commands
  for (var faq in faqs) {
    bot.command(faq.command, (ctx) async {
      await ctx.reply(faq.answer);
    });
  }
}

void main() async {
  // load FAQ
  List<FAQEntry> faqs = await loadFAQEntries('lib/faq.yml');

  final tgBotToken = Platform.environment["BOT_TOKEN"]!;

  print('Up and running!');

  // create commands out of the FAQs
  final commands = assembleBotCommands(faqs);

  // Create a new bot instance
  final bot = Bot(tgBotToken);

  // programatically construct the menu from FAQ
  await bot.api.setMyCommands(commands);

  // programatically setup bot commands based on the FAQ
  setupCommands(bot, faqs);

  /// Starts the bot
  bot.start();
}
