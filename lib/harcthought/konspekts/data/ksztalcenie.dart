import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

List<Konspekt> allKsztalcenieKonspekts = [

  // Done
  const Konspekt(
      name: 'beretowa',
      title: 'Beretówa',
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.cialo: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha, KonspektSphereMechanism.duchOtwartoscNaLudzi]
        )
      },
      metos: [Meto.kadra],
      coverAuthor: 'Freepik (???)',
      author: DANIEL_IWANICKI,
      aims: [

      ],
      materials: [

      ],
      summary: 'Leśna gra harcerska, w której drużyny mają za zadanie wyeliminować przeciwne drużyny ściągając im berety z głów.',
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
            title: 'Podział na grupy',
            duration: Duration(minutes: 10),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący dzieli uczestników na wybraną liczbę grup. Ważne, by każda grupa charakteryzowała się podobną sprawnością ruchową.</p>'
        ),

      ]
  ),

];