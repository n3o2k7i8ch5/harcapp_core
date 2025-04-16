import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/poradnik/data.dart';

import 'common.dart';

const String attach_html_poradnik_o_strukturze_duchowosci = '<a href="$attach_name_poradnik_o_strukturze_duchowosci@attachment">$attach_title_poradnik_o_strukturze_duchowosci</a>';
const String attach_name_poradnik_o_strukturze_duchowosci = 'o_strukturze_i_ksztaltowaniu_duchowosci';
const String attach_title_poradnik_o_strukturze_duchowosci = 'Poradnik "$poradnik_title_o_strukturze_duchowosci"';
KonspektAttachment attach_poradnik_o_strukturze_duchowosci = KonspektAttachment(
  name: attach_name_poradnik_o_strukturze_duchowosci,
  title: attach_title_poradnik_o_strukturze_duchowosci,
  assets: {
    FileFormat.urlPdf: urlToPoradnikFile(poradnik_name_o_strukturze_duchowosci, "$poradnik_name_o_strukturze_duchowosci.pdf"),
    FileFormat.urlDocx: urlToPoradnikFile(poradnik_name_o_strukturze_duchowosci, "$poradnik_name_o_strukturze_duchowosci.docx"),
  },
);

const String attach_html_poradnik_przykladowa_strategia_rozwoju_duchowego = '<a href="$attach_name_poradnik_przykladowa_strategia_rozwoju_duchowego@attachment">$attach_title_poradnik_przykladowa_strategia_rozwoju_duchowego</a>';
const String attach_name_poradnik_przykladowa_strategia_rozwoju_duchowego = 'przykladowa_strategia_rozwoju_duchowego';
const String attach_title_poradnik_przykladowa_strategia_rozwoju_duchowego = 'Poradnik "$poradnik_title_przykladowa_strategia_rozwoju_duchowego"';
KonspektAttachment attach_poradnik_przykladowa_strategia_rozwoju_duchowego = KonspektAttachment(
  name: attach_name_poradnik_przykladowa_strategia_rozwoju_duchowego,
  title: attach_title_poradnik_przykladowa_strategia_rozwoju_duchowego,
  assets: {
    FileFormat.urlPdf: urlToPoradnikFile(poradnik_name_przykladowa_strategia_rozwoju_duchowego, "$poradnik_name_przykladowa_strategia_rozwoju_duchowego.pdf"),
    FileFormat.urlDocx: urlToPoradnikFile(poradnik_name_przykladowa_strategia_rozwoju_duchowego, "$poradnik_name_przykladowa_strategia_rozwoju_duchowego.docx"),
  },
);

const String attach_html_karty_poziomow_duchowosci = '<a href="$attach_name_karty_poziomow_duchowosci@attachment">$attach_title_karty_poziomow_duchowosci</a>';
const String attach_name_karty_poziomow_duchowosci = 'karty_poziomow_duchowosci';
const String attach_title_karty_poziomow_duchowosci = 'Karty poziomów duchowości';
KonspektAttachment attach_karty_poziomow_duchowosci = KonspektAttachment(
  name: attach_name_karty_poziomow_duchowosci,
  title: attach_title_karty_poziomow_duchowosci,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_karty_poziomow_duchowosci.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_karty_poziomow_duchowosci.docx',
  },
);

const String attach_html_karty_zdolnosci_integracji_duchowosci = '<a href="$attach_name_karty_zdolnosci_integracji_duchowosci@attachment">$attach_title_karty_zdolnosci_integracji_duchowosci</a>';
const String attach_name_karty_zdolnosci_integracji_duchowosci = 'karty_zdolnosci_integracji_duchowosci';
const String attach_title_karty_zdolnosci_integracji_duchowosci = 'Karty zdolności integracji duchowości';
KonspektAttachment attach_karty_zdolnosci_integracji_duchowosci = KonspektAttachment(
  name: attach_name_karty_zdolnosci_integracji_duchowosci,
  title: attach_title_karty_zdolnosci_integracji_duchowosci,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_karty_zdolnosci_integracji_duchowosci.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_karty_zdolnosci_integracji_duchowosci.docx',
  },
);

// Przykłady aksjomatów

const String attach_html_aksjomaty_opisu_przyklady = '<a href="$attach_name_aksjomaty_opisu_przyklady@attachment">$attach_title_aksjomaty_opisu_przyklady</a>';
const String attach_name_aksjomaty_opisu_przyklady = 'aksjomaty_opisu_przyklady';
const String attach_title_aksjomaty_opisu_przyklady = 'Aksjomaty opisu przykłady';
KonspektAttachment attach_aksjomaty_opisu_przyklady = KonspektAttachment(
  name: attach_name_aksjomaty_opisu_przyklady,
  title: attach_title_aksjomaty_opisu_przyklady,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_aksjomaty_opisu_przyklady.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_aksjomaty_opisu_przyklady.docx',
  },
);

const String attach_html_aksjomaty_opisu_i_sensu_przyklady = '<a href="$attach_name_aksjomaty_opisu_i_sensu_przyklady@attachment">$attach_title_aksjomaty_opisu_i_sensu_przyklady</a>';
const String attach_name_aksjomaty_opisu_i_sensu_przyklady = 'aksjomaty_opisu_i_sensu_przyklady';
const String attach_title_aksjomaty_opisu_i_sensu_przyklady = 'Aksjomaty opisu i sensu przykłady';
KonspektAttachment attach_aksjomaty_opisu_i_sensu_przyklady = KonspektAttachment(
  name: attach_name_aksjomaty_opisu_i_sensu_przyklady,
  title: attach_title_aksjomaty_opisu_i_sensu_przyklady,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_aksjomaty_opisu_i_sensu_przyklady.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_aksjomaty_opisu_i_sensu_przyklady.docx',
  },
);

const String attach_html_aksjomaty_sensu_przyklady = '<a href="$attach_name_aksjomaty_sensu_przyklady@attachment">$attach_title_aksjomaty_sensu_przyklady</a>';
const String attach_name_aksjomaty_sensu_przyklady = 'aksjomaty_sensu_przyklady';
const String attach_title_aksjomaty_sensu_przyklady = 'Aksjomaty sensu przykłady';
KonspektAttachment attach_aksjomaty_sensu_przyklady = KonspektAttachment(
  name: attach_name_aksjomaty_sensu_przyklady,
  title: attach_title_aksjomaty_sensu_przyklady,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_aksjomaty_sensu_przyklady.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_aksjomaty_sensu_przyklady.docx',
  },
);

const String attach_html_aksjomaty_bledne_przyklady = '<a href="$attach_name_aksjomaty_bledne_przyklady@attachment">$attach_title_aksjomaty_bledne_przyklady</a>';
const String attach_name_aksjomaty_bledne_przyklady = 'aksjomaty_bledne_przyklady';
const String attach_title_aksjomaty_bledne_przyklady = 'Aksjomaty błedne przykłady';
KonspektAttachment attach_aksjomaty_bledne_przyklady = KonspektAttachment(
  name: attach_name_aksjomaty_bledne_przyklady,
  title: attach_title_aksjomaty_bledne_przyklady,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_aksjomaty_bledne_przyklady.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_aksjomaty_bledne_przyklady.docx',
  },
);

// Meta-narracja

const String attach_html_meta_narracja_opis = '<a href="$attach_name_meta_narracja_opis@attachment">$attach_title_meta_narracja_opis</a>';
const String attach_name_meta_narracja_opis = 'meta_narracja_opis';
const String attach_title_meta_narracja_opis = 'Meta-narracja opis';
KonspektAttachment attach_meta_narracja_opis = KonspektAttachment(
  name: attach_name_meta_narracja_opis,
  title: attach_title_meta_narracja_opis,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_meta_narracja_opis.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_meta_narracja_opis.docx',
  },
);

const String attach_html_meta_narracja_przyklady = '<a href="$attach_name_meta_narracja_przyklady@attachment">$attach_title_meta_narracja_przyklady</a>';
const String attach_name_meta_narracja_przyklady = 'meta_narracja_przyklady';
const String attach_title_meta_narracja_przyklady = 'Meta-narracja przykłady';
KonspektAttachment attach_meta_narracja_przyklady = KonspektAttachment(
  name: attach_name_meta_narracja_przyklady,
  title: attach_title_meta_narracja_przyklady,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_meta_narracja_przyklady.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_meta_narracja_przyklady.docx',
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

const String attach_html_szybkie_strzaly_dyskusyjne = '<a href="$attach_name_szybkie_strzaly_dyskusyjne@attachment">$attach_title_szybkie_strzaly_dyskusyjne</a>';
const String attach_name_szybkie_strzaly_dyskusyjne = 'szybkie_strzaly_dyskusyjne';
const String attach_title_szybkie_strzaly_dyskusyjne = 'Szybkie strzały dyskusyjne';
const KonspektAttachment attach_szybkie_strzaly_dyskusyjne = KonspektAttachment(
  name: attach_name_szybkie_strzaly_dyskusyjne,
  title: attach_title_szybkie_strzaly_dyskusyjne,
  assets: {
    FileFormat.pdf: 'common/warsztaty_duchowe/$attach_name_szybkie_strzaly_dyskusyjne.pdf',
    FileFormat.docx: 'common/warsztaty_duchowe/$attach_name_szybkie_strzaly_dyskusyjne.docx',
  },
);