import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';

Konspekt biwak_bez_nadzoru = const Konspekt(
    name: 'biwak_bez_nadzoru',
    title: 'Biwak bez nadzoru',
    category: KonspektCategory.harcerskie,
    type: KonspektType.projekt,
    spheres: {
      KonspektSphere.umysl: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.other: KonspektSphereFields(
                fields: {
                  umyslPlanowanie: null,
                  umyslPodzialZadan: null
                }
            )
          }
      ),
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchPostawy: KonspektSphereFields(
                fields: {
                  postawaSkuteczneDzialanie: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                  postawaSumiennosc: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                  postawaOdpowiedzialnosc: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                  postawaUwaznosc: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                }
            ),
            KonspektSphereLevel.duchWartosci: KonspektSphereFields(
                fields: {
                  wartoscWspolnota: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                }
            ),
            ...levelSilaCharakteru
          }
      ),
      KonspektSphere.relacje: KonspektSphereDetails(
        levels: {
          KonspektSphereLevel.other: KonspektSphereFields(
              fields: {
                relWspolpracaWGrupie: null,
                relNegocjowanieRoliWGrupie: null,
              }
          )
        },
      )
    },
    metos: [Meto.hs, Meto.wedro],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    aims: [
      'Kształtowanie u uczestników postawy i umiejętności odpowiedzialności',
      'Kształtowanie u uczestników postawy sumienności, zaradności i proaktywnej postawy',
      'Kształtowanie u uczestników postawy uważności na kwestie poza bezpośrednim polem swoich obowiązków',
      'Kształtowanie u uczestników umiejętności pracy w grupie',
      'Kształtowanie u uczestników umiejętności komunikacji i podziału zadań',
    ],

    summary: 'Uczestnicy bez udziału kadry organizują biwak, na który jadą (kadra jedzie jako opieka) i ponoszą wszystkie konsekwencje swoich niedociągnięć.',
    description: '<p style="text-align:justify;">Forma polega na przeprowadzeniu biwaku drużyny (lub zastępu), tyle że z niemal zerowym zaangażowaniem kadry drużyny. Rola kadry powinna się ograniczyć do przeprowadzenia zbiórki, podczas której pomogą ustalić w drużynie (lub zastępie), co trzeba zrobić, by zorganizować biwak oraz pomogą rozdzielić zadania i wybrać spośród uczestników głównego koordynatora biwaku.'
        '<br>'
        '<br>Forma swoje główne walory czerpie z tego, że liczba i poziom skomplikowania problemów, z którymi uczestnicy się zmierzą jest ściśle zależna od tego jak skutecznie zorganizują biwak jako grupa:</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Jeżeli wszyscy zapomną kupić jedzenie - drużyna będzie głodować dwa dni, albo będzie zmuszona załatwić jedzenie na miejscu,</p></li>'
        '<li><p style="text-align:justify;">Jeżeli ktoś pomyli kierunek marszu lub miejsce docelowe - będzie trzeba spać na dworcu lub iść przez noc,</p></li>'
        '<li><p style="text-align:justify;">Jeśli ktoś nie sprawdzi, czy autobus powrotny jeździ także w niedzielę - będzie trzeba łapać stopa, albo iść pieszo.</p></li>'
        '</ul>'
        '<p style="text-align:justify;">Rola kadry sprowadza się przede wszystkim do dwóch kwestii:</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Reagowania tylko i wyłącznie gdy sytuacja będzie groźna dla życia uczestników,</p></li>'
        '<li><p style="text-align:justify;">Podsumowaniu biwaku po jego zakończeniu.</p></li>'
        '</ul>'
);