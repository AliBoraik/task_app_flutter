import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';

class WelcomeScreenTopImage extends StatelessWidget {
  const WelcomeScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 8,
              child: SvgPicture.asset(kloginIcon),
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding * 2),
      ],
    );
  }
}
