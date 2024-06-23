String piramidaDuchowosciHtmlLight = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.svg" style="width: 100%; height: auto;" alt="Piramida duchowości"/>';
String piramidaDuchowosciHtmlDark = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_dark.svg" style="width: 100%; height: auto;" alt="Piramida duchowości"/>';

String piramidaDuchowosciHtml({required bool isDark}) => isDark?piramidaDuchowosciHtmlDark:piramidaDuchowosciHtmlLight;