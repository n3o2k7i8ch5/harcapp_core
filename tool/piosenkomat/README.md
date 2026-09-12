# piosenkomat

Przesiewa mejle z piosenkami na `harcapp@gmail.com`. Kompletne nowe piosenki
trafiają do pliku `.hrcpsng` do wczytania na stronie, a mejle dostają te same
etykiety, których używasz przy ręcznym przeglądaniu, plus znacznik `song/auto`.
Parsowaniem zajmuje się `parseContribEmail` z `harcapp_core`, nic tu nie zgaduje.

## Przebieg krok po kroku

1. **Przesiew.**  
   `./piosenkomat scan -n 20`  
   ####
   Czyta kolejkę (inbox bez `song/*`, po **wątkach** — zgłoszenie to cały
   wątek), parsuje, porównuje z apką i między sobą i zapisuje katalog
   `out/import-<data>/`: `report.txt`, plan etykiet `labels.json`,
   `candidates-new.hrcpsng` (nowe piosenki), `candidates-correction.hrcpsng`
   (poprawki), kopie `reviewed-*.hrcpsng` do podmiany i `people.dart`.
   Przy każdej piosence jadą jej cechy (poprawka? dopisek? stara apka?)
   i uwagi.
   Gmaila tylko czyta — `scan` nigdy niczego nie etykietuje. `-n` pomiń, żeby
   wziąć całą kolejkę; `--newest` bierze najnowsze zamiast najstarszych;
   `-o` wskazuje własny katalog przebiegu.
   ####
2. **Etykiety automatu.**  
   `./piosenkomat label scanned --push`  
   ####
   Wiesza werdykty z `labels.json`: `ready-to-add`, `rejected/…`,
   `needs-review/…`, `old-app/to-reply`, każdy ze znacznikiem `song/auto`.
   Odrzucone od razu oznacza jako przeczytane — nic już od Ciebie nie zależy.  
   Pomija mejle, które w międzyczasie dostały już jakąś etykietę `song/*`.  
   Pomyłka? `./piosenkomat unlabel --push` cofa wszystko, co nadał automat.
   ####
3. **Przegląd na stronie.**  
   *(ręcznie)*  
   ####
   Wczytujesz **jeden** plik naraz na stronie ze śpiewnikiem — najpierw
   `candidates-new.hrcpsng`, potem osobno `candidates-correction.hrcpsng`.
   Nad piosenką: badge POPRAWKA (z tytułem tego, co poprawia), dopiski autora
   i pastylki z uwagami — wszystko tylko do czytania. Poprawiasz, co trzeba,
   wyrzucasz, czego nie chcesz, eksportujesz i podmieniasz eksportem
   odpowiednio `reviewed-new.hrcpsng` albo `reviewed-correction.hrcpsng`.
   **Z kandydatów można wywalać i edytować, nie dodawać.**
   ####
4. **Decyzje z przeglądu.**  
   `./piosenkomat label reviewed --push`  
   ####
   Dwa stany, po id wątku: piosenka **jest** w `reviewed-*` → `ready-to-add`
   (poprawka: + `song/correction`), **nie ma** → `rejected/after-review`
   i przeczytane. Uwagi w piosence nie mają znaczenia — pastylki były dla
   Ciebie. Obca piosenka, zły rodzaj w pliku albo dwie poprawki tej samej
   piosenki → STOP. Brak pliku zwrotnego = tej części jeszcze nie przeglądałeś.
   Bez `--push` tylko pokazuje, co by zrobił.
   ####
5. **Osoby dodające.**
   *(ręcznie)*  
   ####
   Doklejasz `out/import-<data>/people.dart` na koniec `lib/values/people/data.dart`.  
   Po kroku 4, bo dopiero on mówi, czyje piosenki wypadły i kogo nie ma po co dopisywać.
   ####
6. **Piosenki do śpiewnika aplikacji.**  
   `./piosenkomat strip`, potem *(ręcznie)*  
   ####
   `strip` zdejmuje ślad piosenkomatu z `reviewed-*.hrcpsng` → `final-*.hrcpsng`
   gotowe do wklejenia. Poprawki dostają `id` poprawianej piosenki (apka
   referencjonuje piosenki po `lclId` — ulubione, albumy) i listę „co podmienić".
   Zatwierdzone piosenki muszą trafić do `assets/songs/all_songs.hrcpsng` i do
   commita. Dopóki tam nie są, `label added` z kroku 7 kłamie (mejl zamknięty,
   piosenki w apce nie ma), a następny `scan` nie rozpozna ich jako duplikatów.
   ####
7. **Domknięcie mejli.** 
   `./piosenkomat label added --push`  
   ####
   `ready-to-add` + `auto` → `added` i oznaczenie jako przeczytane. Rusza
   wyłącznie mejle, które automat sam wstawił do pliku; Twoje ręczne
   „ready-to-add” zostają nietknięte.

Osobno, kiedy chcesz: `./piosenkomat reply --push` — odpowiedzi autorom ze
starej apki (kolejką jest etykieta, nie katalog przebiegu).

## Setup (raz)

1. Google Cloud: włącz Gmail API, utwórz klienta OAuth typu **Desktop**.
2. Pobrany JSON zapisz jako `tool/piosenkomat/secrets/credentials.json` (katalog jest w `.gitignore`).
3. Pierwsze uruchomienie otworzy przeglądarkę. Zaloguj się na `harcapp@gmail.com`.
   Token ląduje w `tool/piosenkomat/secrets/gmail_token.json`. Zakresy: `gmail.modify`
   (etykiety) i `gmail.send` (odpowiedzi o starej apce). Token bez obu zakresów
   narzędzie odrzuca i prosi o ponowne zalogowanie.

Uruchamiaj z korzenia repo przez `./piosenkomat`. Ścieżki `secrets/` i `out/` są względem `tool/piosenkomat/`.

## Komendy

```bash
./piosenkomat scan -n 20                 # przesiew 20 najstarszych, Gmail tylko czytany
./piosenkomat label scanned              # lista: co by dostało jaką etykietę
./piosenkomat label scanned --push      # nadaje etykiety
./piosenkomat label reviewed --push     # → „rejected/after-review”
./piosenkomat label added --push        # → „added” + przeczytane
./piosenkomat unlabel --push            # cofa wszystko, co nadał automat
./piosenkomat reply                      # kto czeka na „zaktualizuj apkę”
./piosenkomat reply --push              # wyślij; → „old-app/replied”
./piosenkomat explain plik.eml           # klasyfikacja lokalnego pliku, bez Gmaila
```

Bez `--push` nic w Gmailu się nie zmienia — `scan` i `explain` nie mają tej flagi,
bo nie piszą do skrzynki nigdy. Komendy operujące na przebiegu biorą bez argumentu
**ostatni** katalog z `out/`; własny wskażesz, podając go wprost:
`./piosenkomat label scanned out/import-<data> --push`.

`label scanned` nadaje plan także długo po `scan`, bez ponownego czytania mejli.
`unlabel` jest jego odwrotnością. Swoje poznaje po znaczniku `song/auto`, którego
Ty nie wieszasz, więc bez argumentu zdejmuje etykiety automatu z **całej skrzynki** —
także z przebiegów, po których katalog w `out/` już przepadł. Twoje ręczne etykiety
(te bez `auto`) zostają nietknięte.

Uwaga: skoro bierze całą skrzynkę, zdejmie też etykiety starszej paczce, która
czeka jeszcze u Ciebie na przegląd. Jeśli ma ruszyć tylko jeden przebieg, podaj
jego katalog: `./piosenkomat unlabel out/import-<data> --push` — wtedy wypisze przy
okazji, ile mejli z `song/auto` siedzi poza tym planem.

Mejli domkniętych przez `label added` nie rusza: piosenka jest już w apce, a zdjęcie
etykiet wepchnęłoby ją z powrotem do kolejki. Nie zdejmuje też `old-app/replied` —
to jedyny ślad, że autor już dostał odpowiedź; bez niego wróciłby do kolejki
`to-reply` i dostał drugą. `--force`, żeby i one zeszły.

Stare nazwy (`process`, `apply`, `review`, `commit`, `unapply`, `check`) oraz flagi
`--write` i `--apply` dalej działają jako ciche aliasy, ale nie ma ich w pomocy. Wyjątek:
`process --apply` już nie etykietuje po przesiewie — `scan` Gmaila tylko czyta,
etykiety nadaje osobny `label scanned --push`.

## Stara apka (`reply`)

Najstarsza, już nierozwijana wersja apki wysyła mejle w innym formacie: temat
`Piosenka "X"`, JSON owinięty w `{"o!_id": {…}}`, bez zgody na regulamin, bo
regulaminu jeszcze nie było. Treść piosenki bywa kompletna, więc **sam stary
format nie blokuje importu** — `contributor_data` dostaje wtedy wersję regulaminu
`brak (stara apka)` (do wygrepowania, gdybyś chciał doprosić o zgodę), a mejl
dodatkowo etykietę `song/old-app/to-reply`.

Ta etykieta jest kolejką odpowiedzi i jedynym źródłem prawdy o tym, komu jeszcze
nie odpisano — stąd `reply` nie bierze żadnego katalogu ani listy. Wysyłka zdejmuje
`to-reply` i wiesza `old-app/replied`, więc nikt nie dostanie dwóch odpowiedzi,
a przerwany przebieg dokańcza się powtórzeniem komendy. Jedna odpowiedź na autora,
nie na mejl: kto przysłał pięć piosenek, dostaje jeden mejl w najnowszym wątku,
a etykieta schodzi ze wszystkich pięciu. Treść to `oldestFormatReplyMessage`
z `harcapp_core`. `-n` ogranicza liczbę autorów w przebiegu (Gmail tnie wysyłkę
ok. 500 mejli na dobę).

Etykietę można ruszać ręcznie: zdjęta znaczy „nie zawracaj mu głowy”, dowieszona
wsadza kogoś z powrotem do kolejki.

## Etykiety

```
song/
├── ready-to-add              w pliku, czeka na domknięcie (albo Twoja ręczna)
├── added                     koniec
├── correction                ZNACZNIK: zgłoszenie to poprawka — wgrywasz podmianą, nie dodaniem
├── unparsable                nie dało się sparsować; poza needs-review, nieprzeczytane,
│                             etykieta tylko po to, żeby mejl nie wracał do `scan`
├── add-contributor           „wpisać osobę dodającą do apki”, tylko Ty
├── rejected/
│   ├── already-in-app        automat: piosenka IDENTYCZNA (każde pole) z tą w apce
│   ├── duplicate             automat: identyczna z nowszym zgłoszeniem w paczce
│   ├── after-review          automat zaproponował, Ty wyrzuciłeś na stronie (`label reviewed`)
│   ├── no-chords             tylko Ty
│   ├── silly                 tylko Ty (kiedyś LLM)
│   └── too-niche             tylko Ty (kiedyś LLM)
├── needs-review/             automat spasował; podkategoria na każdy powód
│   ├── user-message          ktoś coś dopisał
│   ├── identical-in-app      identyczna z apką, ale autor coś dopisał albo zadeklarował
│   │                         poprawkę — piosenki nie ma w pliku, sam mejl do przeczytania
│   ├── duplicate-in-app      ten sam tytuł / podobny tekst do piosenki w apce
│   ├── duplicate-in-batch    kolizja z innym zgłoszeniem z tej samej paczki
│   ├── undeclared-correction ta sama piosenka co w apce, inne chwyty albo drobiazgi —
│   │                         ktoś poprawił i wysłał jako nową
│   ├── correction-problem    poprawka, ale w apce nie ma czego poprawiać
│   ├── missing-data          brak YouTube, chwytów lub tytułu
│   └── no-consent            brak zgody albo nie wiadomo, kto zgłosił
├── old-app/                  ZNACZNIK: mejl z najstarszej, nierozwijanej apki
│   ├── to-reply              kolejka: autorowi trzeba odpisać (`reply`)
│   └── replied               odpowiedź poszła
└── auto                      ZNACZNIK: tę etykietę stanu nadał automat
```

Zasady:

- Kolejka to zgłoszenia piosenek (temat `Nowa piosenka` / `Poprawka piosenki` albo
  `### Kod piosenki:` w treści) w `in:inbox` bez żadnej etykiety `song/*` — liczonej
  **po wątku**: odpowiedź w wątku, który już dostał etykietę, nie jest nowym
  zgłoszeniem. Innych mejli narzędzie nie czyta i nie etykietuje. Gmail jest jedynym stanem.
- **Zgłoszenie = wątek.** Reprezentantem jest najnowsza wiadomość z własnym kodem
  piosenki (nie z cytatu) od nadawcy ≠ skrzynka HarcApp; gdy takiej nie ma poza
  pierwszą — pierwsza. Pozostałe wiadomości wątku to dopiski. Etykiety idą na
  wszystkie wiadomości wątku.
- `song/auto` zawsze towarzyszy jednej etykiecie stanu. Twoje decyzje to te bez `Auto`.
- **Identyczna** znaczy: każde pole dosłownie równe (tytuł, tekst, chwyty,
  YouTube, autorzy, wykonawcy, tagi…). Taka piosenka **nigdy nie idzie do
  pliku**: bez sygnału od człowieka → `rejected/already-in-app`; z dopiskiem
  albo jako poprawka → `needs-review/identical-in-app`, sam mejl, nieprzeczytany.
  W paczce z grupy identycznych zostaje najnowsza, reszta → `rejected/duplicate`.
- Wszystko mniej niż identyczne idzie do pliku (`candidates-new` albo
  `candidates-correction`) — bez uwag → `ready-to-add`, z uwagami → `needs-review`
  plus podkategoria na każdą uwagę. Poprawki nie dostają `missing-*`.
- Przeczytane oznaczamy tam, gdzie sprawa jest zamknięta: `added` i każde
  `rejected/*`. `needs-review/*`, `unparsable` i `old-app/to-reply` zostają
  nieprzeczytane — czekają na Twoją decyzję, Twoje oko albo odpowiedź.
- `label added` dotyka wyłącznie mejli z `ready-to-add` **i** `auto`. Twoje ręczne
  „ready-to-add” czekają na Ciebie jak dotąd.

Przydatne zapytania:

| Co | Zapytanie |
|---|---|
| wszystko, co rozpatrzył automat | `label:song/auto` |
| dodane przez automat | `label:song/added label:song/auto` |
| dodane przez Ciebie | `label:song/added -label:song/auto` |
| automatyczne odrzucenia do wyrywkowej kontroli | `label:song/rejected label:song/auto` |
| pudła automatu (zaproponował, a odpadło) | `label:song/rejected/after-review` |

## Cechy, uwagi, decyzja

Każde zgłoszenie przechodzi trzy kroki, każdy z osobną strukturą
(uzasadnienia w `PLAN.md`):

1. **Cechy** — same fakty, zero ocen: `kind` (`new` / `correction` — z tematu
   albo niepustego bloku „Propozycja poprawki”), `source` (`current-app` /
   `old-app`), `userMessage`, `correctionMessage`, `sentAt`, nadawca, zgoda,
   sparsowana piosenka, `appMatch` (najbliższa piosenka w apce), `batchMatch`
   (najbliższe inne zgłoszenie w paczce).
2. **Decyzja** — jedna tabela `decide(cechy)`: dokąd trafia zgłoszenie
   (`candidates-new` / `candidates-correction` / odrzut / sam mejl /
   niesparsowalne) i jakie uwagi dostaje.
3. **Uwagi** — tylko dla tego, co idzie do pliku. Osąd o piosence, nie fakt
   o zgłoszeniu; identyczność nie jest uwagą, bo identyczna nigdy nie trafia
   do pliku.

| uwaga | waga | `new` | `correction` |
|---|---|---|---|
| `missing-title`, `missing-chords`, `missing-youtube` | blocking | ✓ | — (poprawka to diff) |
| `no-consent`, `no-contributor-email` | blocking | ✓ | ✓ |
| `chords-differ-from-app`, `metadata-differ-from-app` | decision | ✓ | — |
| `same-title-in-app`, `similar-text-in-app` | decision | ✓ | — (normalny kształt poprawki) |
| `same-title-in-batch`, `similar-text-in-batch` | decision | ✓ | zapasowo, gdy nie ma celu |
| `same-target-in-batch` | decision | — | ✓ (dwie poprawki tej samej piosenki) |
| `no-target-in-app` | decision | — | ✓ |
| `has-user-message` | decision | ✓ | ✓ (tylko `userMessage`; blok poprawki jest oczekiwany) |

Waga to **kolor pastylki** w edytorze — czerwona „bez tego nie powinno wejść”,
pomarańczowa „zdecyduj”. **Pastylki są dla Ciebie, nie dla piosenkomatu**:
narzędzie po przeglądzie ich nie czyta. Zrobiłeś przegląd, piosenka jest
w pliku — wchodzi.

Stara apka: `consentVersion` dostaje sentinel `brak (stara apka)`, bez
`no-consent` — regulaminu jeszcze nie było. Brak chwytów czy YouTube blokuje
tak samo w każdej wersji apki — automat niczego nie dopisuje za autora.

Wszystko jedzie w polu `piosenkomat` piosenki (obok `tags`, ale to nie tagi —
tagi widzi użytkownik apki):

```json
"piosenkomat": {
  "kind": "correction", "source": "old-app", "sent_at": "…",
  "user_message": "…", "correction_message": "…",
  "correction_target": "o!_plonie_ognisko",
  "thread_id": "17a6…", "run": "import-…",
  "issues": [{"issue": "no-consent"}]
}
```

`correction_target` — którą piosenkę w apce poprawia — jest **zgadywany**
po tytule/tekście, bo mejl z apki tego nie niesie (apka powinna kiedyś
dokładać `### Poprawiana piosenka: <lclId>`). Pole nigdy nie jedzie do
`all_songs.hrcpsng`: `toApiJsonMap` wypuszcza je tylko na życzenie narzędzia,
a `strip` zdejmuje je przed wgraniem.

## Podobieństwo

Porównanie dwóch piosenek to **lista dowodów**, każdy mówi co i jak bardzo:
`SameTitle` (po normalizacji jak w wyszukiwarce, także `hid_titles`),
`SameText` (tekst dosłownie równy po zbiciu białych znaków), `TextOverlap`
(Jaccard zbiorów słów — nie widzi kolejności zwrotek ani interpunkcji),
`SameChords` (wielkość liter zostaje, `a` ≠ `A`), `MetadataDiff` (które
z: tytuł dosłownie, ukryte tytuły, autorzy, kompozytorzy, wykonawcy, data,
YouTube, tagi się różnią; `null == []`).

Wniosek to reguła nad listą, progi 90% i 50%:

| poziom | reguła | `new` → | `correction` → |
|---|---|---|---|
| `identical` | `SameText ∧ SameChords ∧ ¬MetadataDiff` — **każde pole równe** | `rejected/already-in-app`; z dopiskiem → `needs-review/identical-in-app` | `needs-review/identical-in-app` (poprawka, która nic nie zmienia) |
| `sameSong` | tytuł, tekst ≥ 90%, chwyty, ale coś inne | uwaga `metadata-differ-from-app` | kandydat bez uwagi |
| `sameTextDifferentChords` | tytuł, tekst ≥ 90%, inne chwyty | uwaga `chords-differ-from-app` | kandydat |
| `sameTitleDifferentText` | ten sam tytuł, tekst < 90% | uwaga `same-title-in-app` | kandydat |
| `similarText` | inny tytuł, tekst ≥ 50% | uwaga `similar-text-in-app` | kandydat (cel zgadnięty po tekście) |
| brak | — | czysty kandydat | uwaga `no-target-in-app` |

**W paczce** zgłoszenia grupują się po kluczu zależnym od rodzaju: nowe po
tytule, poprawki po `correction_target` (poprawka może zmieniać tytuł).
W grupie identyczne zlewają się do **najnowszej** (reszta →
`rejected/duplicate`), wszystko mniej niż identyczne idzie do pliku z uwagą
`same-title-in-batch` / `same-target-in-batch`. Poza grupami, parami:
`similarText` między różnymi tytułami → `similar-text-in-batch`. Duplikat
z innego przebiegu wyjdzie dopiero, gdy pierwsza wersja będzie w `all_songs`.

## Przegląd (`label reviewed`) i `strip`

`scan` obok `candidates-*.hrcpsng` zostawia ich kopie jako
`reviewed-*.hrcpsng`. Wczytujesz jeden plik na stronę, przeglądasz,
eksportujesz i podmieniasz nim odpowiedni `reviewed-*`. Dwa stany, po id
wątku:

| w `reviewed-*.hrcpsng` | mejl dostaje |
|---|---|
| jest | `ready-to-add` (poprawka: + `song/correction`) |
| nie ma jej | `rejected/after-review`, przeczytane |

Uwagi w piosence nie mają znaczenia. Brak pliku zwrotnego danego rodzaju =
tej części jeszcze nie przeglądałeś. Ślad decyzji w `decisions.json`.

**Z kandydatów można wywalać i edytować, nie dodawać.** Piosenka spoza
kandydatów (obcy `thread_id`), zły rodzaj w pliku (poprawka w `reviewed-new`)
albo dwie zachowane poprawki tej samej piosenki → **STOP**, bez `--force`.
Bezpieczniki z `--force`: pusty plik, odrzucona ponad połowa.

Piosenki wiąże ze zgłoszeniami `thread_id` (w `piosenkomat` i zapasowo
w `contributor_data.email_thread_id`). Gdyby oba zginęły, `label reviewed`
schodzi po kolei na id piosenki, tytuł i tekst.

`./piosenkomat strip` zdejmuje pole `piosenkomat` z `reviewed-*` →
`final-*.hrcpsng` do wklejenia w `all_songs`. Przy poprawkach ustawia
`id = correction_target` — apka referencjonuje piosenki po `lclId` (ulubione,
albumy, oceny), więc poprawiony tytuł nie może zmienić id — i wypisuje listę
„co podmienić”. Samo wgranie do `all_songs` robisz ręcznie.

## Osoby dodające

W katalogu przebiegu, obok plików z piosenkami, powstaje `people.dart` z gotowymi stałymi `RegisteredContributor`
w kształcie `lib/values/people/data.dart`, tylko dla osób, których tam jeszcze nie ma
(sprawdzane po adresie). Adres nadawcy jest zawsze pierwszy w `emails`, bo to on siedzi
w `email_ref` piosenki i po nim `ContributorRef.resolve()` znajduje osobę. Doklejasz
plik na koniec `data.dart`, `data.all.g.dart` przegeneruje pre-commit. Rób to po
`label reviewed` — wypisuje on adresy osób, którym wszystkie piosenki wypadły przy
przeglądzie, więc nie ma po co ich dopisywać.

W komentarzach na końcu pliku: nadawcy już obecni w `data.dart` oraz piosenki bez bloku
„Osoba dodająca” (te mają tylko `email_ref`, nie ma kogo dopisać).

## Dev

Parser ciągnie `SongRaw`, a ten Fluttera, więc `dart run` nie działa. `./piosenkomat`
odpala pod spodem `flutter test test/cli_harness.dart`, stąd prefiks `Shell:`
w wyjściu. Testy: `flutter test` w `tool/piosenkomat`.
