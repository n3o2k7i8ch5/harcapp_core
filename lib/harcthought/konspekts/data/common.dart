String piramidaDuchowosciHtmlLight = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.svg" />';
String piramidaDuchowosciHtmlDark = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_dark.svg" />';

String piramidaDuchowosciHtml({required bool isDark}) => isDark?piramidaDuchowosciHtmlDark:piramidaDuchowosciHtmlLight;