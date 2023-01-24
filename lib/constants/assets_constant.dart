/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  $LibImagesGen get images => const $LibImagesGen();
}

class $LibImagesGen {
  const $LibImagesGen();

  /// File path: assets/images/add.png
  AssetGenImage get addIcon =>
      const AssetGenImage('assets/images/add.png');

  /// File path: assets/images/edit.png
  AssetGenImage get editIcon =>
      const AssetGenImage('assets/images/edit.png');

  /// File path: assets/images/ic_calander.png
  AssetGenImage get calanderIcon =>
      const AssetGenImage('assets/images/ic_calander.png');

  /// File path: assets/images/ic_clock.png
  AssetGenImage get clockIcon => const AssetGenImage('assets/images/ic_clock.png');

  /// File path: assets/images/ic_forward.png
  AssetGenImage get forwardIcon =>
      const AssetGenImage('assets/images/ic_forward.png');

  /// File path: assets/images/ic_history_select.png
  AssetGenImage get historySelectIcon =>
      const AssetGenImage('assets/images/ic_history_select.png');

  /// File path: assets/images/ic_history_unselect.png
  AssetGenImage get historyUnSelectIcon =>
      const AssetGenImage('assets/images/ic_history_unselect.png');

  /// File path: assets/images/ic_home_select.png
  AssetGenImage get homeSelectIcon =>
      const AssetGenImage('assets/images/ic_home_select.png');

  /// File path: assets/images/ic_home_unselect.png
  AssetGenImage get homeUnSelectIcon =>
      const AssetGenImage('assets/images/ic_home_unselect.png');

  /// File path: assets/images/ic_laungauge.png
  AssetGenImage get laungaugeIcon => const AssetGenImage('assets/images/ic_laungauge.png');

  /// File path: assets/images/ic_menu.png
  AssetGenImage get menuIcon => const AssetGenImage('assets/images/ic_menu.png');

  /// File path: assets/images/ic_notification.png
  AssetGenImage get notificationIcon =>
      const AssetGenImage('assets/images/ic_notification.png');

  /// File path: assets/images/ic_setting_select.png
  AssetGenImage get settingSelectIcon =>
      const AssetGenImage('assets/images/ic_setting_select.png');

  /// File path: assets/images/ic_setting_unselect.png
  AssetGenImage get settingUnSelectIcon =>
      const AssetGenImage('assets/images/ic_setting_unselect.png');

  /// File path: assets/images/ic_theme.png
  AssetGenImage get themeIcon =>
      const AssetGenImage('assets/images/ic_theme.png');

  /// File path: assets/images/move.png
  AssetGenImage get moveIcon =>
      const AssetGenImage('assets/images/move.png');
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class Assets {
  Assets._();

  static const $LibGen lib = $LibGen();
}
