import 'package:flutter/material.dart';

class Dimension {
  Dimension._();
  static const dp00 = 0.0;
  static const dp007 = 0.07;
  static const dp01 = 0.1;
  static const dp02 = 0.2;
  static const dp03 = 0.3;
  static const dp035 = 0.35;
  static const dp04 = 0.4;
  static const dp045 = 0.45;
  static const dp05 = 0.5;
  static const dp06 = 0.6;
  static const dp07 = 0.7;
  static const dp08 = 0.8;
  static const dp086 = 0.86;
  static const dp1 = 1.0;
  static const dp1_5 = 1.5;
  static const dp2 = 2.0;
  static const dp4 = 4.0;
  static const dp5 = 5.0;
  static const dp7 = 7.0;
  static const dp8 = 8.0;
  static const dp10 = 10.0;
  static const dp12 = 12.0;
  static const dp15 = 15.0;
  static const dp20 = 20.0;
  static const dp25 = 25.0;
  static const dp27 = 27.0;
  static const dp28 = 28.0;
  static const dp30 = 30.0;
  static const dp34 = 34.0;
  static const dp35 = 35.0;
  static const dp40 = 40.0;
  static const dp50 = 50.0;
  static const dp54 = 54.0;
  static const dp60 = 60.0;
  static const dp68 = 68.0;
  static const dp80 = 80.0;
  static const dp100 = 100.0;
  static const dp150 = 150.0;
  static const dp300 = 300.0;
}

class Constant {
  Constant._();
  static const sislTj = "SISL & Techjockey";
}

class ImageAssets {
  ImageAssets._();
  static const background = "assets/images/background.png";
}

class FWeight {
  FWeight._();
  static const regular = FontWeight.normal;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.bold;
}

class FFamily {
  FFamily._();
  static const avenir = "Avenir";
}

class FSize {
  FSize._();
  static const dp10 = 10.0;
  static const dp12 = 12.0;
  static const dp14 = 14.0;
  static const dp16 = 16.0;
  static const dp18 = 18.0;
  static const dp20 = 20.0;
  static const dp24 = 24.0;
  static const dp30 = 30.0;
  static const dp40 = 40.0;
}

class ColorPalette {
  ColorPalette._();
  static const themeBlue = Color(0xFF1fa1bd);
  static const white = Color(0xFFFFFFFF);
  static const lightGrey = Color(0xFFf0f0f0);
  static const textGrey = Color(0xFF4a4a4a);
  static const grey = Color(0xFF9E9E9E);
  static const lightBlue = Color(0x337aeefc);
  static const lightRed = Color(0x33FF5252);
  static const chartPink = Color(0xFFff708f);
  static const chartYellow = Color(0xFFffdd87);
  static const chartBlue = Color(0xFF8ac4ff);
  static const chartOrange = Color(0xFFffb58c);
  static const blueTint = Color(0x331fa1bd);
  static const blueTint1 = Color(0xFF205072);
  static const labelGrey = Color(0xcc4a4a4a);
  static const bgGrey = Color(0x40000000);
  static const green = Color(0xFF4CAF50);
  static const lightGreen = Color(0x334CAF50);
  static const red = Color(0xFFF44336);
  static const lightThemeBlue = Color(0x331fa1bd);

}

class SWANWidget {
  SWANWidget._();

  static get splashBoldTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.white,
      fontSize: FSize.dp40,
      fontWeight: FWeight.bold);

  static get headerRegularTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.themeBlue,
      fontSize: FSize.dp20,
      fontWeight: FWeight.regular);
  static get textRegularTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.themeBlue,
      fontSize: FSize.dp18,
      fontWeight: FWeight.regular);
  static get subtextRegularTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.themeBlue,
      fontSize: FSize.dp16,
      fontWeight: FWeight.regular);

  static get headerBoldTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.themeBlue,
      fontSize: FSize.dp20,
      fontWeight: FWeight.bold);

  static get largeHeadings => const TextStyle(
        fontFamily: FFamily.avenir,
        color: ColorPalette.textGrey,
        fontSize: FSize.dp30,
        fontWeight: FWeight.semiBold,
      );

  static get extraSmallTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.themeBlue,
      fontSize: FSize.dp10,
      fontWeight: FWeight.regular);

  static get extraSmallBlackTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.textGrey,
      fontSize: FSize.dp10,
      fontWeight: FWeight.regular);

  static get fieldLabelTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.textGrey,
      fontSize: FSize.dp14,
      fontWeight: FWeight.regular);

  static get fieldValueTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.textGrey,
      fontSize: FSize.dp16,
      fontWeight: FWeight.regular);

  static get dropDownLabelTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.themeBlue,
      fontSize: FSize.dp12,
      fontWeight: FWeight.semiBold);

  static get disabledFieldLabelTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.grey,
      fontSize: FSize.dp16,
      fontWeight: FWeight.semiBold);

  static get disabledFieldValueTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.grey,
      fontSize: FSize.dp16,
      fontWeight: FWeight.regular);

  static get normalTextStyle => const TextStyle(
        fontFamily: FFamily.avenir,
        color: ColorPalette.textGrey,
        fontSize: FSize.dp14,
        fontWeight: FWeight.regular,
      );

  static get normalWhiteTextStyle => const TextStyle(
        fontFamily: FFamily.avenir,
        color: ColorPalette.white,
        fontSize: FSize.dp14,
        fontWeight: FWeight.regular,
      );

  static get buttonTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.white,
      fontSize: FSize.dp16,
      fontWeight: FWeight.semiBold);

  static get nameTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.white,
      fontSize: FSize.dp18,
      fontWeight: FWeight.semiBold);

  static get normalHeadingsTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.textGrey,
      fontSize: FSize.dp18,
      fontWeight: FWeight.semiBold);
  static get subnormalHeadingsTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.textGrey,
      fontSize: FSize.dp16,
      fontWeight: FWeight.semiBold);

  static get pieChartTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.textGrey,
      fontSize: FSize.dp16,
      fontWeight: FWeight.semiBold,
      decoration: TextDecoration.underline);

  static get subHeadingTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.textGrey,
      fontSize: FSize.dp16,
      fontWeight: FWeight.semiBold);
  static get minHeadingTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: Colors.lightBlueAccent,
      fontSize: FSize.dp14,
      fontWeight: FWeight.semiBold);

  static get tabSelectedTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.themeBlue,
      fontSize: FSize.dp14,
      fontWeight: FWeight.semiBold);

  static get tabUnSelectedTextStyle => const TextStyle(
      fontFamily: FFamily.avenir,
      color: ColorPalette.white,
      fontSize: FSize.dp14,
      fontWeight: FWeight.semiBold);

  static disableKeyboard() {
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
  }

  static Row pieChartLabels(color, text, width) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: Dimension.dp20,
              width: Dimension.dp20,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
          const SizedBox(
            width: Dimension.dp10,
          ),
          SizedBox(
            width: width * Dimension.dp03,
            child: Text(
              text,
              style: SWANWidget.pieChartTextStyle,
              softWrap: true,
            ),
          ),
        ],
      );

  static Row requestCardRows(width, label, value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * Dimension.dp035,
            child: Text(
              label,
              style: SWANWidget.subHeadingTextStyle,
              softWrap: true,
            ),
          ),
          Text(
            'hello',
            style: SWANWidget.subHeadingTextStyle,
            softWrap: true,
          ),
          SizedBox(
            width: width * Dimension.dp035,
            child: Text(
              value,
              style: SWANWidget.fieldValueTextStyle,
              softWrap: true,
            ),
          )
        ],
      );

  static TextFormField disabledTextFormField(_controller, label) =>
      TextFormField(
        controller: _controller,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(12),
            labelText: label,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.textGrey),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.textGrey),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.grey),
            ),
            labelStyle: SWANWidget.disabledFieldLabelTextStyle),
        enabled: false,
        keyboardType: TextInputType.number,
        style: SWANWidget.disabledFieldValueTextStyle,
        validator: (value) {
          if (value!.isEmpty) {
            return 'The field is mandatory';
          }
          return null;
        },
      );

  static TextFormField enabledTextFormField(_controller, label, inputType,
          inputFormatters, validator, maxLength) =>
      TextFormField(
        controller: _controller,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(12),
            labelText: label,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.themeBlue, width: 0.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.themeBlue, width: 0.5),
            ),
            /*enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.textGrey),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.textGrey),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.grey),
            ),*/
            labelStyle: SWANWidget.fieldLabelTextStyle,
            counterText: ""),
        onChanged: (value) {},
        //enabled: true,
        inputFormatters: inputFormatters,
        maxLines: null,
        keyboardType: inputType,
        style: SWANWidget.fieldValueTextStyle,
        maxLength: maxLength,
        validator: validator,
      );

  static TextFormField enabledTextFormField1(_controller, label, inputType,
          inputFormatters, validator, maxLength) =>
      TextFormField(
        controller: _controller,
        decoration: InputDecoration(
            labelText: label,
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: ColorPalette.themeBlue, width: 0.5),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: ColorPalette.themeBlue, width: 0.5),
            // ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.textGrey),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.textGrey),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.grey),
            ),
            labelStyle: SWANWidget.fieldLabelTextStyle,
            counterText: ""),
        //enabled: true,
        inputFormatters: inputFormatters,
        maxLines: null,
        keyboardType: inputType,
        style: SWANWidget.fieldValueTextStyle,
        maxLength: maxLength,
        validator: validator,
      );
}
