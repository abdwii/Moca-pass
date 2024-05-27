import 'package:alafein/core/utility/assets_data.dart';
import 'package:alafein/core/utility/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListEventItems extends StatelessWidget {
  const ListEventItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
      itemBuilder: (context, index) => SizedBox(
        child: Column(
          children: [
            Image.asset(
              AssetsData.music,
              // fit: BoxFit.cover,
            ),
            const Gap(4),
            const Text(
              'Music',
              textAlign: TextAlign.center,
              style: homeLabel3Style,
            ),
          ],
        ),
      ),
    );
  }
}
