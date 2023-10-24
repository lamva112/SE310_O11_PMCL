/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAnimationGen {
  const $AssetsAnimationGen();

  /// File path: assets/animation/background.flr
  String get background => 'assets/animation/background.flr';

  /// List of all assets
  List<String> get values => [background];
}

class $AssetsCfgGen {
  const $AssetsCfgGen();

  /// File path: assets/cfg/app_config_dev.json
  String get appConfigDev => 'assets/cfg/app_config_dev.json';

  /// File path: assets/cfg/app_config_prod.json
  String get appConfigProd => 'assets/cfg/app_config_prod.json';

  /// File path: assets/cfg/app_config_staging.json
  String get appConfigStaging => 'assets/cfg/app_config_staging.json';

  /// List of all assets
  List<String> get values => [appConfigDev, appConfigProd, appConfigStaging];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesJsonGen get json => const $AssetsImagesJsonGen();
  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();
  $AssetsImagesSvgGen get svg => const $AssetsImagesSvgGen();
}

class $AssetsImagesJsonGen {
  const $AssetsImagesJsonGen();

  /// File path: assets/images/json/logo.json
  String get logo => 'assets/images/json/logo.json';

  /// List of all assets
  List<String> get values => [logo];
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/ic_chevron_up.png
  AssetGenImage get icChevronUp =>
      const AssetGenImage('assets/images/png/ic_chevron_up.png');

  /// List of all assets
  List<AssetGenImage> get values => [icChevronUp];
}

class $AssetsImagesSvgGen {
  const $AssetsImagesSvgGen();

  /// File path: assets/images/svg/ic_chevron_down.svg
  String get icChevronDown => 'assets/images/svg/ic_chevron_down.svg';

  /// List of all assets
  List<String> get values => [icChevronDown];
}

class Assets {
  Assets._();

  static const $AssetsAnimationGen animation = $AssetsAnimationGen();
  static const $AssetsCfgGen cfg = $AssetsCfgGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
