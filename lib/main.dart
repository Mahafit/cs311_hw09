import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hw9_video_display/video_player_page.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class VideoData {
  String fileName;
  String videoLink;
  String uploadTime;
  String profileLink;

  VideoData(this.fileName, this.videoLink, this.uploadTime, this.profileLink);
}

List MOCK_VIDEO_DATA = [
  VideoData(
    'BigBuckBunny.mp4',
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    '1 hours ago',
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/bd47835c-cde6-46d1-8221-8df5c805fb95/da5ffqi-334c4bfc-f0d0-48c5-952e-17414d610c3d.png/v1/fill/w_1024,h_1024,q_80,strp/self_portrait_for_my_youtube_channel_s_profile_pic_by_lucaslikesdrawing_da5ffqi-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcL2JkNDc4MzVjLWNkZTYtNDZkMS04MjIxLThkZjVjODA1ZmI5NVwvZGE1ZmZxaS0zMzRjNGJmYy1mMGQwLTQ4YzUtOTUyZS0xNzQxNGQ2MTBjM2QucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.PNwtBNS__T9G1zqNp3HNwUwf6Ls1DANx_1JyctsYMAo',
  ),
  VideoData(
    'ForBiggerBlazes.mp4',
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    'just now',
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/bd47835c-cde6-46d1-8221-8df5c805fb95/da5ffqi-334c4bfc-f0d0-48c5-952e-17414d610c3d.png/v1/fill/w_1024,h_1024,q_80,strp/self_portrait_for_my_youtube_channel_s_profile_pic_by_lucaslikesdrawing_da5ffqi-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcL2JkNDc4MzVjLWNkZTYtNDZkMS04MjIxLThkZjVjODA1ZmI5NVwvZGE1ZmZxaS0zMzRjNGJmYy1mMGQwLTQ4YzUtOTUyZS0xNzQxNGQ2MTBjM2QucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.PNwtBNS__T9G1zqNp3HNwUwf6Ls1DANx_1JyctsYMAo',
  ),
  VideoData(
    'ForBiggerEscapes.mp4',
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    '43 minutes ago',
    'https://i.ibb.co/TtyrtYs/profile.jpg',
  ),
  VideoData(
    'ForBiggerFun.mp4',
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
    '4 hours ago',
    'https://i.ibb.co/TtyrtYs/profile.jpg',
  ),
  VideoData(
    'ForBiggerJoyrides.mp4',
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    '23 minutes ago',
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/bd47835c-cde6-46d1-8221-8df5c805fb95/da5ffqi-334c4bfc-f0d0-48c5-952e-17414d610c3d.png/v1/fill/w_1024,h_1024,q_80,strp/self_portrait_for_my_youtube_channel_s_profile_pic_by_lucaslikesdrawing_da5ffqi-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcL2JkNDc4MzVjLWNkZTYtNDZkMS04MjIxLThkZjVjODA1ZmI5NVwvZGE1ZmZxaS0zMzRjNGJmYy1mMGQwLTQ4YzUtOTUyZS0xNzQxNGQ2MTBjM2QucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.PNwtBNS__T9G1zqNp3HNwUwf6Ls1DANx_1JyctsYMAo',
  ),
];

void main() {
  runApp(const MaterialApp(home: VideoList()));
}

class VideoList extends StatelessWidget {
  const VideoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
      ),
      body: ListView.builder(
        itemCount: MOCK_VIDEO_DATA.length,
        itemBuilder: (context, index) {
          VideoData videoData = MOCK_VIDEO_DATA[index];
          return Column(
            children: [
              // video thumbnail
              SizedBox(
                height: 200,
                child: ThumbnailImage(
                  videoLink: videoData.videoLink,
                ),
              ),

              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(videoData.profileLink),
                ),
                title: Text(videoData.fileName),
                subtitle: Text(videoData.uploadTime),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreenState(
                        videoLink: videoData.videoLink,
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}

class ThumbnailImage extends StatefulWidget {
  final String videoLink;
  const ThumbnailImage({super.key, required this.videoLink});

  @override
  State<ThumbnailImage> createState() => _ThumbnailImageState();
}

class _ThumbnailImageState extends State<ThumbnailImage> {
  String? _thumbnailUrl;

  @override
  void initState() {
    super.initState();
    generateThumbnail();
  }

  void generateThumbnail() async {
    Directory tempDir = await getTemporaryDirectory();

    _thumbnailUrl = await VideoThumbnail.thumbnailFile(
        video: widget.videoLink,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.WEBP);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _thumbnailUrl == null
        ? const CircularProgressIndicator()
        : Image.file(File(_thumbnailUrl!));
  }
}
