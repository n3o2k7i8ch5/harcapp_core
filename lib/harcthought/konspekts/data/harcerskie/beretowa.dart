import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../level_examples.dart';
import '_consts.dart';

Konspekt beretowa = const Konspekt(
    name: 'beretowa',
    title: 'Beretówa',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.cialo: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.other: KonspektSphereFields(
                fields: {cialoKoordynacjaRuchowa: null}
            )
          }
      ),
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchPostawy: KonspektSphereFields(
                fields: {
                  postawaOtwartoscNaLudzi: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan,
                    KonspektSphereFactor.duchPerspektywa_Normalizacja
                  }
                }
            ),

            KonspektSphereLevel.duchWartosci: KonspektSphereFields(
                fields: {
                  wartoscSprawnoscFizyczna: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan,
                    KonspektSphereFactor.duchPerspektywa_Normalizacja
                  }
                }
            ),

            ...levelSilaCharakteru
          }
      )
    },
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'Freepik (vecstock)',
    author: DANIEL_IWANICKI,
    aims: [
      aimPostawaWspolpracy,
      aimSzacunekDlaSprawnosciFizycznej,
      aimSzacunekDlaSkutecznegoDzialania,
      'Kształtowanie u uczestników siły charakteru - działania pomimo drobnych zadrapań, wybitych palców, etc.'
    ],
    materials: [
      KonspektMaterial(
        amountAttendantFactor: 1,
        name: 'Beret',
      ),
      KonspektMaterial(
        amountAttendantFactor: 1,
        name: 'Znacznik przynależności do grupy',
      ),
    ],
    summary: 'Leśna gra, w której drużyny mają za zadanie wyeliminować przeciwne drużyny ściągając im berety z głów.',
    description: '<p style="text-align:justify;">Aby forma była skuteczna, uczestnicy muszą być w nią zaangażowani i nie mieć nic przeciwko rywalizacji (częściej jest to domeną chłopców niż dziewczyn). Forma bywa kontuzjogenna.'
        '<br>'
        '<br>Forma powinna być toczona na dużym terenie lesistym zapewniającym możliwość łatwego skrycia się.'
        '<br>'
        '<br>Zachowując opisane niżej zasady gry można nieznacznie zmienić jej cel dla uczestników, np:</p>'
        '<ul>'
        '<li>'
        '<p style="text-align:justify;">Drużyny są dzielone na <b>atakującą</b> i <b>broniącą</b>. Drużyna <b>broniąca</b> ma wyznaczony <b>teren krytyczny</b> (np. między pięcioma drzewami). Drużyna atakująca ma wyznaczonego <b>sapera</b> - osobę, która posiada przedmiot będący <b>bombą</b> (np. menażkę).'
        '<br>'
        '<br>Drużyna <b>atakująca</b> wygrywa, jeśli <b>saper</b> położy <b>bombę</b> w <b>terenie krytycznym</b>, przy czym <b>bombą</b> nie wolno rzucać.'
        '<br>'
        '<br>Drużyna <b>broniąca</b> wygrywa, jeśli zabije <b>sapera</b> lub jeśli obroni <b>teren krytyczny</b> przez 20 minut od rozpoczęcia gry.'
        '</p>'
        '</li>'
        '<li><p style="text-align:justify;">Każda drużyna ma wyznaczoną <b>królową</b>. Drużyna przegrywa, jeśli straci <b>królową</b> niezależnie od tego ile osób pozostanie na końcu przy życiu. Przegrana drużyna natychmiast kończy grę.</p></li>'
        '</ul>',
    steps: [

      KonspektStep(
          title: 'Przedstawienie zasad',
          duration: Duration(minutes: 10),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Prowadzący przedstawia uczestnikom zasady gry:</p>'
              '<ul>'
              '<li><p style="text-align:justify;">W grze biorą udział co najmniej dwie grupy. Wygrywa grupa, której w której jako ostatniej zostaną "żywi" uczestnicy.</p></li>'
              '<li><p style="text-align:justify;">Każdy uczestnik rozpoczyna mając na głowie beret. Jak uczestnik ma na głowie beret, tak długo jest "żywy".</p></li>'
              '<li><p style="text-align:justify;">Berety można (a nawet trzeba) sobie wzajemnie ściągać z głowy.</p></li>'
              '<li><p style="text-align:justify;">W grze nie wolno uderzać, gryźć, kopać, ani dotykać twarzy drugiej osoby.</p></li>'
              '<li><p style="text-align:justify;">Gra toczy się na wybrany, jasny znak (np. trzykrotny gwizdek prowadzącego).</p></li>'
              '</ul>'
      ),


      KonspektStep(
          title: 'Podział na grupy',
          duration: Duration(minutes: 10),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Prowadzący dzieli uczestników na wybraną liczbę grup. Ważne, by każda grupa charakteryzowała się podobną sprawnością ruchową.</p>'
      ),


      KonspektStep(
          title: 'Oznaczenie grup',
          duration: Duration(minutes: 5),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Każdy uczestnik zostaje oznaczenie przynależności do swojej grupy. Może to być szarfa naramienna o innym kolorze dla każdej grupy lub po prostu może to być beret o wybranym kolorze.'
              '<br>'
              '<br>Jeżeli do gry używane są berety harcerskie, ważne jest, by nie miały one na sobie lilijek lub by berety były "wywrócone na lewą stronę" - inaczej łatwo o pocięte dłonie.</p>'
      ),


      KonspektStep(
          title: 'Gra',
          duration: Duration(minutes: 30),
          activeForm: KonspektStepActiveForm.active,
          content: '<p style="text-align:justify;">Grupy rozchodzą się po lesie i rozpoczyna się gra zgodnie z opisanymi wcześniej zasadami.</p>'
      ),


      KonspektStep(
          title: 'Podsumowanie',
          duration: Duration(minutes: 5),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Prowadzący po zakończeniu gry podsumowuje jej przebieg z uczestnikami.</p>'
      ),


      KonspektStep(
          title: 'Rewanż',
          duration: Duration(minutes: 30),
          activeForm: KonspektStepActiveForm.active,
          content: '<p style="text-align:justify;">Grupy rozchodzą się po lesie i rozpoczyna się druga gra zgodnie z opisanymi wcześniej zasadami.</p>'
      ),


      KonspektStep(
          title: 'Podsumowanie',
          duration: Duration(minutes: 5),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Prowadzący po zakończeniu rewanżu podsumowuje jej przebieg z uczestnikami.</p>'
      ),

    ]
);
