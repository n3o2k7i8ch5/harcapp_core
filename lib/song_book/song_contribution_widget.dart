import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/values/dimen.dart';

class SongContributionWidget extends StatelessWidget{

  const SongContributionWidget({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    padding: EdgeInsets.all(Dimen.sideMarg),
    child: AppText(
      '<b>1. Kontrybucja</b>'
          '\nŚpiewnik aplikacji HarcApp jest tworzony przez użytkowników, dla użytkowników. Każdy użytkownik może dodać swoją piosenkę, która będzie widoczna dla innych użytkowników.'
          '\n'
          '\n<b>2. Przesyłanie piosenek</b>'
          '\nKażdy użytkownik może przesłać swoją piosenkę do śpiewnika aplikacji HarcApp w formacie .hrcpsng na adres e-mail: <b>harcapp@gmail.com</b>.'
          '\n'
          '\n<b>3. Weryfikacja piosenek</b>'
          '\nKażda piosenka po przesłaniu, jest weryfikowana przez zespół HarcApp. Weryfikacja obejmuje sprawdzenie poprawności formatu, treści oraz zgodności z wartościami harcerskimi.'
          '\n'
          '\n<b>4. Zgłaszanie uwag i poprawek</b>'
          '\nUżytkownicy mogą zgłaszać uwagi i poprawki do przesłanych piosenek swoich lub cudzych na adres e-mail: <b>harcapp@gmail.com</b>. Zgłoszenie może zostać dokonane w postaci opisu uwagi lub w postaci przesłania poprawionej wersji piosenki. Zgłoszenia są rozpatrywane przez zespół HarcApp.'
          '\n'
          '\n<b>5. Czas rozpatrywania zgłoszeń</b>'
          '\nAplikacja HarcApp, w tym także jej śpiewnik, jest tworzona przez wolontariuszy pracujących "po godzinach". Zespół HarcApp nie jest w stanie każdorazowo zagwarantować szybkiej odpowiedzi na złoszenia. Dołożone są wszelkie starania, by zgłoszenia były sukcesywnie obsługiwane.'
          '\n'
          '\n<b>6. Prawa autorskie</b>'
          '\nPrzesyłając piosenkę do śpiewnika aplikacji HarcApp, użytkownik oświadcza, że jest jej autorem lub posiada prawa do jej publikacji. Użytkownik wyraża zgodę na publikację piosenki w aplikacji HarcApp oraz na jej udostępnianie innym użytkownikom. W przypadku stwierdzenia naruszenia praw autorskich, zespół HarcApp zastrzega sobie prawo do usunięcia piosenki ze śpiewnika.'
          '\n'
          '\n<b>7. Naruszenia praw autorskich</b>'
          '\nW przypadku stwierdzenia naruszenia praw autorskich, zespół HarcApp zastrzega sobie prawo do usunięcia piosenki ze śpiewnika. Naruszenia praw autorskich mogą być zgłaszane na adres e-mail: <b>harcapp@gmail.com</b><b>',
      size: Dimen.textSizeBig,
      height: 1.2,
    ),
  );


}