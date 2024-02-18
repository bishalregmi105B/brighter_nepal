import 'package:brighter_nepal/pages/view_video.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:brighter_nepal/helper/youtube_video_thumbail.dart';
import 'package:brighter_nepal/models/videos_modal.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoCards extends StatefulWidget {
  final Videos video_li;

  const VideoCards({
    super.key,
    required this.video_li,
  });

  @override
  State<VideoCards> createState() => _VideoCardsState();
}

class _VideoCardsState extends State<VideoCards> {
  late String thumbnailUrl = "";

  @override
  void initState() {
    super.initState();
    loadThumbnailUrl(widget.video_li.video_url);
  }

  @override
  void didUpdateWidget(covariant VideoCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Load new thumbnail when the widget is updated
    if (oldWidget.video_li.video_url != widget.video_li.video_url) {
      loadThumbnailUrl(widget.video_li.video_url);
    }
  }

  loadThumbnailUrl(String videoUrl) async {
    try {
      String xyz = await getYouTubeThumbnailUrl(videoUrl);
      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          thumbnailUrl = xyz;
        });
      }
    } catch (e) {
      // Handle exceptions if any
      print("Error loading thumbnail: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: MyValues.primary_color,
      ),
      margin: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: MyValues.primary_color,
            ),
            child: (thumbnailUrl != "")
                ? CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    placeholder: (context, url) => Card_Skeletan(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : Center(child: Card_Skeletan()),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Text(
                  widget.video_li.name,
                  style: const TextStyle(color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewVideo(
                        currentVideoId:
                            extractVideoId(widget.video_li.video_url) ?? '',
                        title: widget.video_li.name ?? 'Default Title',
                        description: widget.video_li.description ??
                            'Default Description',
                      ),
                    ));
                  },
                  child: const Text("View"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
