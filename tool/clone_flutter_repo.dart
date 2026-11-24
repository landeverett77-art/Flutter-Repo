import 'dart:convert';
import 'dart:io';

/// Clones the Flutter-Repo repository into [destination].
Future<int> cloneFlutterRepo({
  String destination = 'Flutter-Repo',
  String repositoryUrl =
      'https://github.com/landeverett77-art/Flutter-Repo.git',
}) async {
  final process = await Process.start(
    'git',
    ['clone', repositoryUrl, destination],
    mode: ProcessStartMode.normal,
  );

  process.stdout
      .transform(utf8.decoder)
      .listen((data) => stdout.write(data));
  process.stderr
      .transform(utf8.decoder)
      .listen((data) => stderr.write(data));

  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    stderr.writeln('Git clone failed with exit code $exitCode');
  }

  return exitCode;
}

Future<void> main(List<String> arguments) async {
  final destination = arguments.isNotEmpty ? arguments.first : 'Flutter-Repo';
  final exitCode = await cloneFlutterRepo(destination: destination);
  exitCode == 0
      ? stdout.writeln('Repository cloned into $destination')
      : exitCode;
  exitCode;
}
