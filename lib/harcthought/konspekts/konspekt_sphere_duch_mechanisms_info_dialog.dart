import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';

import 'konspekt.dart';

class KonspektSphereDuchMechanismsInfoDialog extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: BorderRadius.circular(AppCard.bigRadius),
    clipBehavior: Clip.hardEdge,
    color: background_(context),
    child: Scaffold(
        appBar: AppBarX(
          title: 'Mechanizmy duchowości',
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: iconEnab_(context)),
          titleTextStyle: AppTextStyle(
              color: iconEnab_(context),
              fontSize: Dimen.textSizeAppBar
          ),
        ),
        body: SelectionArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimen.sideMarg - Dimen.defMarg),
            children: [
              TitleShortcutRowWidget(
                  title: KonspektSphereMechanism.duchBezposrednia.displayName,
                  textAlign: TextAlign.left
              ),

              const AppText(
                  'Bezpośrednie formy duchowe to te realizujące aksjomaty duchowe lub je kształtujące - np. doświadczenie piękna, modlitwa, refleksja, doświadczenie duchowe, doświadczanie relacji z Bogiem, etc..'
              ),

              const SizedBox(height: Dimen.sideMarg),

              TitleShortcutRowWidget(
                  title: KonspektSphereMechanism.duchNormalizacja.displayName,
                  textAlign: TextAlign.left
              ),

              const AppText(
                  'Normalizacja jest mechanizmem stopniowego włączania wybranej postawy, wartości, aksjomatu czy poglądu do domeny spraw uznawanych za normalne.'
                      '\n'
                      '\nNormalizacja może odbywać się na różnych płaszczyznach:'
                      '\n'
                      '\nW przypadku przekonania, że duchowość innych ludzi zawiera jakiś element duchowości (np. to, że każdy obchodzi swoje urodziny) mowa o <b>normie powszechnej</b>.'
                      '\n'
                      '\nW przypadku elementu własnej duchowości, którego słuszność nie jest poddawana w wątpliwość, nawet mimo świadomości, że nie jest ona powszechna (np. nie jedzenie mięsa w piątek), mowa o <b>normie własnej</b>.'
                      '\n'
                      '\nNormalizacja elementów duchowości u harcerzy nie oznacza, że zostaną one przez nich zinternalizowane. Pomaga ona jednak obniżyć barierę jej późniejszej internalizacji'
              ),

              const SizedBox(height: Dimen.sideMarg),

              TitleShortcutRowWidget(
                  title: KonspektSphereMechanism.duchHartDucha.displayName,
                  textAlign: TextAlign.left
              ),

              const AppText(
                  'Hart ducha jest potocznym określeniem na zdolność ponoszenia wyrzeczeń i działaniu wbrew imperatywom takim jak komfort, opinia społeczna, chwilowe emocje itd.. Zdolność ta jest kluczowa w procesie rozwoju duchowego.'
                      '\n'
                      '\nHartowanie ducha skutkuje szeregiem zjawisk:'
                      '\n- Budowaniu silnej woli.'
                      '\n- Budowaniu przekonania, że są w życiu sprawy ważniejsze od wygody.'
                      '\n- Budowaniu poczucia elitarności wspólnoty, w ramach której podejmowane są wyzwania.'
                      '\n'
                      '\nNależy mieć na uwadze, że kształtowanie hartu ducha w sposób szokowy może prowadzić do lęku przed nowością, czy nawet traumą. Formy te mają walor rozwojowy <b>przede wszystkim, jeżeli harcerz dobrowolnie się ich podejmie</b>.'
                      '\n'
                      '\nDobrowolność ta nie oznacza, że jakakolwiek praktyka trudności musi wymagać każdorazowej zgody harcerza. Wystarczy, jeśli harcerze będą mogli poprosić o nieuczestniczenie w formie. Formy hartu ducha można (a nawet należy) proponować jako domyślne działanie drużyny, można także korzystać przy tym ze wzajemności oddziaływań (harcerz prędzej zgodzi się pełnić wartę nocną jeżeli pozostali członkowie drużyny ją regularnie pełnią).'
                      '\n'
                      '\nPytanie harcerzy przy każdej formie <i>"czy ktoś nie chce uczestniczyć"</i>, lub <i>"czy na pewno każdy czuje się z tą formą okej?"</i> może być kontr-wychowawcze. Sugeruje to bowiem, że chcenie i chwilowe odczucia harcerza są najważniejszymi kryteriami którymi powinien się kierować.'
              ),

              const SizedBox(height: Dimen.sideMarg),

              TitleShortcutRowWidget(
                  title: KonspektSphereMechanism.duchKsztaltowanieUwaznosci.displayName,
                  textAlign: TextAlign.left
              ),

              const AppText(
                  'Kształtowanie uważności jest procesem osiąganym przez wyciszenie: eliminację zewnętrznych bodźców, eliminację informacji których harcerz i tak nie może wykorzystać, redukcję częstości zmiany kontekstu uwagi.'
                      '\n\nFormy kształtowania uważności mają przede wszystkim walor wzmacniania skuteczności innych form duchowych. Pozwala to skupić uwagę harcerza na tym, co wewnętrzne i co znajduje się w jego bezpośrednim otoczeniu. Pozwala także lepiej doświadczyć efektów innych form.'
                      '\n\nFormy te immanentnie wpływają na hierarchię wartości harcerza: dewaluują znaczenie mediów społecznościowych, gier elektronicznych, czy Internetu podnosząc w zamian ważność refleksji, kontaktu z człowiekiem, modlitwy, uporządkowania, wewnętrznego spokoju itd..'
              ),

              const SizedBox(height: Dimen.sideMarg),

              TitleShortcutRowWidget(
                  title: KonspektSphereMechanism.duchOtwartoscNaLudzi.displayName,
                  textAlign: TextAlign.left
              ),

              const AppText(
                  'Duchowość jest domeną ludzi, przez co mechanizmy jej kształtowania są związane ze sferą relacji ludzkich (sfera społeczną). Otwartość na ludzi jest cechą umożliwiającą rozwój duchowy w wielu przestrzeniach. Jej kształtowanie buduje przekonanie i nawyk dobrego i bliskiego funkcjonowania z drugim człowiekiem (i w grupie ludzi), umiejętność negocjowania i kształtowania relacji itd..'
              ),

              const SizedBox(height: Dimen.sideMarg),

              TitleShortcutRowWidget(
                  title: KonspektSphereMechanism.duchWartoscWtorna.displayName,
                  textAlign: TextAlign.left
              ),

              const AppText(
                  'Mechanizm wtórnej internalizacji wartości opiera się na wykorzystaniu niedojrzałości rozwoju duchowego. O ile w procesie rozwoju duchowego człowiek dąży do działań zgodnych ze swoimi wartościami, o tyle wartości wtórne są uznaniem czegoś za ważne, ponieważ jest się w tym dobrym.'
                      '\n'
                      '\nObrazowo: <i>"szachy są ważne, bo mam talent szachowy"</i>.'
                      '\n'
                      '\nMechanizm ten można wykorzystywać szczególnie w początkowej fazie rozwoju duchowego - zdobywanie kompetencji w danej dziedzinie pośrednio sprawia, że harcerze chętniej poświęcą jej w przyszłości swoją uwagę i chętniej uznają ją za znaczącą.'
              ),

              const SizedBox(height: Dimen.sideMarg),

            ],
          ),
        )
    ),
  );

}

void openKonspektSphereDuchMechanismsInfoDialog(
    BuildContext context,
    {double? maxWidth}
) => showDialog(
    context: context,
    builder: (context) {

      Widget child = Padding(
        padding: const EdgeInsets.all(Dimen.defMarg),
        child: KonspektSphereDuchMechanismsInfoDialog()
      );

      if(maxWidth == null)
        return Center(child: child);
      else
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        );

    }
);