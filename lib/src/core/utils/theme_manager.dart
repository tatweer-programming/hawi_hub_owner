import 'package:flutter/material.dart';

import 'color_manager.dart';

ThemeData getAppTheme() {
  return customTheme;
}

final ThemeData customTheme = ThemeData(
  scaffoldBackgroundColor: ColorManager.white,
  useMaterial3: false,
  applyElevationOverlayColor: false,
  brightness: Brightness.light,
  canvasColor: const Color(0xFFFFFBFE),
  cardColor: const Color(0xFFFFFBFE),
  dialogBackgroundColor: const Color(0xFFFFFBFE),
  disabledColor: const Color(0x61000000),
  dividerColor: const Color(0xFF79747E),
  buttonTheme: const ButtonThemeData(
    alignedDropdown: false,
    height: 36,
    layoutBehavior: ButtonBarLayoutBehavior.padded,
    minWidth: 88,
    padding: EdgeInsets.only(bottom: 0, left: 16, right: 16, top: 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.elliptical(2, 2),
        bottomRight: Radius.elliptical(2, 2),
        topLeft: Radius.elliptical(2, 2),
        topRight: Radius.elliptical(2, 2),
      ),
      side: BorderSide(color: Color(0xFF000000), width: 0),
    ),
    textTheme: ButtonTextTheme.normal,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color(0x1F000000);
        } else if (states.contains(MaterialState.dragged) ||
            states.contains(MaterialState.error) ||
            states.contains(MaterialState.focused) ||
            states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.pressed) ||
            states.contains(MaterialState.scrolledUnder) ||
            states.contains(MaterialState.selected)) {
          return const Color(0xFF00DB55);
        }
        return null;
      }),
      elevation: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return 0;
        } else if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.hovered)) {
          return 4;
        } else if (states.contains(MaterialState.pressed)) {
          return 8;
        }
        return 1;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color(0x61000000);
        } else {
          return const Color(0xFFFFFFFF);
        }
      }),
      minimumSize: MaterialStateProperty.resolveWith((states) {
        return const Size(64, 36);
      }),
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return const Color(0x3D000000);
        } else if (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.pressed)) {
          return const Color(0x14000000);
        }
        return null;
      }),
      shadowColor: MaterialStateProperty.resolveWith((states) {
        return const Color(0xFF000000);
      }),
      shape: MaterialStateProperty.resolveWith((states) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(26, 26),
            bottomRight: Radius.elliptical(26, 26),
            topLeft: Radius.elliptical(26, 26),
            topRight: Radius.elliptical(26, 26),
          ),
          side: BorderSide(color: Color(0xFF000000), width: 0),
        );
      }),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Color(0xFFFFFFFF),
  ),
  focusColor: const Color(0x1F000000),
  highlightColor: const Color(0xff66bcbcbc),
  hintColor: const Color(0x99000000),
  hoverColor: const Color(0x0A000000),
  indicatorColor: const Color(0xffff00db55),
  inputDecorationTheme: const InputDecorationTheme(
    alignLabelWithHint: false,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.elliptical(22, 22),
        bottomRight: Radius.elliptical(22, 22),
        topLeft: Radius.elliptical(22, 22),
        topRight: Radius.elliptical(22, 22),
      ),
      borderSide: BorderSide(color: Color(0xFF000000), width: 1),
      gapPadding: 4,
    ),
    filled: false,
    floatingLabelAlignment: FloatingLabelAlignment.center,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    isCollapsed: false,
    isDense: false,
  ),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  outlinedButtonTheme: const OutlinedButtonThemeData(
    style: ButtonStyle(
        // outlined button style here
        ),
  ),

  /// text themes
  primaryColor: const Color(0xff00db55),
  primaryColorDark: const Color(0xff247945),
  primaryColorLight: const Color(0xff66e999),
  primaryIconTheme: const IconThemeData(
    color: Color(0xff000000),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Color(0xDD000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      textBaseline: TextBaseline.alphabetic,
    ),
    bodyMedium: TextStyle(
      color: Color(0xff0424242),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1,
      letterSpacing: 0.2,
      textBaseline: TextBaseline.alphabetic,
    ),
    bodySmall: TextStyle(
      color: Color(0x8A000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      textBaseline: TextBaseline.alphabetic,
    ),
    displayLarge: TextStyle(
      color: Color(0x8A000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_300',
      fontFamilyFallback: ['Roboto'],
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      textBaseline: TextBaseline.alphabetic,
    ),
    displayMedium: TextStyle(
      color: Color(0x8A000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_300',
      fontFamilyFallback: ['Roboto'],
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      textBaseline: TextBaseline.alphabetic,
    ),
    displaySmall: TextStyle(
      color: Color(0x8A000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 48,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      textBaseline: TextBaseline.alphabetic,
    ),
    headlineLarge: TextStyle(
      color: Color(0x8A000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 40,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      textBaseline: TextBaseline.alphabetic,
    ),
    headlineMedium: TextStyle(
      color: Color(0x8A000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      textBaseline: TextBaseline.alphabetic,
    ),
    headlineSmall: TextStyle(
      color: Color(0xDD000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      textBaseline: TextBaseline.alphabetic,
    ),
    labelLarge: TextStyle(
      color: Color(0xDD000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_500',
      fontFamilyFallback: ['Roboto'],
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      textBaseline: TextBaseline.alphabetic,
    ),
    labelMedium: TextStyle(
      color: Color(0xFF000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 11,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      textBaseline: TextBaseline.alphabetic,
    ),
    labelSmall: TextStyle(
      color: Color(0xFF000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      textBaseline: TextBaseline.alphabetic,
    ),
    titleLarge: TextStyle(
      color: Color(0xDD000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_700',
      fontFamilyFallback: ['Roboto'],
      fontSize: 25,
      fontWeight: FontWeight.w700,
      height: 1,
      leadingDistribution: TextLeadingDistribution.proportional,
      letterSpacing: 0.15,
      textBaseline: TextBaseline.alphabetic,
    ),
    titleMedium: TextStyle(
      color: Color(0xDD000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 18,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      leadingDistribution: TextLeadingDistribution.proportional,
      letterSpacing: 0.15,
      textBaseline: TextBaseline.alphabetic,
    ),
    titleSmall: TextStyle(
      color: Color(0xFF000000),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto_500',
      fontFamilyFallback: ['Roboto'],
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      textBaseline: TextBaseline.alphabetic,
    ),
  ), colorScheme: const ColorScheme(
    background: Color(0xffff4de688),
    brightness: Brightness.light,
    error: Color(0xFFB00020),
    errorContainer: Color(0xFFB00020),
    inversePrimary: Color(0xFFFFFFFF),
    inverseSurface: Color(0xFF000000),
    onBackground: Color(0xFF000000),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFFFFFFFF),
    onInverseSurface: Color(0xFFFFFFFF),
    onPrimary: Color(0xFF000000),
    onPrimaryContainer: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    onSecondaryContainer: Color(0xFF000000),
    onSurface: Color(0xFF000000),
    onSurfaceVariant: Color(0xFF000000),
    onTertiary: Color(0xFF000000),
    onTertiaryContainer: Color(0xFF000000),
    outline: Color(0xFF000000),
    outlineVariant: Color(0xFF000000),
    primary: Color(0xFF00DB55),
    primaryContainer: Color(0xFF6200EE),
    scrim: Color(0xFF000000),
    secondary: Color(0xFF00DB55),
    secondaryContainer: Color(0xFF03DAC6),
    shadow: Color(0xFF000000),
    surface: Color(0xFFFFFFFF),
    surfaceTint: Color(0xFF6200EE),
    surfaceVariant: Color(0xFFFFFFFF),
    tertiary: Color(0xFF03DAC6),
    tertiaryContainer: Color(0xFF03DAC6),
  ).copyWith(error: ColorManager.error),
);
