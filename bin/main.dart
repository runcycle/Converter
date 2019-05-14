import 'dart:io';
import 'package:prompter_jcb/prompter_jcb.dart';

void main () {
  final prompter = new Prompter();

  final choice = prompter.askBinary('Would you like to convert an image?');
  if (!choice) {
    exit(0);
  }

  final format = prompter.askMultiple('Select format:', buildFormatOptions());
  // prompter.askMultiple('Select an image to convert:', buildFileOptions());
  buildFileOptions();
}

List<Option> buildFormatOptions() {
  return [
    new Option('Convert to jpeg', 'jpeg'),
    new Option('Convert to png', 'png')
  ];
}

List<Option> buildFileOptions() {
  return Directory.current
    .listSync()
    .where((entity) {
      return FileSystemEntity.isFileSync(entity.path) 
      && entity.path.contains(new RegExp(r'\.(png|jpg|jpeg)'));
    }).map((entity) {
      final filename = entity.path.split(Platform.pathSeparator).last;
      return new Option(filename, entity);
    }).toList();
}