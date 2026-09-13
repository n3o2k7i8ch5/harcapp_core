# piosenkomat

Przesiewa mejle z piosenkami na `harcapp@gmail.com`. Kompletne nowe piosenki
trafiają do pliku `.hrcpsng` do wczytania na stronie, a mejle dostają te same
etykiety, których używasz przy ręcznym przeglądaniu, plus znacznik `song/auto`.
Parsowaniem zajmuje się `parseContribEmail` z `harcapp_core`, nic tu nie zgaduje.
Gmail jest jedynym stanem.

## Setup (raz)

1. Google Cloud: włącz Gmail API, utwórz klienta OAuth typu **Desktop**.
2. Pobrany JSON zapisz jako `tool/piosenkomat/secrets/credentials.json` (katalog jest w `.gitignore`).
3. Pierwsze uruchomienie otworzy przeglądarkę. Zaloguj się na `harcapp@gmail.com`.
   Token ląduje w `tool/piosenkomat/secrets/gmail_token.json`. Zakresy: `gmail.modify`
   (etykiety) i `gmail.send` (odpowiedzi o starej apce). Token bez obu zakresów
   narzędzie odrzuca i prosi o ponowne zalogowanie.

Uruchamiaj z korzenia repo przez `./piosenkomat`. Ścieżki `secrets/` i `out/` są względem `tool/piosenkomat/`.

## Przebieg

1. **Przesiew.**  
   `./piosenkomat scan -n 20`  
   ####
   Czyta kolejkę, parsuje, porównuje z apką i między sobą, zapisuje katalog
   `out/import-<data>/`: 
   - `report.txt`,
   - `labels.json`,
   - `candidates-new.hrcpsng`,
   - `candidates-correction.hrcpsng`,
   - kopie `reviewed-*.hrcpsng`,
   - `people.dart`.  
   ####
   [Jak automat decyduje](#jak-automat-decyduje).
   ####
2. **Etykiety automatu.**  
   `./piosenkomat label scanned --push`  
   ####
   Wrzyca labele z `labels.json` na Gmaila. Pomija mejle, które w międzyczasie dostały już jakąś etykietę `song/*`. Pomyłka → `unlabel --push`.
   ####
3. **Przegląd na stronie.**  
   *(ręcznie)*  
   ####
   Wczytujesz **jeden** plik naraz: najpierw:
   - `candidates-new.hrcpsng`, potem osobno
   - `candidates-correction.hrcpsng`.  
   Poprawiasz, wyrzucasz, eksportujesz i podmieniasz eksportem odpowiednio: 
   - `reviewed-new.hrcpsng` albo 
   - `reviewed-correction.hrcpsng`.
   ####
   **Wywalać i edytować, nie dodawać.**
   ####
4. **Decyzje z przeglądu.**  
   `./piosenkomat label reviewed --push`  
   ####
   Piosenka **jest** w `reviewed-*` → `ready-to-add`; 
   **nie ma** → `rejected/after-review`.
   ####
   Szczegóły i warunki STOP → [Przegląd i strip](#przegląd-i-strip).
   ####
5. **Osoby dodające.**  
   *(ręcznie)*  
   ####
   Doklejasz `out/import-<data>/people.dart` na koniec `lib/values/people/data.dart`.
   Po kroku 4, bo dopiero on mówi, czyje piosenki wypadły → [Osoby dodające](#osoby-dodające).
   ####
6. **Piosenki do śpiewnika.**  
   `./piosenkomat strip` (usunięcie z pliku .hrcpsng metadanych piosenkomatu), potem *(ręcznie)*  
   ####
   `reviewed-*.hrcpsng` → `final-*.hrcpsng` bez śladu piosenkomatu; wklejasz do
   `assets/songs/all_songs.hrcpsng` i commitujesz. Dopóki tam nie są, `label added`
   kłamie (mejl zamknięty, piosenki w apce nie ma), a następny `scan` nie
   rozpozna ich jako duplikatów.
   ####
7. **Domknięcie mejli.**  
   `./piosenkomat label added --push`  
   ####
   `ready-to-add` + `auto` → `added`, przeczytane. Twoje ręczne `ready-to-add`
   (bez `auto`) zostają nietknięte.

Osobno, kiedy chcesz: `./piosenkomat reply --push` — odpowiedzi autorom ze
starej apki → [Stara apka](#stara-apka-reply).

## Komendy

| komenda | co robi | Gmail |
|---|---|---|
| `scan [-n N] [--newest] [-o KATALOG]` | przesiew N najstarszych (bez `-n` — całej kolejki; `--newest` — najnowszych) | czyta |
| `explain plik.eml` | klasyfikacja lokalnego pliku | nie dotyka |
| `label scanned [KATALOG]` | pokazuje plan etykiet z `labels.json` | czyta |
| `label reviewed [KATALOG]` | pokazuje decyzje z `reviewed-*` | czyta |
| `label added [KATALOG]` | pokazuje, co domknie | czyta |
| `unlabel [KATALOG]` | pokazuje, co cofnie | czyta |
| `reply [-n N]` | kto czeka na „zaktualizuj apkę” | czyta |
| `strip [KATALOG]` | `reviewed-*` → `final-*` | nie dotyka |
| `… --push` | wykonuje to, co bez flagi tylko pokazał | **pisze** |

Komendy na przebiegu bez `KATALOG` biorą **ostatni** z `out/`.

`unlabel` cofa wszystko, co nadał automat — poznaje po `song/auto`, którego Ty nie
wieszasz. Bez katalogu czyści **całą skrzynkę**, także przebiegi, po których `out/`
już przepadł — i także paczkę, która czeka jeszcze u Ciebie na przegląd; jeśli ma
ruszyć jeden przebieg, podaj katalog (wypisze, ile mejli z `auto` siedzi poza nim).
Nie rusza `added` (piosenka jest w apce, zdjęcie etykiet wepchnęłoby ją z powrotem
do kolejki) ani `old-app/replied` (jedyny ślad, że autor dostał odpowiedź) — `--force`,
żeby i one zeszły.

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
├── needs-review/             automat spasował; podkategoria na każdą uwagę
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

- **Kolejka** to zgłoszenia piosenek (temat `Nowa piosenka` / `Poprawka piosenki`
  albo `### Kod piosenki:` w treści) w `in:inbox` bez żadnej etykiety `song/*`,
  liczonej **po wątku**. Innych mejli narzędzie nie czyta i nie etykietuje.
- **Zgłoszenie = wątek.** Reprezentantem jest najnowsza wiadomość z własnym kodem
  piosenki (nie z cytatu) od nadawcy ≠ skrzynka HarcApp; gdy takiej nie ma poza
  pierwszą — pierwsza. Pozostałe wiadomości to dopiski. Etykiety idą na cały wątek.
- `song/auto` zawsze towarzyszy jednej etykiecie stanu. Twoje decyzje to te bez `auto`.
- **Przeczytane** = sprawa zamknięta: `added` i każde `rejected/*`. `needs-review/*`,
  `unparsable` i `old-app/to-reply` zostają nieprzeczytane.

| Co | Zapytanie |
|---|---|
| wszystko, co rozpatrzył automat | `label:song/auto` |
| dodane przez automat | `label:song/added label:song/auto` |
| dodane przez Ciebie | `label:song/added -label:song/auto` |
| automatyczne odrzucenia do wyrywkowej kontroli | `label:song/rejected label:song/auto` |
| pudła automatu (zaproponował, a odpadło) | `label:song/rejected/after-review` |

## Jak automat decyduje

Trzy kroki, każdy z osobną strukturą: **cechy** (fakty o zgłoszeniu) →
**decyzja** (jedna tabela `decide(cechy)`: dokąd trafia i jakie uwagi) →
**uwagi** (osąd o piosence, tylko dla tego, co idzie do pliku).

**Cechy**: `kind` (`new` / `correction` — z tematu albo niepustego bloku
„Propozycja poprawki”), `source` (`current-app` / `old-app`), `userMessage`,
`correctionMessage`, `sentAt`, nadawca, zgoda, sparsowana piosenka, `appMatch`
(najbliższa piosenka w apce), `batchMatch` (najbliższe inne zgłoszenie w paczce).

### Podobieństwo

Porównanie dwóch piosenek to lista dowodów: `SameTitle` (po normalizacji jak
w wyszukiwarce, także `hid_titles`), `SameText` (dosłownie równy po zbiciu białych
znaków), `TextOverlap` (Jaccard zbiorów słów — nie widzi kolejności zwrotek ani
interpunkcji), `SameChords` (`a` ≠ `A`), `MetadataDiff` (które z: tytuł dosłownie,
ukryte tytuły, autorzy, kompozytorzy, wykonawcy, data, YouTube, tagi się różnią;
`null == []`). Wniosek to reguła nad listą, progi 90% i 50%:

| poziom | reguła | `new` → | `correction` → |
|---|---|---|---|
| `identical` | `SameText ∧ SameChords ∧ ¬MetadataDiff` — **każde pole równe** | `rejected/already-in-app`; z dopiskiem → `needs-review/identical-in-app` | `needs-review/identical-in-app` (poprawka, która nic nie zmienia) |
| `sameSong` | tytuł, tekst ≥ 90%, chwyty, ale coś inne | uwaga `metadata-differ-from-app` | kandydat bez uwagi |
| `sameTextDifferentChords` | tytuł, tekst ≥ 90%, inne chwyty | uwaga `chords-differ-from-app` | kandydat |
| `sameTitleDifferentText` | ten sam tytuł, tekst < 90% | uwaga `same-title-in-app` | kandydat |
| `similarText` | inny tytuł, tekst ≥ 50% | uwaga `similar-text-in-app` | kandydat (cel zgadnięty po tekście) |
| brak | — | czysty kandydat | uwaga `no-target-in-app` |

**Identyczna nigdy nie idzie do pliku** — to jedyny przypadek, gdzie automat sam
odrzuca. Wszystko mniej niż identyczne idzie do `candidates-new` albo
`candidates-correction`: bez uwag → `ready-to-add`, z uwagami → `needs-review`
plus podkategoria na każdą uwagę.

**W paczce** zgłoszenia grupują się po kluczu zależnym od rodzaju: nowe po tytule,
poprawki po `correction_target` (poprawka może zmieniać tytuł). W grupie identyczne
zlewają się do **najnowszej** (reszta → `rejected/duplicate`), mniej niż identyczne
idą do pliku z uwagą `same-title-in-batch` / `same-target-in-batch`. Poza grupami,
parami: `similarText` między różnymi tytułami → `similar-text-in-batch`. Duplikat
z innego przebiegu wyjdzie dopiero, gdy pierwsza wersja będzie w `all_songs`.

### Uwagi

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
pomarańczowa „zdecyduj”. Pastylki są dla Ciebie: po przeglądzie narzędzie ich nie
czyta; piosenka jest w `reviewed-*` — wchodzi. Automat niczego nie dopisuje za
autora, więc brak chwytów czy YouTube blokuje w każdej wersji apki.

### Pole `piosenkomat`

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
po tytule/tekście, bo mejl z apki tego nie niesie (apka powinna kiedyś dokładać
`### Poprawiana piosenka: <lclId>`). Pole nigdy nie jedzie do `all_songs.hrcpsng`:
`toApiJsonMap` wypuszcza je tylko na życzenie narzędzia, a `strip` zdejmuje je
przed wgraniem.

## Przegląd i `strip`

`label reviewed` porównuje `candidates-*` z `reviewed-*` po id wątku
(`thread_id` w `piosenkomat`, zapasowo `contributor_data.email_thread_id`; gdyby
oba zginęły — po kolei id piosenki, tytuł, tekst):

| w `reviewed-*.hrcpsng` | mejl dostaje |
|---|---|
| jest | `ready-to-add` (poprawka: + `song/correction`) |
| nie ma jej | `rejected/after-review`, przeczytane |

Brak pliku zwrotnego danego rodzaju = tej części jeszcze nie przeglądałeś. Ślad
decyzji w `decisions.json`.

**STOP** (bez wyjścia przez `--force`): piosenka spoza kandydatów (obcy `thread_id`),
zły rodzaj w pliku (poprawka w `reviewed-new`), dwie zachowane poprawki tej samej
piosenki. **Bezpieczniki** (`--force` przechodzi): pusty plik, odrzucona ponad połowa.

`strip` zdejmuje pole `piosenkomat` z `reviewed-*` → `final-*.hrcpsng`. Przy
poprawkach ustawia `id = correction_target` — apka referencjonuje piosenki po `lclId`
(ulubione, albumy, oceny), więc poprawiony tytuł nie może zmienić id — i wypisuje
listę „co podmienić”.

## Stara apka (`reply`)

Najstarsza, nierozwijana wersja apki wysyła mejle w innym formacie: temat
`Piosenka "X"`, JSON owinięty w `{"o!_id": {…}}`, bez zgody na regulamin, bo go
jeszcze nie było. Treść bywa kompletna, więc **stary format nie blokuje importu**:
`consentVersion` dostaje sentinel `brak (stara apka)` (bez uwagi `no-consent`;
do wygrepowania, gdybyś chciał doprosić o zgodę), a mejl etykietę `song/old-app/to-reply`.

Ta etykieta jest kolejką odpowiedzi i jedynym źródłem prawdy, komu nie odpisano —
stąd `reply` nie bierze katalogu. Jedna odpowiedź na autora, nie na mejl: kto
przysłał pięć piosenek, dostaje jeden mejl w najnowszym wątku, a `to-reply`
schodzi ze wszystkich pięciu i wchodzi `replied`. Przerwany przebieg dokańcza
powtórzenie komendy. Treść: `oldestFormatReplyMessage` z `harcapp_core`. `-n`
ogranicza liczbę autorów (Gmail tnie ok. 500 mejli na dobę).

Etykietę można ruszać ręcznie: zdjęta znaczy „nie zawracaj mu głowy”, dowieszona
wsadza z powrotem do kolejki.

## Osoby dodające

`people.dart` w katalogu przebiegu to gotowe stałe `RegisteredContributor`
w kształcie `lib/values/people/data.dart`, tylko dla osób, których tam jeszcze nie
ma (po adresie). Adres nadawcy jest zawsze pierwszy w `emails`, bo to on siedzi
w `email_ref` piosenki i po nim `ContributorRef.resolve()` znajduje osobę.
Doklejasz na koniec `data.dart`, `data.all.g.dart` przegeneruje pre-commit.
`label reviewed` wypisuje adresy osób, którym wszystkie piosenki wypadły — tych
nie dopisujesz.

W komentarzach na końcu pliku: nadawcy już obecni w `data.dart` oraz piosenki bez
bloku „Osoba dodająca” (mają tylko `email_ref`, nie ma kogo dopisać).

## Dev

Parser ciągnie `SongRaw`, a ten Fluttera, więc `dart run` nie działa. `./piosenkomat`
odpala pod spodem `flutter test test/cli_harness.dart`, stąd prefiks `Shell:`
w wyjściu. Testy: `flutter test` w `tool/piosenkomat`.

Stare nazwy komend (`process`, `apply`, `review`, `commit`, `unapply`, `check`) i flagi
`--write` / `--apply` działają jako ciche aliasy, ale nie ma ich w pomocy. `process --apply`
już nie etykietuje po przesiewie — etykiety nadaje osobny `label scanned --push`.
