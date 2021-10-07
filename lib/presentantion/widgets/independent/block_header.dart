import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class OpenFlutterBlockHeader extends StatelessWidget {
  final double? width;
  final String? title;
  final String? linkText;
  final VoidCallback? onLinkTap;
  final String? description;

  const OpenFlutterBlockHeader(
      {Key? key,
      this.width,
      this.title,
      this.linkText,
      this.onLinkTap,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rightLinkWidth = 100.0;
    return InkWell(
      onTap: onLinkTap,
      child: Container(
        padding: EdgeInsets.only(
            top: AppSizes.sidePadding, left: AppSizes.sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: width! - rightLinkWidth,
                  child: Text(title!,
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.w400)),
                ),
                linkText != null
                    ? Container(
                        width: rightLinkWidth,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(linkText!,
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 11,
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w400)),
                        ),
                      )
                    : Container(),
              ],
            ),
            description != null
                ? Text(
                    description!,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 11,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.w400),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
