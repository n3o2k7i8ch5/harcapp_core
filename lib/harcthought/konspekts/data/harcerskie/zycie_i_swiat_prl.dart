import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

const String _konspekt_name = 'zycie_i_swiat_prl';

const String attach_html_mapa_glowna = '<a href="${attach_name_mapa_glowna}@attachment">${attach_title_mapa_glowna}</a>';
const String attach_name_mapa_glowna = "mapa_glowna";
const String attach_title_mapa_glowna = "Mapa główna";
KonspektAttachment attach_mapa_glowna = KonspektAttachment(
    name: attach_name_mapa_glowna,
    title: attach_title_mapa_glowna,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'mapa_prl.pdf'),
      KonspektAttachmentFormat.urlPng: urlFilePath(_konspekt_name, 'mapa_prl.png'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'mapa_prl.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.double)
);

// --- Banknoty

const String attach_html_banknot_csk_1 = '<a href="${attach_name_banknot_csk_1}@attachment">${attach_title_banknot_csk_1}</a>';
const String attach_name_banknot_csk_1 = "banknot_csk_1";
const String attach_title_banknot_csk_1 = "Banknot 1 CSK";
KonspektAttachment attach_banknot_csk_1 = KonspektAttachment(
    name: attach_name_banknot_csk_1,
    title: attach_title_banknot_csk_1,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'banknot_csk_1.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'banknot_csk_1.docx'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'banknot_csk_1.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.double)
);

const String attach_html_banknot_ddm_1 = '<a href="${attach_name_banknot_ddm_1}@attachment">${attach_title_banknot_ddm_1}</a>';
const String attach_name_banknot_ddm_1 = "banknot_ddm_1";
const String attach_title_banknot_ddm_1 = "Banknot 1 DDM";
KonspektAttachment attach_banknot_ddm_1 = KonspektAttachment(
    name: attach_name_banknot_ddm_1,
    title: attach_title_banknot_ddm_1,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'banknot_ddm_1.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'banknot_ddm_1.docx'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'banknot_ddm_1.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.double)
);

const String attach_html_banknot_sur_1 = '<a href="${attach_name_banknot_sur_1}@attachment">${attach_title_banknot_sur_1}</a>';
const String attach_name_banknot_sur_1 = "banknot_sur_1";
const String attach_title_banknot_sur_1 = "Banknot 1 SUR";
KonspektAttachment attach_banknot_sur_1 = KonspektAttachment(
    name: attach_name_banknot_sur_1,
    title: attach_title_banknot_sur_1,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'banknot_sur_1.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'banknot_sur_1.docx'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'banknot_sur_1.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.double)
);

const String attach_html_banknot_usd_1 = '<a href="${attach_name_banknot_usd_1}@attachment">${attach_title_banknot_usd_1}</a>';
const String attach_name_banknot_usd_1 = "banknot_usd_1";
const String attach_title_banknot_usd_1 = "Banknot 1 USD";
KonspektAttachment attach_banknot_usd_1 = KonspektAttachment(
    name: attach_name_banknot_usd_1,
    title: attach_title_banknot_usd_1,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'banknot_usd_1.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'banknot_usd_1.docx'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'banknot_usd_1.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.double)
);

const String attach_html_banknot_plz_1_mln = '<a href="${attach_name_banknot_plz_1_mln}@attachment">${attach_title_banknot_plz_1_mln}</a>';
const String attach_name_banknot_plz_1_mln = "banknot_plz_1_mln";
const String attach_title_banknot_plz_1_mln = "Banknot 1 mln PLZ";
KonspektAttachment attach_banknot_plz_1_mln = KonspektAttachment(
    name: attach_name_banknot_plz_1_mln,
    title: attach_title_banknot_plz_1_mln,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'banknot_plz_1_mln.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'banknot_plz_1_mln.docx'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'banknot_plz_1_mln.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.double)
);

const String attach_html_banknot_plz_2_mln = '<a href="${attach_name_banknot_plz_2_mln}@attachment">${attach_title_banknot_plz_2_mln}</a>';
const String attach_name_banknot_plz_2_mln = "banknot_plz_2_mln";
const String attach_title_banknot_plz_2_mln = "Banknot 2 mln PLZ";
KonspektAttachment attach_banknot_plz_2_mln = KonspektAttachment(
    name: attach_name_banknot_plz_2_mln,
    title: attach_title_banknot_plz_2_mln,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'banknot_plz_2_mln.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'banknot_plz_2_mln.docx'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'banknot_plz_2_mln.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.double)
);

const String attach_html_banknot_plz_5_mln = '<a href="${attach_name_banknot_plz_5_mln}@attachment">${attach_title_banknot_plz_5_mln}</a>';
const String attach_name_banknot_plz_5_mln = "banknot_plz_5_mln";
const String attach_title_banknot_plz_5_mln = "Banknot 5 mln PLZ";
KonspektAttachment attach_banknot_plz_5_mln = KonspektAttachment(
    name: attach_name_banknot_plz_5_mln,
    title: attach_title_banknot_plz_5_mln,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'banknot_plz_5_mln.pdf'),
      KonspektAttachmentFormat.urlDocx: urlFilePath(_konspekt_name, 'banknot_plz_5_mln.docx'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'banknot_plz_5_mln.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.double)
);

// ---

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

// ---

const String attach_html_sekretarz_bierut = '<a href="${attach_name_sekretarz_bierut}@attachment">${attach_title_sekretarz_bierut}</a>';
const String attach_name_sekretarz_bierut = "sekretarz_bierut";
const String attach_title_sekretarz_bierut = "Sekretarz Bierut";
KonspektAttachment attach_sekretarz_bierut = KonspektAttachment(
    name: attach_name_sekretarz_bierut,
    title: attach_title_sekretarz_bierut,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'sekretarz_bierut.pdf'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'sekretarz_bierut.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_sekretarz_gomulka = '<a href="${attach_name_sekretarz_gomulka}@attachment">${attach_title_sekretarz_gomulka}</a>';
const String attach_name_sekretarz_gomulka = "sekretarz_gomulka";
const String attach_title_sekretarz_gomulka = "Sekretarz Gomułka";
KonspektAttachment attach_sekretarz_gomulka = KonspektAttachment(
    name: attach_name_sekretarz_gomulka,
    title: attach_title_sekretarz_gomulka,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'sekretarz_gomulka.pdf'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'sekretarz_gomulka.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_sekretarz_gierek = '<a href="${attach_name_sekretarz_gierek}@attachment">${attach_title_sekretarz_gierek}</a>';
const String attach_name_sekretarz_gierek = "sekretarz_gierek";
const String attach_title_sekretarz_gierek = "Sekretarz Gierek";
KonspektAttachment attach_sekretarz_gierek = KonspektAttachment(
    name: attach_name_sekretarz_gierek,
    title: attach_title_sekretarz_gierek,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'sekretarz_gierek.pdf'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'sekretarz_gierek.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_sekretarz_jaruzelski = '<a href="${attach_name_sekretarz_jaruzelski}@attachment">${attach_title_sekretarz_jaruzelski}</a>';
const String attach_name_sekretarz_jaruzelski = "sekretarz_jaruzelski";
const String attach_title_sekretarz_jaruzelski = "Sekretarz Jaruzelski";
KonspektAttachment attach_sekretarz_jaruzelski = KonspektAttachment(
    name: attach_name_sekretarz_jaruzelski,
    title: attach_title_sekretarz_jaruzelski,
    assets: {
      KonspektAttachmentFormat.urlPdf: urlFilePath(_konspekt_name, 'sekretarz_jaruzelski.pdf'),
      KonspektAttachmentFormat.urlWebp: urlFilePath(_konspekt_name, 'sekretarz_jaruzelski.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.single)
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
        name: 'Białe prześcieradło',
        amount: 1,
        comment: "Prześcieradło służy temu, by narysować na nim mapę (111cm x 85cm). "
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_mapa_glowna"',
          attachmentName: attach_name_mapa_glowna,
          amount: 1,
          comment: "Załącznik stworzony przy użyciu strony rasterbator.net",
          additionalPreparation: "Wydrukowane kartki z załącznika pdf służą temu, by w łatwy sposób nanieść kontury mapę (111cm x 85cm) na prześcieradło.",
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_banknot_csk_1"',
        attachmentName: attach_name_banknot_csk_1,
        amount: 3,
        additionalPreparation: "Każdy banknot należy wyciąć."
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_banknot_ddm_1"',
          attachmentName: attach_name_banknot_ddm_1,
          amount: 3,
          additionalPreparation: "Każdy banknot należy wyciąć."
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_banknot_sur_1"',
          attachmentName: attach_name_banknot_sur_1,
          amount: 3,
          additionalPreparation: "Każdy banknot należy wyciąć."
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_banknot_usd_1"',
          attachmentName: attach_name_banknot_usd_1,
          amount: 3,
          additionalPreparation: "Każdy banknot należy wyciąć."
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_banknot_plz_1_mln"',
          attachmentName: attach_name_banknot_plz_1_mln,
          amount: 3,
          additionalPreparation: "Każdy banknot należy wyciąć."
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_banknot_plz_2_mln"',
          attachmentName: attach_name_banknot_plz_2_mln,
          amount: 3,
          additionalPreparation: "Każdy banknot należy wyciąć."
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_banknot_plz_5_mln"',
          attachmentName: attach_name_banknot_plz_5_mln,
          amount: 3,
          additionalPreparation: "Każdy banknot należy wyciąć."
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_wydarzenia_codzienne"',
        attachmentName: attach_name_wydarzenia_codzienne
      ),
      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_raporty_obserwacji_obywatelskich"',
        attachmentName: attach_name_raporty_obserwacji_obywatelskich,
        amount: 1
      ),
      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_raporty_realiow_zycia"',
        attachmentName: attach_name_raporty_realiow_zycia,
        amount: 1
      ),
      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_wniosek_o_zalegendowanie_agenta"',
        attachmentName: attach_name_wniosek_o_zalegendowanie_agenta,
        amount: 1
      ),
      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_wydarzenia_specjalne"',
        attachmentName: attach_name_wydarzenia_specjalne,
        additionalPreparation: 'Karty należy wyciąć wzdłuż przerywanych linii i potasować.',
        amount: 16
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_sciaga_dla_uczestnikow"',
          attachmentName: attach_name_sciaga_dla_uczestnikow,
          amount: 1
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_znaczniki_statystyk_wojewodztw"',
          attachmentName: attach_name_znaczniki_statystyk_wojewodztw,
          amount: 1,
          additionalPreparation: 'Paski z liczbami oraz kartoniki należy wyciąć wzdłuż przerywanych linii. Kartoniki należy następnie dodatkowo naciąć wzdłuż czterech przerywanych linii. Na koniec do każdego kartonika należy wsunąć po dwa paski tak, by powstały dwa "suwaki" do łatwej zamiany wartości liczbowej',
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_karty_wiedzy"',
          attachmentName: attach_name_karty_wiedzy,
          additionalPreparation: 'Karty należy wyciąć wzdłuż przerywanych linii, podzielić na trzy grupy według poziomów i każdą grupę potasować.',
          amount: 16
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_sekretarz_bierut"',
          attachmentName: attach_name_sekretarz_bierut,
          amount: 1
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_sekretarz_gomulka"',
          attachmentName: attach_name_sekretarz_gomulka,
          amount: 1
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_sekretarz_gierek"',
          attachmentName: attach_name_sekretarz_gomulka,
          amount: 1
      ),
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_sekretarz_jaruzelski"',
          attachmentName: attach_name_sekretarz_jaruzelski,
          amount: 1
      ),

    ],
    intro: '<p style="text-align:justify;">'
        'Skończyła się II wojna światowa. Polska jest niemal doszczętnie zniszczona po okupacji niemieckiej i po przejściu radzieckiego frontu. Po podpisaniu pokoju w Jałcie nasz kraj znalazł się w sowieckiej strefie wpływów i w Warszawie zostali zainstalowani komuniści.'
        '<br>'
        '<br>Uczestnicy łączą się w grupy nazywane <b>stronnictwami</b> - są grupami niepodległościowymi z dawnej II Rzeczpospolitej, które zeszły do konspiracji z powodu przytłaczającej przewagi Sowietów. Stronnictwa rozpoczynają długi proces mający na celu wypracować najlepszą metodę obalenia komunizmu i zdobycia potrzebnych do tego środków: wiedzy, materiałów, pieniędzy, rozpoznania nastrojów społecznych, dostępu do agentów wpływu, którzy będą z nimi współpracowali itd..'
        '<br>'
        '<br>Każde ze stronnictw chce zdobyć możliwie najwięcej wpływu. Nie ufają żadnym postronnym organizacjom: wielokrotnie już okazywało się, że choć szły ze słusznymi postulatami na ustach, były dogłębnie zinfiltrowane przez obce mocarstwa. W tym celu stronnictwa muszą zgromadzić jak najwięcej wpływu, reprezentowanego przez <b>punkty wpływu</b>. Rozgrywkę wygrywa stronnictwo, które na końcu gry uzyska najwięcej punktów wpływu.'
        '<br>'
        '<br>Stronnictwa są wprowadzane do gry niezależnie od siebie tak, by nie wiedzieli, co usłyszały inne stronnictwa. Ma to na celu zbudowanie podstaw do rywalizacji między stronnictwami.'
        '</p>',
    description:
        // W skrócie
        '<h2>W skrócie</h2>'
        '<p style="text-align:justify;">'
        '<br>Gra toczy się między stronnictwami w turach. Dobrze, jeśli między turami zachowany jest znaczący odstęp czasu, np. jeśli każda tura rozgrywana jest kolejnego dnia.'
        '<br>'
        '<br>Gracze mogą zdobywać punkty wpływu potrzebne do wygrania gry na dwa sposoby:'
        '</p>'
        '<ol>'
        '<li>'
        '<p style="text-align:justify;">'
        '<u>Zdobywając <b>karty wiedzy</b></u>'
        '<br>Zdobywanie kart wiedzy odbywa się w toku gry opisanej w części “karty wiedzy”. Część ta nie jest związana z <b>główną mapą</b>.'
        '</p>'
        '</li>'
        '<li>'
        '<p style="text-align:justify;">'
        '<u>Wywołując <b>udane strajki</b></u>'
        '<br>Strajki mogą wywoływać <b>agenci wpływu</b> - są to fikcyjne postaci, którye stronnictwa plasują w poszczególnych <b>województwach</b> (agenci są umieszczani w formie znaczników na <b>głównej mapie</b>). Do skutecznego umieszczenia agenta wpływu w danym województwie niezbędne jest stworzenie mu odpowiedniej <b>legendy</b>, do której bardzo potrzebne są materiały (raporty realiów życia PRL oraz raporty z obserwacji obywatelskich PRL). Agenci mogą wywołać strajk w każdym momencie - powodzenie strajku zależy od warunków panujących w województwie (<b>poziom nastrojów społecznych</b> i <b>poziom kontroli</b>) oraz od <b>zasobów</b>, jakie dany agent ma przydzielone w momencie przeprowadzania strajku. Jeśli strajk się powiedzie, stronnictwo zdobywa <b>pięć punktów wpływu</b>. Jeśli się nie powiedzie, agent zostaje zdemaskowany i jest wycofywany z gry.'
        '</p>'
        '</li>'
        '</ol>'
        '<br>'
        // Szczegóły gry - województwa
        '<h2>Szczegóły gry</h2>'
        '<h3>Województwa</h3>'
        '<p style="text-align:justify;">'
        'Każde województwo zaznaczone jest na <b>mapie głównej</b> i jest opisane przez następujący zestaw cech:'
        '</p>'
        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Historia, kultura, struktura pracy, demografia</b>'
        '<br>Skala: brak.'
        '<br>'
        '<br>Co kilka tur każde województwo otrzymuje nową porcję lokalnych wydarzeń, na które Stronnictwa powinny reagować.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Nastroje społeczne</b> (zadowolenie mieszkańców)'
        '<br>Skala: 1-10.'
        '<br>'
        '<br>Nastroje społeczne zależą od wielu czynników: poziomu życia, dostępności produktów (jedzenie, ubrania, sprzęty domowe), dostępności usług (szkoła, lekarz), dostępności mieszkań, świadomości różnic między życiem w PRL a życiem za granicą, itp..'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Kontrola</b> (milicyjna kontrola obywateli)'
        '<br>Skala: 1-10.'
        '<br>'
        '<br>Milicyjna kontrola obywateli niesie za sobą inwigilację, kontrolę, przeszukania, porządek i mniejszą chęć do występowania przeciwko aparatowi władzy przez ludność.'
        '</p>'
        '</li>'

        '</ul>'
        // Szczegóły gry - zasoby
        '<h3>Zasoby</h3>'
        '<p style="text-align:justify;">'
        'Stronnictwa dysponują różnymi zasobami do osiągnięcia celu gry (czyli zakończenia gry z największą liczbą punktów wpływu).'
        '<br>'
        '<br>Podstawową walutą we współzawodnictwie jest PLZ (“stary” polski złoty). Stronnictwa otrzymują je w postaci wydrukowanych banknotów o nominałach:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">1 000 000 PLZ</p></li>'
        '<li><p style="text-align:justify;">2 000 000 PLZ</p></li>'
        '<li><p style="text-align:justify;">5 000 000 PLZ</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'i używają w celu realizowania swoich strategii i działań.'
        '<br>'
        '<br>Stronnictwa mają możliwość pozyskiwnia także innych walut. Są to:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;"><b>USD</b> (dolar amerykański)</p></li>'
        '<li><p style="text-align:justify;"><b>SUR</b> (sowiecki rubel)</p></li>'
        '<li><p style="text-align:justify;"><b>CSK</b> (korona czechosłowacka)</p></li>'
        '<li><p style="text-align:justify;"><b>DDM</b> (marka niemieckiej republiki demokratycznej)</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Zastępy codziennie otrzymują określoną liczbę PLZ za realizację zadań związanych z celami wychowawczymi (np. utrzymaniem czystości w namiotach podczas obozu, stawianiem się na czas na zbiórkach, czy nienagannym umundurowaniem). Prowadzący powinien dbać, by ilość PLZ uzyskiwanych w ciągu tury za cele wychowawcze wynosiła maksymalnie ok. 5 mln PLZ.'
        '<br>'
        '<br>Waluty zagraniczne (tj. USD, SUR, CSK, DDM) uczestnicy otrzymują w nominałach 1. Waluty te można pozyskać codziennie zgodnie z zasadami opisanymi w części <b>karty wiedzy</b>.'
        '</p>'
        // Szczegóły gry - agenci wpływu
        '<h3>Agenci wpływu</h3>'
        '<p style="text-align:justify;">'
        'Stronnictwa mogą umieszczać agentów wpływu na mapie. Agenci pozwalają uczestnikom na szereg działań:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Pozyskiwanie PLZ za pracę <u>zakładową agentów</u></p></li>'
        '<li><p style="text-align:justify;"><u>Zbieranie informacji</u> o wydarzeniach mogących wpływać na województwo</p></li>'
        '<li><p style="text-align:justify;">Wpływanie na poziom nastrojów społecznych i poziom kontroli w województwie poprzez <u>nagłaśnianie zebranych informacji</u></p></li>'
        '<li><p style="text-align:justify;">Zdobywanie punktów wpływu poprzez przeprowadzanie udanych <u>strajków</u></p></li>'

        '</ul>'
        '<p style="text-align:justify;">'
        'Każdy agent jest charakteryzowany przez następujący zestaw cech:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Stronnictwo, dla którego działa</p></li>'
        '<li><p style="text-align:justify;">Województwo, w którym operuje</p></li>'
        '<li><p style="text-align:justify;">Skuteczność, liczoną w skali od 0 do 10</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Jedno stronnictwo może mieć w jednym województwie dowolną liczbę agentów, choć posiadanie ich więcej niż 1 na województwo nie niesie za sobą większych korzyści.'
        '<br>'
        '<br><b>Agenci różnych stronnictw mogą się znajdować w tym samym województwie</b>.'
        '</p>'
        // Szczegóły gry - agenci wpływu - umieszczanie nowych agentów wpływu
        '<h4>Umieszczanie nowych agentów wypływu</h4>'
        '<p style="text-align:justify;">'
        'Umieszczenie nowego agenta wpływu na mapie przez określone stronnictwo odbywa się poprzez przekazanie prowadzącemu dwóch rzeczy:'
        '</p>'

        '<ul>'
        '<li>'
        '<p style="text-align:justify;">'
        'Środków na pozyskanie agenta (PLZ)'
        '<br>'
        '<br>Koszt pozyskania agenta wpływu zależy od:'
        '</p>'

        '<ul>'
          '<li>'
              '<p style="text-align:justify;">'
              '<u>Kosztu bazowego</u> (jednakowy dla wszystkich województw)'
              '<br>Na początku gry jest to <b>1 mln PLZ</b>. Koszt jest regulowany przez prowadzącego tak by zapewnić płynność gry'
              '</p>'
          '</li>'

          '<li>'
            '<p style="text-align:justify;">'
            '<u>Poziomu kontroli w województwie</u>'
            '<br><b>Za każdy poziom</b> kontroli w województwie to <b>+1 mln PLZ</b>'
            '</p>'
          '</li>'

          '<li>'
            '<p style="text-align:justify;">'
            '<u>Liczby rozpoznanych sąsiadujących województw</u>'
            '<br>Rozpoznane województwo to takie, w którym stronnictwo ma przynajmniej jednego swojego agenta. <b>Za każde województwo</b> sąsiadujące z tym, w którym umieszczany jest agent, cena to <b>-1 mln PLZ</b>'
            '</p>'
          '</li>'
        '</ul>'
        '</li>'

        '<li>'
            '<p style="text-align:justify;">'
            '<b>Legendy agenta</b>'
            '<br>'
            '<br>Legenda to jednostronicowy opis “przykrywki” agenta: opis codziennego życia, pracy, historii itd. uzupełniony na podstawie załącznika “wniosek o zalegendowanie agenta”.'
            '<br>'
            '<br>Na podstawie legendy prowadzący wystawia agentowi skuteczność sumując:'
            '</p>'
            '<ul>'
            '<li><p style="text-align:justify;">Wiarygodności legendy (0-2 pkt.)</p></li>'
            '<li><p style="text-align:justify;">Wyjątkowości legendy (0-2 pkt.)</p></li>'
            '<li><p style="text-align:justify;">Szczegółowości legendy (0-3 pkt.)</p></li>'
            '<li><p style="text-align:justify;">Dopasowania legendy do województwa w którym agent będzie działał (0-2 pkt.)</p></li>'
            '<li><p style="text-align:justify;">Ortografii i stylistyki (0-1 pkt.)</p></li>'
            '</ul>'
        '</li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Proces umieszczenia nowego <b>agenta wpływu</b> trwa całą turę - w turze bieżącej stronnictwa przekazują środki pieniężne i legendę agenta, zaś za planszy pojawia się on dopiero w kolejnej turze.'
        '<br>'
        '<br>Agent jest reprezentowany przez <b>znacznik na głównej mapie</b> gry oraz w segregatorze u prowadzącego grę, gdzie ma on swoją <b>koszulkę z legendą oraz zasobami</b>, które stronnictwo agentowi przydzieli.'
        '</p>'
        // Szczegóły gry - agenci wpływu - zasoby agenta
        '<h4>Zasoby agenta</h4>'
        '<p style="text-align:justify;">'
        'Każdy agent może mieć przydzielone od swojego stronnictwa zasoby w postaci <b>środków finansowych</b> (dowolnych walut) oraz <b>kart działań specjalnych</b>. Zasoby te można przydzielić lub odebrać agentowi jedynie na samym końcu tury.'
        '<br>'
        '<br>Zasoby agenta to środki, którymi dysponuje on w celu prowadzenia swoich działań: nagłaśnianie informacji oraz przeprowadzanie strajków.'
        // Szczegóły gry - agenci wpływu - zasoby agenta
        '<h4>Karty działań specjalnych</h4>'
    ,
    attachments: [
      attach_mapa_glowna,

      attach_banknot_csk_1,
      attach_banknot_ddm_1,
      attach_banknot_sur_1,
      attach_banknot_usd_1,
      attach_banknot_plz_1_mln,
      attach_banknot_plz_2_mln,
      attach_banknot_plz_5_mln,

      attach_wydarzenia_codzienne,
      attach_raporty_obserwacji_obywatelskich,
      attach_raporty_realiow_zycia,
      attach_wniosek_o_zalegendowanie_agenta,
      attach_wydarzenia_specjalne,
      attach_sciaga_dla_uczestnikow,
      attach_znaczniki_statystyk_wojewodztw,
      attach_karty_wiedzy,

      attach_sekretarz_bierut,
      attach_sekretarz_gomulka,
      attach_sekretarz_gierek,
      attach_sekretarz_jaruzelski
    ]
);
