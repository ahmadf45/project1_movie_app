import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 182, 180, 180),
      highlightColor: Color.fromARGB(255, 139, 139, 139),
      enabled: true,
      period: const Duration(milliseconds: 1000),
      child: Container(
        width: screenSize.width * 0.3,
        height: screenSize.width * 0.3 / 3 * 4,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class CasterCardShimmer extends StatelessWidget {
  const CasterCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 182, 180, 180),
      highlightColor: const Color.fromARGB(255, 139, 139, 139),
      enabled: true,
      period: const Duration(milliseconds: 1000),
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(500),
        ),
      ),
    );
  }
}

class GenreShimmer extends StatelessWidget {
  const GenreShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.6,
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 182, 180, 180),
        highlightColor: const Color.fromARGB(255, 139, 139, 139),
        enabled: true,
        period: const Duration(milliseconds: 1000),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Text("_listGenre.join(', ')",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(fontSize: 12, color: Colors.white)),
        ),
      ),
    );
  }
}

class DurationRatingShimmer extends StatelessWidget {
  const DurationRatingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenSize.width * 0.15,
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 182, 180, 180),
              highlightColor: const Color.fromARGB(255, 139, 139, 139),
              enabled: true,
              period: const Duration(milliseconds: 1000),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Text("_de",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 15, color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: screenSize.width * 0.15,
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 182, 180, 180),
              highlightColor: const Color.fromARGB(255, 139, 139, 139),
              enabled: true,
              period: const Duration(milliseconds: 1000),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Text("_det",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 15, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DescriptionShimmer extends StatelessWidget {
  const DescriptionShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 182, 180, 180),
            highlightColor: const Color.fromARGB(255, 139, 139, 139),
            enabled: true,
            period: const Duration(milliseconds: 1000),
            child: Container(
              color: Colors.white,
              height: 10,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 182, 180, 180),
            highlightColor: const Color.fromARGB(255, 139, 139, 139),
            enabled: true,
            period: const Duration(milliseconds: 1000),
            child: Container(
              color: Colors.white,
              height: 10,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 182, 180, 180),
            highlightColor: const Color.fromARGB(255, 139, 139, 139),
            enabled: true,
            period: const Duration(milliseconds: 1000),
            child: Container(
              color: Colors.white,
              height: 10,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 182, 180, 180),
            highlightColor: const Color.fromARGB(255, 139, 139, 139),
            enabled: true,
            period: const Duration(milliseconds: 1000),
            child: Container(
              color: Colors.white,
              height: 10,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarProfileShimmer extends StatelessWidget {
  const AvatarProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 182, 180, 180),
      highlightColor: const Color.fromARGB(255, 139, 139, 139),
      enabled: true,
      period: const Duration(milliseconds: 1000),
      child: const CircleAvatar(
        radius: 70,
        backgroundColor: Colors.white,
      ),
    );
  }
}
