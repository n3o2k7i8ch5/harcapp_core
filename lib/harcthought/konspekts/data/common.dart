String urlToGitlabFile(String konspektName, String filename) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/konspekts/${konspektName}/${filename}";
String urlToPoradnikFile(String poradnikName, String filename) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/poradniki/${poradnikName}/${filename}";

String piramidaDuchowosciPartHtmlLight = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_part_light.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości part"/>';
String piramidaDuchowosciPartHtmlDark = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_part_dark.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości part"/>';

String piramidaDuchowosciPartHtml({required bool isDark}) => isDark?piramidaDuchowosciPartHtmlDark:piramidaDuchowosciPartHtmlLight;


String piramidaDuchowosciHtmlLight = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości"/>';
String piramidaDuchowosciHtmlDark = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_dark.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości"/>';

String piramidaDuchowosciHtml({required bool isDark}) => isDark?piramidaDuchowosciHtmlDark:piramidaDuchowosciHtmlLight;