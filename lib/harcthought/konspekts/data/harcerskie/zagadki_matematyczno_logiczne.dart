import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';

Konspekt zagadki_matematyczno_logiczne = const Konspekt(
  name: 'zagadki_matematyczno_logiczne',
  title: 'Zagadki matematno-logiczne',
  additionalSearchPhrases: ['zagadki', 'matematyka', 'logika'],
  category: KonspektCategory.harcerskie,
  type: KonspektType.zwyczaj,
  spheres: {
    ...spheresLogiczne
  },
  metos: [Meto.hs, Meto.wedro],
  coverAuthor: 'Freepik (hamimfadillah)',
  author: DANIEL_IWANICKI,
  customDuration: Duration(minutes: 90),
  aims: [
    'Kształtowanie u uczestników szacunku dla wiedzy i logicznego myślenia'
  ],
  summary: 'Uczestnicy otrzymują jedną zagadkę matematyczno-logiczną na dzień, którą mogą rozwiązać do końca dnia.',
  description: '<p style="text-align:justify;">'
      'Prowadzący formę regularnie (np. codziennie na apelu na obozie) przedstawia uczestnikom jedną zagadkę matematyczną, która jest w zasięgu ich możliwości intelektualnych, np:'
      '</p>'

      '<ul>'

      '<li>'
      '<p style="text-align:justify;">'
      '<i>“O magicznym kamieniu wiadomo tylko tyle, że waży on kilogram oraz pół magicznego kamienia.'
      '<br>Ile kilogramów waży magiczny kamień?”.</i>'
      '</p>'
      '</li>'

      '<li>'
      '<p style="text-align:justify;">'
      '<i>Pewien brat mówi o swoim młodszym bracie: „Dwa lata temu byłem trzy razy starszy od mojego brata. Za trzy lata będę dwa razy starszy od mojego brata”.'
      '<br>Ile mają teraz lat?</i>'
      '</p>'
      '</li>'

      '<li>'
      '<p style="text-align:justify;">'
      '<i>Dlaczego dźwięk nadjeżdżającego pociągu szybciej niesie się po torach niż w powietrzu?</i>'
      '</p>'
      '</li>'

      '<li>'
      '<p style="text-align:justify;">'
      '<i>Jeśli półtora kury zniesie półtora jajka w ciągu półtora dnia, ile jaj zniesie pół tuzina kur w ciągu pół tuzina dni?</i>'
      '</p>'
      '</li>'

      '<li>'
      '<p style="text-align:justify;">'
      '<i>Mamy kłódkę zamykaną na 3-cyfrowy szyfr. Musimy znaleźć jej kod. O kodzie wiadomo tylko, że:</i>'
      '</p>'
      '<ul>'

      '<li>'
      '<p style="text-align:justify;">'
      '<i>276 – jedna cyfra jest poprawna, ale w niewłaściwym miejscu.</i>'
      '</p>'
      '</li>'

      '<li>'
      '<p style="text-align:justify;">'
      '<i>387 – żadna cyfra nie jest właściwa.</i>'
      '</p>'
      '</li>'

      '<li>'
      '<p style="text-align:justify;">'
      '<i>368 – jedna cyfra jest właściwa i znajduje się we właściwym miejscu.</i>'
      '</p>'
      '</li>'

      '<li>'
      '<p style="text-align:justify;">'
      '<i>471 – dwie liczby są poprawne, ale znajdują się w niewłaściwym miejscu.</i>'
      '</p>'
      '</li>'

      '</ul>'

      '</li>'

      '<li>'
      '<p style="text-align:justify;"><i>Sześcienna kostka została rzucona jeden raz.'
      '<br>Jakie jest prawdopodobieństwo, że wyrzucona cyfra będzie parzysta i większa niż 2?</i></p>'
      '</li>'

      '</ul>'

      '<p style="text-align:justify;">'
      'Forma wykorzystuje wpływ sfer zdolności na sferę ducha korzystając z czynnika wartości wtórnych - uczestnicy będą mieli tendencję, by z czasem uznać umiejętność logicznego myślenia za ważną, ponieważ będą ją dobrze umieli. W ślad za tym pójdą zaś szacunek do nauki, krytycznego myślenia, itd..'
      '</p>',
);