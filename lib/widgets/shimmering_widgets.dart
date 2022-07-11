import 'package:flutter/material.dart';
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
