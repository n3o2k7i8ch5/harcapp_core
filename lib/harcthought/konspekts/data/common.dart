String urlToGitlabFile(String konspektName, String filename) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/konspekts/${konspektName}/${filename}";
String urlToPoradnikFile(String poradnikName, String filename) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/poradniki/${poradnikName}/${filename}";

String piramidaDuchowosci1HtmlLight = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_1_light.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości part"/>';
String piramidaDuchowosci1HtmlDark = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_1_dark.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości part"/>';

String piramidaDuchowosci1Html({required bool isDark}) => isDark?piramidaDuchowosci1HtmlDark:piramidaDuchowosci1HtmlLight;


String piramidaDuchowosci2HtmlLight = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_2_light.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości"/>';
String piramidaDuchowosci2HtmlDark = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_2_dark.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości"/>';

String piramidaDuchowosci2Html({required bool isDark}) => isDark?piramidaDuchowosci2HtmlDark:piramidaDuchowosci2HtmlLight;


String piramidaDuchowosci3HtmlLight = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_3_light.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości"/>';
String piramidaDuchowosci3HtmlDark = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_3_dark.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Piramida duchowości"/>';

String piramidaDuchowosci3Html({required bool isDark}) => isDark?piramidaDuchowosci3HtmlDark:piramidaDuchowosci3HtmlLight;

String cyklIntegracjiDuchowosciHtmlLight = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/cykl_integracji_duchowosci_light.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Cykl integracji duchowości"/>';
String cyklIntegracjiDuchowosciHtmlDark = '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/cykl_integracji_duchowosci_dark.svg" style="object-fit: contain; width: 100%; height: auto;" alt="Cykl integracji duchowości"/>';

String cyklIntegracjiDuchowosciHtml({required bool isDark}) => isDark?cyklIntegracjiDuchowosciHtmlDark:cyklIntegracjiDuchowosciHtmlLight;