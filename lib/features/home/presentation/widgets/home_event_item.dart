import 'package:alafein/core/utility/assets_data.dart';
import 'package:alafein/core/utility/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/api/constants/api_caller_config.dart';

class HomeEventItem extends StatelessWidget {
  final String image;
  final String catImage;
  final String name;
  final String date;

  const HomeEventItem({
    super.key,
    required this.image,
    required this.catImage,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 180,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                height: 120,
                imageUrl:image,
                errorWidget:  (context, url, error) =>
                    Image.asset(AssetsData.eventImg),
              ),
              Positioned(
                  bottom: 5,
                  right: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      imageUrl:
                      catImage,
                      fit: BoxFit.fitWidth,
                      errorWidget: (context, url, error) =>
                          Image.asset(
                            AssetsData.music,
                            fit: BoxFit.contain,
                          ),
                    ),
                  ))
            ],
          ),
          const Gap(8),
          Text(
            name,
            style: homeLabel2Style,
          ),
          Text(date, style: secondaryTextStyle)
        ],
      ),
    );
  }
}
