String urlFilePath(String konspektName, String filename) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/-/raw/master/konspekts/${konspektName}/${filename}";

String piramidaDuchowosciHtmlLight = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości"/>';
String piramidaDuchowosciHtmlDark = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_dark.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości"/>';

String piramidaDuchowosciHtml({required bool isDark}) => isDark?piramidaDuchowosciHtmlDark:piramidaDuchowosciHtmlLight;