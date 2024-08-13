import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

const String _konspekt_name = 'zycie_i_swiat_prl';

const String attach_html_wydarzenia_codzienne = '<a href="${attach_name_wydarzenia_codzienne}@attachment">${attach_title_wydarzenia_codzienne}</a>';
const String attach_name_wydarzenia_codzienne = "wydarzenia_codzienne";
const String attach_title_wydarzenia_codzienne = "Wydarzenia codzienne";
KonspektAttachment attach_wydarzenia_codzienne = KonspektAttachment(
  name: attach_name_wydarzenia_codzienne,
  title: attach_title_wydarzenia_codzienne,
  assets: {
    KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'wydarzenia_codzienne.pdf'),
    KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'wydarzenia_codzienne.docx')
  },
  print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.monochrome, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_wniosek_o_zalegendowanie_agenta = '<a href="${attach_name_wniosek_o_zalegendowanie_agenta}@attachment">${attach_title_wniosek_o_zalegendowanie_agenta}</a>';
const String attach_name_wniosek_o_zalegendowanie_agenta = "wniosek_o_zalegendowanie_agenta";
const String attach_title_wniosek_o_zalegendowanie_agenta = "Wniosek o zalegendowanie agenta";
KonspektAttachment attach_wniosek_o_zalegendowanie_agenta = KonspektAttachment(
    name: attach_name_wniosek_o_zalegendowanie_agenta,
    title: attach_title_wniosek_o_zalegendowanie_agenta,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'wniosek_o_zalegendowanie_agenta.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'wniosek_o_zalegendowanie_agenta.docx')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.monochrome, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_raporty_obserwacji_obywatelskich = '<a href="${attach_name_raporty_obserwacji_obywatelskich}@attachment">${attach_title_raporty_obserwacji_obywatelskich}</a>';
const String attach_name_raporty_obserwacji_obywatelskich = "raporty_obserwacji_obywatelskich";
const String attach_title_raporty_obserwacji_obywatelskich = "Raporty obserwacji obywatelskich";
KonspektAttachment attach_raporty_obserwacji_obywatelskich = KonspektAttachment(
    name: attach_name_raporty_obserwacji_obywatelskich,
    title: attach_title_raporty_obserwacji_obywatelskich,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'raporty_obserwacji_obywatelskich.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'raporty_obserwacji_obywatelskich.docx')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.monochrome, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_raporty_realiow_zycia = '<a href="${attach_name_raporty_realiow_zycia}@attachment">${attach_title_karty_wiedzy}</a>';
const String attach_name_raporty_realiow_zycia = "raporty_realiow_zycia";
const String attach_title_raporty_realiow_zycia = "Raporty realiów życia";
KonspektAttachment attach_raporty_realiow_zycia = KonspektAttachment(
    name: attach_name_raporty_realiow_zycia,
    title: attach_title_raporty_realiow_zycia,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'raporty_realiow_zycia.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'raporty_realiow_zycia.docx')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.monochrome, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_wydarzenia_specjalne = '<a href="${attach_name_wydarzenia_specjalne}@attachment">${attach_title_wydarzenia_specjalne}</a>';
const String attach_name_wydarzenia_specjalne = "wydarzenia_specjalne";
const String attach_title_wydarzenia_specjalne = "Wydarzenia specjalne";
KonspektAttachment attach_wydarzenia_specjalne = KonspektAttachment(
    name: attach_name_wydarzenia_specjalne,
    title: attach_title_wydarzenia_specjalne,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'wydarzenia_specjalne.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'wydarzenia_specjalne.docx')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.monochrome, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_sciaga_dla_uczestnikow = '<a href="${attach_name_sciaga_dla_uczestnikow}@attachment">${attach_title_sciaga_dla_uczestnikow}</a>';
const String attach_name_sciaga_dla_uczestnikow = "sciaga_dla_uczestnikow";
const String attach_title_sciaga_dla_uczestnikow = "Ściąga dla uczestników";
KonspektAttachment attach_sciaga_dla_uczestnikow = KonspektAttachment(
    name: attach_name_sciaga_dla_uczestnikow,
    title: attach_title_sciaga_dla_uczestnikow,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'sciaga_dla_uczestnikow.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'sciaga_dla_uczestnikow.docx')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.monochrome, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_znaczniki_statystyk_wojewodztw = '<a href="${attach_name_znaczniki_statystyk_wojewodztw}@attachment">${attach_title_znaczniki_statystyk_wojewodztw}</a>';
const String attach_name_znaczniki_statystyk_wojewodztw = "znaczniki_statystyk_wojewodztw";
const String attach_title_znaczniki_statystyk_wojewodztw = "Znaczniki statystyk województw";
KonspektAttachment attach_znaczniki_statystyk_wojewodztw = KonspektAttachment(
    name: attach_name_znaczniki_statystyk_wojewodztw,
    title: attach_title_znaczniki_statystyk_wojewodztw,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'znaczniki_statystyk_wojewodztw.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'znaczniki_statystyk_wojewodztw.docx')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.monochrome, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_karty_wiedzy = '<a href="${attach_name_karty_wiedzy}@attachment">${attach_title_karty_wiedzy}</a>';
const String attach_name_karty_wiedzy = "karty_wiedzy";
const String attach_title_karty_wiedzy = "Karty wiedzy";
KonspektAttachment attach_karty_wiedzy = KonspektAttachment(
    name: attach_name_karty_wiedzy,
    title: attach_title_karty_wiedzy,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'karty_wiedzy.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'karty_wiedzy.docx')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.monochrome, side: KonspektAttachmentPrintSide.single)
);

Konspekt zycie_i_swiat_prl = Konspekt(
    name: _konspekt_name,
    title: 'Życie i świat PRL',
    category: KonspektCategory.harcerskie,
    type: KonspektType.wspolzawoGrupowe,
    spheres: {
      KonspektSphere.umysl: null,
    },
    metos: [Meto.hs, Meto.wedro],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    customDuration: Duration(days: 20),
    aims: [
      'Poznanie przez uczestników realiów życia codziennego w PRL',
      'Poznanie przez uczestników historii i najważniejszych wydarzeń w PRL',
      'Rozwinięcie umiejętności myślenia strategicznego u uczestników'
    ],
    materials: [
      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_wydarzenia_codzienne"',
        attachmentName: attach_name_wydarzenia_codzienne
      )
    ],
    description: '',
    attachments: [
      attach_wydarzenia_codzienne,
      attach_wniosek_o_zalegendowanie_agenta,
      attach_raporty_obserwacji_obywatelskich,
      attach_raporty_realiow_zycia,
      attach_wydarzenia_specjalne,
      attach_sciaga_dla_uczestnikow,
      attach_znaczniki_statystyk_wojewodztw,
      attach_karty_wiedzy,
    ]
);
