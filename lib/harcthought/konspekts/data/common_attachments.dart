import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/poradnik/data.dart';

import 'common.dart';

const String attach_html_o_strukturze_i_ksztaltowaniu_duchowosci = '<a href="$attach_name_o_strukturze_i_ksztaltowaniu_duchowosci@attachment">$attach_title_o_strukturze_i_ksztaltowaniu_duchowosci</a>';
const String attach_name_o_strukturze_i_ksztaltowaniu_duchowosci = 'o_strukturze_i_ksztaltowaniu_duchowosci';
const String attach_title_o_strukturze_i_ksztaltowaniu_duchowosci = 'O strukturze i ksztaltowaniu duchowosci';
KonspektAttachment attach_o_strukturze_i_ksztaltowaniu_duchowosci = KonspektAttachment(
  name: attach_name_o_strukturze_i_ksztaltowaniu_duchowosci,
  title: attach_title_o_strukturze_i_ksztaltowaniu_duchowosci,
  assets: {
    FileFormat.urlPdf: urlToPoradnikFile(poradnik_name_o_strukturze_i_ksztaltowaniu_duchowosci, "$poradnik_name_o_strukturze_i_ksztaltowaniu_duchowosci.pdf"),
    FileFormat.urlDocx: urlToPoradnikFile(poradnik_name_o_strukturze_i_ksztaltowaniu_duchowosci, "$poradnik_name_o_strukturze_i_ksztaltowaniu_duchowosci.docx"),
  },
);

const String attach_html_poziomy_duchowosci = '<a href="$attach_name_poziomy_duchowosci@attachment">$attach_title_poziomy_duchowosci</a>';
const String attach_name_poziomy_duchowosci = 'poziomy_duchowosci';
const String attach_title_poziomy_duchowosci = 'Poziomy duchowości';
KonspektAttachment attach_poziomy_duchowosci = KonspektAttachment(
  name: attach_name_poziomy_duchowosci,
  title: attach_title_poziomy_duchowosci,
  assets: {
    FileFormat.urlPdf: 'common/warsztaty_duchowe/$attach_name_poziomy_duchowosci.pdf',
    FileFormat.urlDocx: 'common/warsztaty_duchowe/$attach_name_poziomy_duchowosci.docx',
  },
);

const String attach_html_neutralnosc_duchowa_przyklady = '<a href="$attach_name_neutralnosc_duchowa_przyklady@attachment">$attach_title_neutralnosc_duchowa_przyklady</a>';
const String attach_name_neutralnosc_duchowa_przyklady = 'neutralnosc_duchowa_przyklady';
const String attach_title_neutralnosc_duchowa_przyklady = 'Neutralność duchowa - przykłady';
const KonspektAttachment attach_neutralnosc_duchowa_przyklady = KonspektAttachment(
  name: attach_name_neutralnosc_duchowa_przyklady,
  title: attach_title_neutralnosc_duchowa_przyklady,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_neutralnosc_duchowa_przyklady.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_neutralnosc_duchowa_przyklady.docx',
  },
);

const String attach_html_cel_wychowania_duchowego_zhp_statut = '<a href="$attach_name_cel_wychowania_duchowego_zhp_statut@attachment">$attach_title_cel_wychowania_duchowego_zhp_statut</a>';
const String attach_name_cel_wychowania_duchowego_zhp_statut = 'cel_wychowania_duchowego_zhp_statut';
const String attach_title_cel_wychowania_duchowego_zhp_statut = 'Cel wychowania duchowego ZHP - statut';
const KonspektAttachment attach_cel_wychowania_duchowego_zhp_statut = KonspektAttachment(
  name: attach_name_cel_wychowania_duchowego_zhp_statut,
  title: attach_title_cel_wychowania_duchowego_zhp_statut,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_cel_wychowania_duchowego_zhp_statut.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_cel_wychowania_duchowego_zhp_statut.docx',
  },
);

const String attach_html_cel_wychowania_duchowego_zhp_uchwala = '<a href="$attach_name_cel_wychowania_duchowego_zhp_uchwala@attachment">$attach_title_cel_wychowania_duchowego_zhp_uchwala</a>';
const String attach_name_cel_wychowania_duchowego_zhp_uchwala = 'cel_wychowania_duchowego_zhp_uchwala';
const String attach_title_cel_wychowania_duchowego_zhp_uchwala = 'Cel wychowania duchowego ZHP - uchwała';
const KonspektAttachment attach_cel_wychowania_duchowego_zhp_uchwala = KonspektAttachment(
  name: attach_name_cel_wychowania_duchowego_zhp_uchwala,
  title: attach_title_cel_wychowania_duchowego_zhp_uchwala,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_cel_wychowania_duchowego_zhp_uchwala.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_cel_wychowania_duchowego_zhp_uchwala.docx',
  },
);

const String attach_html_kratka_minimow_rozwoju_duchowego = '<a href="$attach_name_kratka_minimow_rozwoju_duchowego@attachment">$attach_title_kratka_minimow_rozwoju_duchowego</a>';
const String attach_name_kratka_minimow_rozwoju_duchowego = 'kratka_minimow_rozwoju_duchowego';
const String attach_title_kratka_minimow_rozwoju_duchowego = 'Kratka minimów rozwoju duchowego';
const KonspektAttachment attach_kratka_minimow_rozwoju_duchowego = KonspektAttachment(
  name: attach_name_kratka_minimow_rozwoju_duchowego,
  title: attach_title_kratka_minimow_rozwoju_duchowego,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_kratka_minimow_rozwoju_duchowego.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_kratka_minimow_rozwoju_duchowego.docx',
  },
);