import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.imageUrl});
  final imageUrl;

  @override
  Widget build(BuildContext context) {
    return imageUrl != null && imageUrl.isNotEmpty
        ? CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              imageUrl,
            ),
          )
        : const CircleAvatar(
            child: Icon(Icons.person),
          );
  }
}
