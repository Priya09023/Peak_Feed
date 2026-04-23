import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/post.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen({super.key, required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post")),
      body: Stack(
        children: [
          Hero(
            tag: widget.post.id,
            child: Image.network(
              widget.post.mediaThumbUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: loaded ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              child: Image.network(
                widget.post.mediaMobileUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    loaded = true;
                    return child;
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () async {
                await launchUrl(
                    Uri.parse(widget.post.mediaRawUrl));
              },
              child: const Text("Download High-Res"),
            ),
          )
        ],
      ),
    );
  }
}