import '../konspekt.dart';

// Duch - Postawy
const String postawaMyslenieOInnych = "Myślenie o innych";
const String postawaKarnosc = "Karność";
const String postawaOdpowiedzialnosc = "Odpowiedzialność";
const String postawaOtwartoscNaLudzi = "Otwartość na ludzi";
const String postawaPrzebaczenie = "Przebaczenie";
const String postawaPostepowanieZgodnieZPH = "Postępowanie zgodnie z Prawem Harcerskim";
const String postawaPostepowanieZgodnieZPZ = "Postępowanie zgodnie z Prawem Zucha";
const String postawaPunktualnosc = "Punktualność";
const String postawaRozumienieObcychPogladow = "Rozumienie obcych poglądów";
const String postawaSkupienie = "Skupienie";
const String postawaSkuteczneDzialanie = "Skuteczne działanie";
const String postawaSpojnoscZWartosciamiChrzescijanskimi = "Spojność wł. postaw z wartościami chrześcijańskimi";
const String postawaSumiennosc = "Sumienność";
const String postawaTolerowaniaRyzyka = "Tolerowanie ryzyka";
const String postawaUwaznosc = "Uważność";
const String postawaWdziecznosc = "Wdzięczność";
const String postawaWyciszenie = "Wyciszenie";

// Duch - Warości
const String wartoscBliskoscZBogiem = "Bliskość z Bogiem";
const String wartoscBystrosc = "Bystrość";
const String wartoscPokoj = "Pokój";
const String wartoscPrzynaleznoscDoHarcerstwa = "Przynależność do harcerstwa";
const String wartoscSpojnoscZAksjomatamiChrzescijanskimi = "Spojność wł. wartości z aksjomatami chrześcijańskimi";
const String wartoscSprawnoscFizyczna = "Sprawność fizyczna";
const String wartoscUwaznosc = "Uważność";
const String wartoscWiedza = "Wiedza";
const String wartoscWspolnota = "Wspólnota";
const String wartoscWyciszenie = "Wyciszenie";
const String wartoscZdrowie = "Zdrowie";

// Duch - Aksjomaty
const String aksjoPrzezycieHistoriiBiblijnej = "Przeżycie historii biblijnej";
const String aksjoRozwazanieSensuICeluZycia = "Rozważanie sensu i celu życia";
const String aksjoSpotkanieBogaWeMszySw = "Spotkanie Boga we Mszy Świętej";

const String aksjoNarodzinyChrystusa = "Historia narodzin Chrystusa";
const String aksjoZbawczaRolaChrystusa = "Zbawcza rola Chrystusa";
const String aksjoZbawienie = "Historia zbawienia";
const String aksjoModlitwa = "Modlitwa";
const String aksjoAksjomatyChrzescijanskie = "Aksjomaty chrześcijańskie";

// Cialo
const String cialoZdolnoscMarszu = "Zdolność marszu";

// Umysl
const String umyslDyskusja = "Umiejętność dyskusji";
const String umyslKoncentracja = "Zdolność koncentracji";
const String umyslLogiczneMyslenie = "Zdolność logicznego myślenia";


// Emocje
const String emoOdczytywanieWlasnychEmocji = "Zdolność odczytywania własnych emocji";
const String emoPanowanieNadEmocjami = "Zdolność panowania nad emocjami";


// Hart ducha
const String hartFuncjonowanieMimoNiewygody = "Funkcjonowanie mimo niewygody";

const Map levelHartDucha = {
  KonspektSphereLevel.duchHartDucha: {
    hartFuncjonowanieMimoNiewygody: {
      KonspektSphereFactor.duchBezposrednieDoswiadczenie,
    }
  }
};

const Map<KonspektSphere, KonspektSphereDetails> spheresLogiczne = {
  KonspektSphere.umysl: KonspektSphereDetails(
      levels: {
        KonspektSphereLevel.other: {
          umyslLogiczneMyslenie: null
        }
  }
  ),
  KonspektSphere.duch: KonspektSphereDetails(
      levels: {
        KonspektSphereLevel.duchPostawy: {
          postawaUwaznosc: {
            KonspektSphereFactor.duchNormalizacja,
            KonspektSphereFactor.duchBezposrednieDoswiadczenie,
            KonspektSphereFactor.duchWartosciWtorne,
            KonspektSphereFactor.duchWzajemnoscOddzialywan
          }
        },
        KonspektSphereLevel.duchWartosci: {
          wartoscBystrosc: {
            KonspektSphereFactor.duchNormalizacja,
            KonspektSphereFactor.duchWartosciWtorne,
            KonspektSphereFactor.duchBezposrednieDoswiadczenie,
            KonspektSphereFactor.duchWzajemnoscOddzialywan
          },
        },
        ...levelHartDucha
      }
  ),
};