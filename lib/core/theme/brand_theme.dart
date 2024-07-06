import 'package:flutter/material.dart';

class BrandTheme extends ThemeExtension<BrandTheme> {
  const BrandTheme({
    this.brandColor,
  });

  final Color? brandColor;

  @override
  BrandTheme copyWith({
    Color? brandColor,
  }) =>
      BrandTheme(
        brandColor: brandColor ?? this.brandColor,
      );

  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) {
      return this;
    }
    return BrandTheme(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
    );
  }
}

const BrandTheme lightBrandTheme = BrandTheme(
  brandColor: Color.fromARGB(255, 8, 79, 71),
);

const BrandTheme darkBrandTheme = BrandTheme(
  brandColor: Color.fromARGB(255, 167, 227, 218),
);
