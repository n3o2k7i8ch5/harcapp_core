const String _assetPath = 'asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe';
const String _imgStyle = 'object-fit: contain; width: 100%; height: auto;';

String piramidaDuchowosci7_9HtmlLight = '<img src="$_assetPath/piramida_duchowosci_7-9_light.svg" style="$_imgStyle" alt="Piramida duchowości 7-9 lat"/>';
String piramidaDuchowosci7_9HtmlDark = '<img src="$_assetPath/piramida_duchowosci_7-9_dark.svg" style="$_imgStyle" alt="Piramida duchowości 7-9 lat"/>';
String piramidaDuchowosci7_9Html({required bool isDark}) => isDark ? piramidaDuchowosci7_9HtmlDark : piramidaDuchowosci7_9HtmlLight;

String piramidaDuchowosci10_12HtmlLight = '<img src="$_assetPath/piramida_duchowosci_10-12_light.svg" style="$_imgStyle" alt="Piramida duchowości 10-12 lat"/>';
String piramidaDuchowosci10_12HtmlDark = '<img src="$_assetPath/piramida_duchowosci_10-12_dark.svg" style="$_imgStyle" alt="Piramida duchowości 10-12 lat"/>';
String piramidaDuchowosci10_12Html({required bool isDark}) => isDark ? piramidaDuchowosci10_12HtmlDark : piramidaDuchowosci10_12HtmlLight;

String piramidaDuchowosci13_15HtmlLight = '<img src="$_assetPath/piramida_duchowosci_13-15_light.svg" style="$_imgStyle" alt="Piramida duchowości 13-15 lat"/>';
String piramidaDuchowosci13_15HtmlDark = '<img src="$_assetPath/piramida_duchowosci_13-15_dark.svg" style="$_imgStyle" alt="Piramida duchowości 13-15 lat"/>';
String piramidaDuchowosci13_15Html({required bool isDark}) => isDark ? piramidaDuchowosci13_15HtmlDark : piramidaDuchowosci13_15HtmlLight;

String piramidaDuchowosci16HtmlLight = '<img src="$_assetPath/piramida_duchowosci_16_light.svg" style="$_imgStyle" alt="Piramida duchowości 16+ lat"/>';
String piramidaDuchowosci16HtmlDark = '<img src="$_assetPath/piramida_duchowosci_16_dark.svg" style="$_imgStyle" alt="Piramida duchowości 16+ lat"/>';
String piramidaDuchowosci16Html({required bool isDark}) => isDark ? piramidaDuchowosci16HtmlDark : piramidaDuchowosci16HtmlLight;
