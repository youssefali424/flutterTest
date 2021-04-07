// import 'dart:io';

// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
// import 'package:path_provider/path_provider.dart';

// Future<int> getWaveForm(String url) async {
//     final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
//     final FlutterFFmpegConfig _flutterFFmpegConfig = FlutterFFmpegConfig();
//     // clear out path for new wave form
    
//     Directory appDocumentDir = await getApplicationDocumentsDirectory();
//     String rawDocumentPath = appDocumentDir.path;
//     // waveFormImagePath.value = [rawDocumentPath, '/audioWaveForm.png'].join();

//     // cachedAudioFile.value = await DefaultCacheManager().getSingleFile(url);
//     String inputFilePath = cachedAudioFile.value.path;
     
//     String commandToExecute = [
//       '-i $inputFilePath -ac 1 -filter:a aresample=8000 -map 0:a -c:a pcm_s16le -f data -',
//       waveFormImagePath.value
//     ].join();
//     _flutterFFmpeg
//         .execute(commandToExecute)
//         .then((rc) => print("FFmpeg process exited with rc $rc"));
//     int returnCode = await _flutterFFmpegConfig.getLastReturnCode();
//     var output = await _flutterFFmpegConfig.getLastCommandOutput();
//     print(output);
//     // print(waveFormImagePath.value);

//     return returnCode;
//   }