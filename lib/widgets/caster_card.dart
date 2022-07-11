import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CasterCard extends StatelessWidget {
  final String? url;
  final String gender;
  const CasterCard({Key? key, this.url, required this.gender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 182, 180, 180),
        borderRadius: BorderRadius.circular(500),
      ),
      child: url != null
          ? CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500$url',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const Center(),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                );
              },
              fit: BoxFit.cover,
            )
          : Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  image: DecorationImage(
                      image: gender == '2'
                          ? const AssetImage("assets/icons/male-avatar.png")
                          : const AssetImage("assets/icons/female-avatar.png"),
                      fit: BoxFit.fitHeight)),
            ),
    );
  }
}
