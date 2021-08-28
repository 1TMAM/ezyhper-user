import 'package:ezhyper/Constants/colors.dart';
import 'package:ezhyper/Widgets/Shimmer/chip_design.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerChip extends StatefulWidget {
  @override
  _ShimmerChipState createState() => _ShimmerChipState();
}

class _ShimmerChipState extends State<ShimmerChip> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyColor,
      highlightColor: Colors.grey[350],
      child: ChipDesign(
        color: greyColor,
        label: '                  ',
        txtColor: greenColor,
      ),
    );
  }
}
