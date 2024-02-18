import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<String> getYouTubeThumbnailUrl(String videoUrl) async {
  var youtube = YoutubeExplode();

  // Extract video ID using a regular expression
  var match = RegExp(r'youtube\.com\/.*[?&]v=([^&]+)').firstMatch(videoUrl);
  var videoId = match?.group(1) ?? '';

  var video = await youtube.videos.get(videoId);
  youtube.close();

  return video.thumbnails.highResUrl;
}

String? extractVideoId(String videoUrl) {
  RegExp regExp = RegExp(r"youtube\.com\/.*[?&]v=([^&]+)");
  Match match = regExp.firstMatch(videoUrl) as Match;

  if (match.groupCount >= 1) {
    return match.group(1);
  } else {
    // Handle invalid or unsupported URL
    return null;
  }
}
