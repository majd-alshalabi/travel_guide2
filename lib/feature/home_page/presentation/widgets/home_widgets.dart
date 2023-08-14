import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel_guide/core/global_widget/global_widget.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            BannerPlaceholder(),
            TitlePlaceholder(width: double.infinity),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.threeLines,
            ),
            SizedBox(height: 16.0),
            TitlePlaceholder(width: 200.0),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.twoLines,
            ),
            SizedBox(height: 16.0),
            TitlePlaceholder(width: 200.0),
            SizedBox(height: 16.0),
            ContentPlaceholder(
              lineType: ContentLineType.twoLines,
            ),
          ],
        ),
      ),
    );
  }
}
