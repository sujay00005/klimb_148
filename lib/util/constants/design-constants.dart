import 'package:flutter/material.dart';
import 'package:klimb_148/util/constants/color-constant.dart';

final kTextFieldDecoration = InputDecoration(
  labelStyle: const TextStyle(
    color: ColorConstant.primaryGreen,
  ),
// helperText: 'Field helper Name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: const BorderSide(
      color: Color(0xFFD1D5DB),
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: const BorderSide(
      color: ColorConstant.secondaryGreen,
      width: 2.0,
    ),
  ),
);

final kButtonDecoration = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(ColorConstant.secondaryGreen),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: const BorderSide(
          color: ColorConstant.primaryGreen,
        )),
  ),
);
