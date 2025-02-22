import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import '../level_examples.dart';

const String _konspekt_name = 'zycie_i_swiat_prl';

const String attach_html_mapa_glowna = '<a href="${attach_name_mapa_glowna}@attachment">${attach_title_mapa_glowna}</a>';
const String attach_name_mapa_glowna = "mapa_glowna";
const String attach_title_mapa_glowna = "Mapa główna";
KonspektAttachment attach_mapa_glowna = KonspektAttachment(
    name: attach_name_mapa_glowna,
    title: attach_title_mapa_glowna,
    assets: {
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'mapa_prl.pdf'),
      FileFormat.urlPng: urlToGitlabFile(_konspekt_name, 'mapa_prl.png'),
      FileFormat.urlSvg: urlToGitlabFile(_konspekt_name, 'mapa_prl.svg')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'banknot_csk_1.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'banknot_csk_1.docx'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'banknot_csk_1.webp')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'banknot_ddm_1.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'banknot_ddm_1.docx'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'banknot_ddm_1.webp')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'banknot_sur_1.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'banknot_sur_1.docx'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'banknot_sur_1.webp')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'banknot_usd_1.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'banknot_usd_1.docx'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'banknot_usd_1.webp')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'banknot_plz_1_mln.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'banknot_plz_1_mln.docx'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'banknot_plz_1_mln.webp')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'banknot_plz_2_mln.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'banknot_plz_2_mln.docx'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'banknot_plz_2_mln.webp')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'banknot_plz_5_mln.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'banknot_plz_5_mln.docx'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'banknot_plz_5_mln.webp')
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
    FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'wydarzenia_codzienne.pdf'),
    FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'wydarzenia_codzienne.docx')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'raporty_obserwacji_obywatelskich.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'raporty_obserwacji_obywatelskich.docx')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'raporty_realiow_zycia.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'raporty_realiow_zycia.docx')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'wniosek_o_zalegendowanie_agenta.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'wniosek_o_zalegendowanie_agenta.docx')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'wydarzenia_specjalne.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'wydarzenia_specjalne.docx')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'sciaga_dla_uczestnikow.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'sciaga_dla_uczestnikow.docx')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'znaczniki_statystyk_wojewodztw.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'znaczniki_statystyk_wojewodztw.docx')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'karty_wiedzy.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'karty_wiedzy.docx')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'sekretarz_bierut.pdf'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'sekretarz_bierut.webp')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'sekretarz_gomulka.pdf'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'sekretarz_gomulka.webp')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'sekretarz_gierek.pdf'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'sekretarz_gierek.webp')
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
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'sekretarz_jaruzelski.pdf'),
      FileFormat.urlWebp: urlToGitlabFile(_konspekt_name, 'sekretarz_jaruzelski.webp')
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.single)
);

const String attach_html_plakaty = '<a href="${attach_name_plakaty}@attachment">${attach_title_plakaty}</a>';
const String attach_name_plakaty = "plakaty";
const String attach_title_plakaty = "Plakaty propagandowe";
KonspektAttachment attach_plakaty = KonspektAttachment(
    name: attach_name_plakaty,
    title: attach_title_plakaty,
    assets: {
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'plakaty.pdf'),
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.single)
);

Konspekt zycie_i_swiat_prl = Konspekt(
    name: _konspekt_name,
    title: 'Życie i świat PRL',
    category: KonspektCategory.harcerskie,
    type: KonspektType.wspolzawoGrupowe,
    spheres: {
      KonspektSphere.umysl: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.other: {
              umyslZnajomoscHistorii: null,
            }
          }
      ),
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
          name: 'Marker',
          amount: 3,
          comment: "Do narysowania mapy na prześcieradle."
      ),

      KonspektMaterial(
          name: 'Punkty wpływu',
          amountAttendantFactor: 100,
          comment: "Dobrze nadają się w tym celu kryształki z akrylu (złote)."
      ),

      KonspektMaterial(
          name: 'Znaczniki protestu',
          amountAttendantFactor: 20,
          comment: "Dobrze nadają się w tym celu kryształki z akrylu (czerone)."
      ),

      KonspektMaterial(
          name: 'Znaczniki agentów dla każdego ze stronnictw',
          amountAttendantFactor: 50,
          comment: "Znaczniki powinny mieć różny kolor dla każdego stronnictwa. Dobrze nadają się w tym celu kryształki z akrylu (niebieskie, fioletowe, zielone, pomarańczowe, ...)."
      ),

      KonspektMaterial(
          name: 'Znaczniki wydarzeń specjalnych',
          amount: 50,
          comment: "Dobrze nadają się w tym celu kryształki z akrylu (białe)."
      ),

      KonspektMaterial(
          name: 'Pinezki',
          amount: 200,
          comment: "Pinezki są niezbędne, aby przypiąć do każdego z województw po jednym znaczniku poziomu nastrojów społecznych i poziomu kontorli oraz informacji nagłośnionych przez stronnictwa."
      ),

      KonspektMaterial(
          name: 'Segregator',
          amount: 10,
      ),

      KonspektMaterial(
        name: 'Koszulki na dokumenty',
        amount: 200,
      ),

      KonspektMaterial(
          name: 'Długopisy',
          amount: 5,
          comment: "Do spisywania legendy agentów."
      ),

      KonspektMaterial(
          name: 'Nożyczki',
          amount: 2,
          comment: "Część materiałów należy pociąć."
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_mapa_glowna"',
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

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_plakaty"',
          attachmentName: attach_name_plakaty,
          amount: 1,
          comment: 'Plakaty są jedynie elementem dekoracyjnym. Można je porozwieszać w różnych miejscach.'
      )

    ],
    summary: 'Uczestnicy wcielają się we frakcje polityczne chcące obalić w Polsce komunizm - muszą zdobyć zasoby, wiedzę i wpływy, by osiągnąć swój cel.',
    intro: '<p style="text-align:justify;">'
        'Skończyła się II wojna światowa. Polska jest zniszczona po okupacji niemieckiej i po przejściu radzieckiego frontu. Po pokoju w Jałcie nasz kraj znalazł się w sowieckiej strefie wpływów i w Warszawie zostali zainstalowani komuniści.'
        '<br>'
        '<br>Uczestnicy łączą się w <b>stronnictwa</b> - grupy niepodległościowe, które zeszły do konspiracji z powodu przytłaczającej przewagi Sowietów. Stronnictwa rozpoczynają długi proces mający na celu wypracować najlepszą metodę obalenia komunizmu, co wymaga od nich zdobycia potrzebnych środków: wiedzy, materiałów, pieniędzy, dostępu do agentów wpływu, rozpoznania nastrojów społecznych, itd..'
        '<br>'
        '<br>Każde ze stronnictw chce zdobyć najwięcej wpływu. Nie ufają żadnym innym organizacjom: wielokrotnie już okazywało się, że za słusznymi postulatami na ustach, kryli się zinfiltrowani przez obce mocarstwa zdrajcy. Wygrywa stronnictwo, które pod koniec współzawodnictwa zgromadzi najwięcej wpływu, reprezentowanego przez <b>punkty wpływu</b>.'
        '<br>'
        '<br>Stronnictwa są wprowadzane do gry niezależnie od siebie nie wiedząc, co usłyszały inne stronnictwa. Ma to na celu zbudowanie podstaw do rywalizacji między stronnictwami.'
        '</p>',
    description:
        // W skrócie
        '<h1>W skrócie</h1>'
        '<p style="text-align:justify;">'
        'Gra toczy się w turach. Dobrze, jeśli między turami zachowany jest znaczący odstęp czasu, np. jeśli każda tura rozgrywana jest kolejnego dnia.'
        '<br>'
        '<br>Zdobywanie punktów wpływu jest związane z poznawaniem przez uczestników realiów życia w PRL oraz strategicznym podejmowaniem działań. Punkty wpływu można zdobyć na dwa sposoby:'
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
        '<br>Strajki mogą wywoływać <b>agenci wpływu</b> - są to fikcyjne postaci, które stronnictwa plasują w poszczególnych <b>województwach</b> (agenci są umieszczani w formie znaczników na <b>głównej mapie</b>). Do skutecznego umieszczenia agenta wpływu w danym województwie niezbędne jest stworzenie mu odpowiedniej <b>legendy</b>, do której potrzebne są informacje o PRL (uczestnicy mają ciągły dostęp załączników: $attach_html_raporty_realiow_zycia i $attach_html_raporty_obserwacji_obywatelskich). Agenci mogą wywołać strajk w każdym momencie - powodzenie strajku zależy od warunków panujących w województwie (<b>poziom nastrojów społecznych</b> i <b>poziom kontroli</b>) oraz od <b>zasobów</b>, jakie dany agent ma przydzielone w momencie przeprowadzania strajku. Jeśli strajk się powiedzie, stronnictwo zdobywa <b>pięć punktów wpływu</b>. Jeśli się nie powiedzie, agent zostaje zdemaskowany i jest wycofywany z gry.'
        '</p>'
        '</li>'
        '</ol>'
        // Szczegóły gry - województwa
        '<h1>Szczegóły gry</h1>'
        '<h2>Województwa</h2>'
        '<p style="text-align:justify;">'
        'Gra toczy się głównie w jednym, ustalonym miejscu, gdzie na stałe umieszczona jest duża (ok. 1x1 m) <b>mapa główna</b> - konturowa mapa Polski podzielonej na 49 województw z okresu PRL wraz z fragemtami sąsiadujących wówczas z Polską państw (załącznik $attach_name_mapa_glowna). Mapa główna służy śledzeniu aktualnego stanu gry: rozmieszczenia agentów, skutków ich działania, wydarzeń specjalnych itd..'
        '<br>'
        '<br>Każde województwo na mapie jest opisane przez następujące elementy:'
        '</p>'
        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Historia, kultura, struktura pracy, demografia</b>'
        '<br>Skala: brak.'
        '<br>'
        '<br>Każde województwo posiada opis swoich specyficznych cech, statystyk itp.. Nie są one przedstawione na mapie głównej, ale są dostępne dla uczestników w formie segregatora z obok mapy z wydrukowanym załącznikiem $attach_html_raporty_realiow_zycia.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Nastroje społeczne</b> (zadowolenie mieszkańców)'
        '<br>Skala: 1-10.'
        '<br>'
        '<br>Nastroje społeczne zależą od wielu czynników: poziomu życia, dostępności produktów (jedzenie, ubrania, sprzęty domowe), dostępności usług (szkoła, lekarz), dostępności mieszkań, świadomości różnic między życiem w PRL a życiem za granicą, itp.. Poziom nastrojów społecznych jest ozaczony na mapie za pomocą znaczników $attach_html_znaczniki_statystyk_wojewodztw'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Kontrola</b> (milicyjna kontrola obywateli)'
        '<br>Skala: 1-10.'
        '<br>'
        '<br>Milicyjna kontrola obywateli niesie za sobą inwigilację, kontrolę, przeszukania, porządek i mniejszą chęć do występowania przeciwko aparatowi władzy przez ludność. Poziom kontroli jest ozaczony na mapie za pomocą znaczników $attach_html_znaczniki_statystyk_wojewodztw.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Wydarzenia codzienne</b>'
        '<br>Skala: brak.'
        '<br>'
        '<br>Co kilka tur każde województwo otrzymuje nową porcję lokalnych wydarzeń, na które stronnictwa powinny reagować. Wydarzenia te mogą mieć wpływ na nastroje społeczne. Domyślnie wydarzenia nie są oznaczone na mapie - pojawiają się tam tylko, jeśli stronnictwo zdecyduje się zainwestować środki za jego nagłośnienie.'
        '</p>'
        '</li>'

        '</ul>'
        // Szczegóły gry - zasoby
        '<h1>Szczegóły gry</h1>'
        '<h2>Zasoby</h2>'
        '<p style="text-align:justify;">'
        'Stronnictwa dysponują różnymi zasobami do osiągnięcia celu gry.'
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
        'Zastępy mogą codziennie otrzymać określoną liczbę PLZ za realizację zadań związanych z celami wychowawczymi (np. utrzymaniem czystości w namiotach podczas obozu, stawianiem się na czas na zbiórkach, czy nienagannym umundurowaniem). Prowadzący powinien dbać, by ilość PLZ uzyskiwanych w ciągu tury za cele wychowawcze wynosiła maksymalnie ok. 5 mln PLZ.'
        '<br>'
        '<br>Waluty zagraniczne (tj. USD, SUR, CSK, DDM) uczestnicy otrzymują w nominałach 1. Waluty te można pozyskać codziennie zgodnie z zasadami opisanymi w części <b>karty wiedzy</b>.'
        '</p>'
        // Szczegóły gry - agenci wpływu
        '<h1>Szczegóły gry</h1>'
        '<h2>Agenci wpływu</h2>'
        '<p style="text-align:justify;">'
        'Stronnictwa mogą umieszczać agentów wpływu na mapie. Agenci pozwalają uczestnikom na szereg działań:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Pozyskiwanie PLZ za <u>pracę zakładową agentów</u> (agenci zarabiają dla swojego stronnictwa PLZ z samego faktu swojego funkcjonowania w społeczeństwie),</p></li>'
        '<li><p style="text-align:justify;"><u>Zbieranie informacji</u> o wydarzeniach mogących wpływać na województwo,</p></li>'
        '<li><p style="text-align:justify;">Wpływanie na poziom nastrojów społecznych i poziom kontroli w województwie poprzez <u>nagłaśnianie zebranych informacji</u>,</p></li>'
        '<li><p style="text-align:justify;">Zdobywanie punktów wpływu poprzez przeprowadzanie udanych <u>strajków</u>,</p></li>'

        '</ul>'
        '<p style="text-align:justify;">'
        'Każdy agent jest opisany przez następujący zestaw cech:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Stronnictwo, dla którego działa,</p></li>'
        '<li><p style="text-align:justify;">Województwo, w którym operuje,</p></li>'
        '<li><p style="text-align:justify;">Skuteczność, liczoną w skali od 0 do 10,</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Jedno stronnictwo może mieć w jednym województwie dowolną liczbę agentów, choć posiadanie ich więcej niż 1 na województwo nie niesie za sobą większych korzyści.'
        '<br>'
        '<br>Agenci różnych stronnictw mogą się znajdować w tym samym województwie.'
        '</p>'
        // Szczegóły gry - agenci wpływu - umieszczanie nowych agentów wpływu
        '<h3>Umieszczanie nowych agentów wypływu</h3>'
        '<p style="text-align:justify;">'
        'Umieszczenie nowego agenta wpływu na mapie przez stronnictwo odbywa się poprzez przekazanie prowadzącemu gry dwóch rzeczy:'
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
            '<br>Legenda agenta to jednostronicowy opis “przykrywki” agenta: opis codziennego życia, pracy, historii itd. uzupełniony na podstawie załącznika $attach_wniosek_o_zalegendowanie_agenta.'
            '<br>'
            '<br>Na podstawie legendy prowadzący wystawia agentowi skuteczność. Ocenie podlegają:'
            '</p>'
            '<ul>'
            '<li><p style="text-align:justify;">Wiarygodność legendy (0-2 pkt.)</p></li>'
            '<li><p style="text-align:justify;">Wyjątkowość legendy (0-2 pkt.)</p></li>'
            '<li><p style="text-align:justify;">Szczegółowość legendy (0-3 pkt.)</p></li>'
            '<li><p style="text-align:justify;">Dopasowanie legendy do województwa w którym agent będzie działał (0-2 pkt.)</p></li>'
            '<li><p style="text-align:justify;">Ortografia i stylistyka (0-1 pkt.)</p></li>'
            '</ul>'
        '</li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Proces umieszczenia nowego agenta wpływu trwa jedną turę - w turze bieżącej stronnictwa przekazują środki pieniężne i legendę agenta, jednak za planszy pojawia się on dopiero na początku kolejnej tury.'
        '<br>'
        '<br>Agent jest reprezentowany przez <b>znacznik na głównej mapie</b> gry oraz przez podpisaną przez prowadzącego legendy agenta, przechowywaną przez stronnictwo. Ważne, by podpisana legenda agenta znajdowała się w <b>koszulce</b> - jest to niezbędne, aby agentom dało się przydzielić zasoby (można wówczas wrzucić banknoty do koszulki z legendą agenta).'
        '</p>'
        // Szczegóły gry - agenci wpływu - zasoby agenta
        '<h3>Zasoby agenta</h3>'
        '<p style="text-align:justify;">'
        'Każdy agent może mieć przydzielone zasoby w postaci <b>środków finansowych</b> (dowolnych walut) oraz <b>kart wsparcia agenta</b>. Zasoby te można przydzielić lub odebrać agentowi jedynie na samym końcu tury.'
        '<br>'
        '<br>Zasoby agenta to środki, którymi dysponuje on w celu prowadzenia swoich działań: nagłaśnianie informacji oraz przeprowadzanie strajków.'
        // Szczegóły gry - agenci wpływu - karty wsparcia operacji
        '<h3>Karty wsparcia operacji</h3>'
        '<p style="text-align:justify;">'
        '<b>Karty wsparcia operacji</b> to specjalne akcje, które można przydzielić agentom w celu zwiększenia ich skuteczności w czasie przeprowadzania strajków. Karty te można zdobyć od prowadzącego grę np. za postawę, zaangażowanie w zajęcia obozowe itp..'
        '<br>'
        '<br>Z kart wsparcia operacji agent może skorzystać jedynie, jeśli w trakcie strajku jest ona w przydzielonych mu zasobach. Karty wsparcia operacji są jednorazowe - po użyciu są zwracane prowadzącemu.'
        '<br>'
        '<br>Prowadzący ma dowolność w tworzeniu kart wsparcia operacji. Przykładowe karty wsparcia operacji to:'
        '<ul>'
            '<li><p style="text-align:justify;">Karta “Zaangażowanie” - zwiększa skuteczność agenta na czas strajku o 1 pkt.</p></li>'
            '<li><p style="text-align:justify;">Karta “Znajomość terenu” - zmniejsza poziom kontroli w województwie na czas strajku o 1 pkt.</p></li>'
            '<li><p style="text-align:justify;">Karta “Znajomość ludzi” - zmniejsza poziom nastrojów społecznych w województwie na czas strajku o 2 pkt.</p></li>'
            '<li><p style="text-align:justify;">Karta “Korumpowanie milicji” - zmniejsza poziom kontroli w województwie na czas strajku o 2 pkt.</p></li>'
            '<li><p style="text-align:justify;">Karta “Ewakuacja za winklem” - w przypadku przegranego strajku, agent nie zostaje zdemaskowany.</p></li>'
            '<li><p style="text-align:justify;">Karta “Wyciąganie wniosków” - w przypadku udanego strajku, agent otrzymuje na stałe +1 punkt skuteczności.</p></li>'
        '</ul>'
        // Szczegóły gry - agenci wpływu - strajk
        '<h3>Strajk</h3>'
        '<p style="text-align:justify;">'
        'Każdy agent może wywołać w swoim województwie strajk. Jeżeli strajk zakończy się powodzeniem, stronnictwo otrzymuje <b>5 punktów wpływu</b>. Jeśli strajk zakończy się porażką, agent zostaje zdemaskowany i znika (nie ma za niego żadnej rekompensaty).'
        '<br>'
        '<br>Po każdym strajku, niezależnie czy zakończonym powodzeniem, czy porażką, poziom kontroli w województwie rośnie o 1 lub o 2 poziomy (wybiera prowadzący).'
        '<br>'
        '<br>Strajk kończy się sukcesem, jeśli w turze następującej po jego rozpoczęciu agent ma więcej przydzielonych środków niż graniczny koszt powodzenia strajku. Koszt graniczny jest liczony jako suma następujących elementów:'
        '</p>'
        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Koszt bazowy</u>'
        '<br>Na początku gry jest to <b>10 mln PLZ</b>. Koszt może być w miarę postępu gry zwiększany lub zmniejszany przez prowadzącego.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Skuteczność agenta</u>'
        '<br><b>Za każdy poziom skuteczności agenta</b> koszt to <b>-1 mln PLZ</b>.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Poziom nastrojów społecznych w województwie</u>'
        '<br><b>Za każdy poziom nastrojów społecznych</b> koszt to <b>+1 mln PLZ</b>.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Poziom kontroli w województwie</u>'
        '<br><b>Za każdy poziom kontroli</b> koszt to <b>+1 mln PLZ</b>.'
        '</p>'
        '</li>'

        '</ul>'
        // Szczegóły gry - agenci wpływu - praca zakładowa agentów
        '<h3>Praca zakładowa agentów</h3>'
        '<p style="text-align:justify;">'
        'Stronnictwa pozyskują środki z województw, w których mają agentów za ich pracę w lokalnej gospodarce. Co turę wartość środków pozyskanych przez agenta się przez poprzez pomnożenie skuteczności agenta przez poziom nastrojów społecznych i podzielenie wyniku przez 100. Po zsumowaniu pozyskanych środków z wszystkich województw, wartość zaokrąglana jest w dół do milionów PLZ.'
        '<br>'
        '<br>Z każdego województwa ilość środków możliwych do pozyskania wynosi między 0 PLZ a 1 000 000 PLZ.'
        '<br>'
        '<br>Mechanizm ten ma dwa cele:'
        '</p>'
        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        'Zapewnić, by (zwłaszcza na początku) większość zasobów stronnictw pochodziła z realizacji celów wychowawczych.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'Wprowadzić u stronnictw powód do dbania o wysokie nastroje społeczne.'
        '</p>'
        '</li>'

        '</ul>'
        // Szczegóły gry - agenci wpływu - pozyskiwanie informacji
        '<h3>Pozyskiwanie informacji</h3>'
        '<p style="text-align:justify;">'
        'Stronnictwa (uczestnicy) otrzymują co turę informacje na temat wydarzeń w województwach, w którym mają umieszczonych agentów oraz województwach sąsiednich. Informacje te są dostępne w załączniku $attach_html_wydarzenia_codzienne. Stronnictwa mogą wykorzystywać te informacje w celu wpływania na nastroje społeczne.'
        '</p>'
        // Szczegóły gry - agenci wpływu - nagłaśnianie informacji
        '<h3>Nagłaśnianie informacji</h3>'
        '<p style="text-align:justify;">'
        'Agenci mogą nagłaśniać informacje, które do nich spływają. Nagłośnione informacje są publicznie dostępne w całym kraju, jednak mogą mieć różne oddziaływanie na różne województwa.'
        '<br>'
        '<br>Skutkiem nagłośnienia informacji jest <b>czasowe zwiększenie lub zmniejszenie poziomu nastrojów społecznych</b>. Pozytywne informacje zawsze zwiększają poziom nastrojów, negatywne informacje zawsze zmniejszają poziom nastrojów. Nagłośnienie informacji ma tym większy wpływ na poziom nastrojów, im więcej środków w postaci PLZ stronnictwo przeznaczy na jego nagłośnienie.'
        '<br>'
        '<br>Koszt osiągnięcia określonej zmiany dany jest kolejnymi liczbami ciągu Fibbonaciego:'
        '</p>'
        '<table border="1" style="border-collapse: collapse; width: 100%;">'
          '<tr>'
            '<th style="padding-left: 8px; padding-right: 8px;"><p>Zmiana poziomu nastrojów</p></th>'
            '<th style="padding-left: 8px; padding-right: 8px;"><p>Koszt</p></th>'
          '</tr>'
          '<tr>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>+- 1</p></td>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>2</p></td>'
          '</tr>'
          '<tr>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>+- 2</p></td>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>3</p></td>'
          '</tr>'
          '<tr>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>+- 3</p></td>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>5</p></td>'
          '</tr>'
          '<tr>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>+- 4</p></td>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>8</p></td>'
          '</tr>'
          '<tr>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>...</p></td>'
            '<td style="padding-left: 8px; padding-right: 8px;"><p>...</p></td>'
          '</tr>'
        '</table>'
        // Szczegóły gry - karty wiedzy
        '<h1>Szczegóły gry</h1>'
        '<h2>Karty wiedzy</h2>'
        '<p style="text-align:justify;">'
        'Karty wiedzy są kopią mechaniki z gry planszowej “Splendor”.'
        '<br>'
        '<br>Stronnictwa mogą zdobywać karty wiedzy (dostępne w załączniku $attach_html_karty_wiedzy) poprzez inwestowanie w nie odpowiednich środków. Karty wiedzy dostarczają dwóch rzeczy: zniżek na płatności w różnych walutach oraz (w niektórych przypadkach) punktów wpływu. Karty te są ciągle ogólnie dostępne na wspólnej dla stronnictw “tablicy rozwoju”.'
        '<br>'
        '<br>Karty wiedzy dzielą się na trzy kategorie: pierwszą, drugą i trzecią.'
        '</p>'
        '<ul>'
          '<li><p style="text-align:justify;">Kategoria pierwsza jest najtańsza i oferuje najmniej punktów wpływu za kartę (część kart pierwszej kategorii nie oferuje w ogóle punktów wpływu),</p></li>'
          '<li><p style="text-align:justify;">Kategoria druga jest nieco droższe i oferuje nieco więcej punktów wpływu za kartę,</p></li>'
          '<li><p style="text-align:justify;">Kategoria trzecia jest najdroższa i oferuje najwięcej punktów wpływu za kartę.</p></li>'
        '</ul>'
        '<p style="text-align:justify;">Każda karta wiedzy, niezależnie od poziomu oferuje zniżkę w wysokości 1 konkretnej waluty.'
        '<br>'
        '<br>Każdorazowo stronnictwa mają dostępne do kupienia po cztery karty wiedzy każdej kategorii (w sumie 12). Za każdym razem, gdy stronnictwo kupi kartę wiedzy wybranej kategorii, prowadzący natychmiast dodaje do puli kart wiedzy kolejną kartę tej samej kategorii, tak, by liczba dostępnych kart wiedzy każdej kategorii stale wynosiła 4.'
        '<br>'
        '<br>Jeżeli w toku gry zabraknie kart wiedzy jakiejś kategorii (zostaną one wszystkie wykupione), prowadzący nie dostawia kolejnych kart tej kategorii - wówczas na stałe liczba dostępnych kart wiedzy maleje.'
        '<br>'
        '<br>W każdej turze każde stronnictwo może wybrać jedną z trzech możliwości:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Kupić maksymalnie jedną kartę wiedzy,</p></li>'
        '<li><p style="text-align:justify;">Pobrać po 1 jednostkę trzech różnych wybranych walut zagranicznych,</p></li>'
        '<li><p style="text-align:justify;">Pobrać 2 jednostki jednej, wybranej waluty zagranicznej.</p></li>'
        '</ul>'
        // Meta zasady
        '<h1>Meta zasady</h1>'
        '<p style="text-align:justify;">'
        'Uczestnicy powinni sami wywnioskować niniejszą prawidłowość, a jeśli tego nie robią, prowadzący może ich nakierować:'
        '<br>'
        '<br>Z jednej strony im lepsze nastroje społeczne, tym więcej środków dodatkowych otrzymują stronnictwa.'
        '<br>'
        '<br>Z drugiej strony im lepsze nastroje społeczne, tym zazwyczaj mniejsza kontrola. Oznacza to, że łatwiej i taniej jest umieszczać Agentów w czasach dobrych nastrojów społecznych, ale na strajki należy poczekać aż nadejdą trudne czasy.'
        '</p>'
        // Rozpoczęcie gry
        '<h1>Rozpoczęcie gry</h1>'
        '<ol>'
            '<li><p style="text-align:justify;">Stronnictwa wybierają swoje nazwy,</p></li>'
            '<li><p style="text-align:justify;">Stronnictwa wybierają dowolne skrajne województwo, w którym za darmo lokują swojego pierwszego Agenta (po przekazaniu prowadzącemu Legendy Agenta).</p></li>'
        '</ol>'
        // Przebieg tury
        '<h1>Przebieg tury</h1>'
        '<p style="text-align:justify;">'
        'Każda tura odbywa się w konkretnym roku (lub przedziale lat). Jest to ważne, aby prowadzący tę turę przeprowadził odnosząc się do historycznych wydarzeń z tamtego okresu - w innym wypadku współzawodnictwo dużo straci z waloru edukacyjnego.'
        '</p>'
        '<ol>'
        '<li>'
          '<p style="text-align:justify;">'
          '<b>Rozmieszczenie nowych agentów</b>'
          '<br>Rozmieszczenie na planszy agentów zalegendowanych w poprzedniej turze.'
          '</p>'
        '</li>'
        '<li><p style="text-align:justify;"><b>Pozyskiwane przez każde ze stronnictw karty wiedzy lub walut zagranicznych (ten punkt można zagrać kilka razy z rzędu w każdej turze).</b></p></li>'
        '<li>'
          '<p style="text-align:justify;">Wprowadzenie prowadzącego do obecnych czasów historycznych</p>'
        '</li>'
        '<li>'
            '<p style="text-align:justify;">'
            '<b>Pozyskanie informacji</b>'
            '<br>Przekazanie stronnictwom nowych informacji z województw rozpoznanych oraz województw sąsiednich.'
            '</p>'
        '</li>'
        '<li>'
            '<p style="text-align:justify;">'
            '<b>Zgłaszanie nowych agentów</b>'
            '<br>Zgłaszanie nowych agentów do umieszczenia wraz z opłatą kosztu poprzez wręczenie uzupełnionego załącznika $attach_html_wniosek_o_zalegendowanie_agenta'
            '</p>'
        '</li>'
        '<li>'
            '<p style="text-align:justify;">'
            '<b>Akcje agentów</b>'
            '<br>Wykonywanie akcji agentów + opłata kosztów akcji.'
            '</p>'
            '<ol>'
            '<li><p style="text-align:justify;">Rozprzestrzenianie informacji</p></li>'
            '<li><p style="text-align:justify;">Ogłaszanie strajków</p></li>'
            '</ol>'
        '</li>'
        '<li>'
            '<p style="text-align:justify;">'
            '<b>Uwzględnienie akcji agentów</b>'
            '<br>Prowadzący nanosi na planszę gry skutki akcji agentów - zmiany w nastrojach społecznych, poziomie kontroli, etc.'
            '</p>'
        '</li>'
        '<li>'
            '<p style="text-align:justify;">'
            '<b>Pozyskanie środków dodatkowych</b>'
            '<br>Prowadzący przyznaje stronnictwom dodatkowe środki pochodzące z pracy Agentów w lokalnych gospodarkach.'
            '</p>'
        '</li>'
        '<li>'
            '<p style="text-align:justify;">'
            '<b>Przydzielanie agentom zasobów</b>'
            '<br>Stronnictwa mogą przydzielić dowolnym agentom dowolne zasoby jakie chcą. Nie będą oni mogli ich jednak odebrać agentowi aż do zakończenia następnej tury.'
            '</p>'
        '</li>'
        '<li>'
            '<p style="text-align:justify;">'
            '<b>Obserwacja i analiza</b>'
            '<br>Przez określony czas (np. do końca dnia) uczestnicy nie wykonują żadnych działań bezpośrednich. Mogą w tym czasie analizować sytuację na planszy, planować dalsze kroki, przygotowywać legendy nowych agentów itp.'
            '</p>'
        '</li>'
        '</ol>'

        // Etapy gry
        '<h1>Etapy gry</h1>'
        '<p style="text-align:justify;">'
        'Gra, ponieważ ma także walor historyczny, składa się z kolejnych “etapów komunizmu”. W momencie nastania kolejnych etapów w grze, w miejscu rozłożenia planszy dobrze jest wywiesić portret sekretarza generalnego KC PZPR, żeby uczestnicy zobaczyli jak wyglądał.'
        '</p>'
        '<ol>'
        '<li>'
            '<p style="text-align:justify;">Okres stalinizmu (bierutowski) (1944-1956 r.)</p>'
            '<ol>'
            '<li><p style="text-align:justify;">Represje polityczne,</p></li>'
            '<li><p style="text-align:justify;">Kolektywizacja rolnictwa,</p></li>'
            '<li><p style="text-align:justify;">1947 r. - Sfałszowane wybory,</p></li>'
            '<li><p style="text-align:justify;">1953 r. - Śmierć Stalina,</p></li>'
            '<li><p style="text-align:justify;">1956 r. - Śmierć Bieruta.</p></li>'
            '</ol>'
        '</li>'

        '<li>'
            '<p style="text-align:justify;">Okres gomułkowski (1956-1970 r.)</p>'
            '<ol>'
            '<li><p style="text-align:justify;">Odwilż, poprawa życia społecznego</p></li>'
            '<li><p style="text-align:justify;">Stabilizacja i stagnacja - z początku nadzieje i zmiany, z czasem pogarszająca się sytuacja ekonomiczna i coraz bardziej autorytarne rządy.</p></li>'
            '<li><p style="text-align:justify;">1956 r. - Wybranie Władysława Gomułki na I Sekretarza PZPR.</p></li>'
            '</ol>'
        '</li>'

        '<li>'
            '<p style="text-align:justify;">Okres gierkowski (1970-1980 r.)</p>'
            '<ol>'
            '<li><p style="text-align:justify;">Dynamiczne reformy gospodarcze - pożyczki, inwestycje w przemysł i infrastrukturę.</p></li>'
            '<li><p style="text-align:justify;">Kryzys i rozczarowanie, rosnący dług</p></li>'
            '<li><p style="text-align:justify;">1980 r. - protesty, które zakończyły epokę Gierka</p></li>'
            '</ol>'
        '</li>'

        '<li>'
            '<p style="text-align:justify;">Okres Solidarności (1980-1981 r.)</p>'
            '<ol>'
            '<li><p style="text-align:justify;">Powstanie Solidarności, masowe ruchy robotnicze,</p></li>'
            '</ol>'
        '</li>'

        '<li>'
            '<p style="text-align:justify;">Okres stanu wojennego (1981-1983 r.)</p>'
            '<ol>'
            '<li><p style="text-align:justify;">Wprowadzenie stanu wojennego w odpowiedzi na rosnące napięcia społeczne</p></li>'
            '</ol>'
        '</li>'

        '<li>'
            '<p style="text-align:justify;">Okres schyłkowy (1983-1989 r.)</p>'
            '<ol>'
            '<li><p style="text-align:justify;">Po stanie wojennym rządy Jaruzelskiego kontynuowały represje wobec opozycji, ale jednocześnie zaczęły prowadzić z nimi negocjacje.</p></li>'
            '</ol>'
        '</li>'

        '<li>'
            '<p style="text-align:justify;">Rozpad ZSRR (1991 r.)</p>'
            '<ol>'
            '<li><p style="text-align:justify;">...</p></li>'
            '</ol>'
        '</li>'

        '</ol>',

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
      attach_sekretarz_jaruzelski,

      attach_plakaty,
    ]
);
