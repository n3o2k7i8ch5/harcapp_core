# piosenkomat

Przesiewa mejle z piosenkami na `harcapp@gmail.com`. Kompletne nowe piosenki
trafiają do pliku `.hrcpsng` do wczytania na stronie, a mejle dostają te same
etykiety, których używasz przy ręcznym przeglądaniu, plus znacznik `song/auto`.
Parsowaniem zajmuje się `harcapp_core`, nic tu nie zgaduje.
Gmail jest jedynym stanem.

**Obsługuje wyłącznie zgłoszenia wysłane z apki.** Zgłoszenia ze strony
(`harcapp.web.app`) są poza zakresem i są **aktywnie odsiewane** — po znaczniku
`[hrcpsng/web]` w temacie, a gdy jest plik zgłoszenia, także po polu `source`
w nim. Ogarniasz je ręcznie.

**Jeden wątek to jedna piosenka.** Druga piosenka dosłana odpowiedzią w wątku,
który ma już etykietę, nie istnieje dla narzędzia i nie ma istnieć. Wyjątkiem
jest `reopen`: on celowo wraca wątek do kolejki, żeby poprawiona wersja **tej
samej** piosenki mogła przyjść odpowiedzią. Dlatego i apka (ekran wysyłki),
i treść zgłoszenia, i szablon odpowiedzi mówią autorowi: każdą kolejną piosenkę
wyślij osobnym mejlem.

## Format zgłoszenia

Zgłoszenie z apki jedzie **załącznikiem** `submission.hrcpsngsbm`, nie treścią
mejla. Nazwa jest zawsze ta sama i zawsze ASCII — rozpoznajemy plik po
rozszerzeniu, a stała krótka nazwa nie da się żadnemu klientowi zakodować
po RFC 2231, czego czytnik surowego `.eml` by nie odczytał.
Treść jest wyłącznie dla człowieka, a narzędzie czyta z niej jedną rzecz:
dopisek autora, czyli wszystko nad zamrożoną belką `Akceptacja regulaminu`.

```json
{
  "format": 1,
  "digest": "sha256:…",
  "source": "app-android",
  "app_version": "2.4.1",
  "rules_version": "v05.10.2025",
  "submissions": [
    {
      "kind": "correction",
      "corrected_song_id": "o!_barka",
      "corrected_song_digest": null,
      "correction_message": "poprawka chwytu w refrenie",
      "sender_is_contributor": true,
      "contributor": {"person": {…}, "emails": ["…"]},
      "song": {…}
    }
  ]
}
```

- **`format`** to wersja **całego protokołu** (znacznik w temacie + kontrakt
  treści + kształt pliku), nie samego pliku. Wersja nowsza niż znana nie jest
  zgadywana: zgłoszenie dostaje `rejected/unknown-format` + `have-a-look`.
- **`digest`** liczy się z całego pliku po wyrzuceniu samego pola `digest`,
  z postaci kanonicznej (klucze posortowane, bez białych znaków, UTF-8).
  Nie broni przed połamaniem linii — od tego jest sam załącznik, który idzie
  bajt w bajt. Broni przed ręczną edycją i przed obcięciem.
- **Plik zawiera listę zgłoszeń**, każde z **jedną** piosenką i własnymi
  metadanymi. Dziś apka wysyła jedno; przy kilku narzędzie bierze pierwsze
  i mówi o tym uwagą `skipped-submissions`.
- **`sender_is_contributor`** rozstrzyga to, co dotąd zgadywała heurystyka: czy
  adres nadawcy doklejać do karty osoby dodającej. Przy `false` adres służy
  wyłącznie do odpisania i **nie** wchodzi do `people.dart`.
- Kolejka łapie nowy format dwiema drogami — znacznik `[hrcpsng/app]` w temacie
  **albo** rozszerzenie załącznika — bo temat jest edytowalny przez człowieka.

Stare kształty mejla (`fenced`, `legacy`, `old-app`) działają dalej, obok.
`report.txt` pokazuje ich rozkład; po nim poznasz, kiedy wolno skasować stare
czytniki — a schodzą **razem** ze starymi członami kolejki, jednym ruchem.

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
   - `plan.json`,
   - `candidates-new.hrcpsng`,
   - `candidates-correction.hrcpsng`,
   - kopie `reviewed-*.hrcpsng`.  
   ####
   [Jak automat decyduje](#jak-automat-decyduje).
   ####
2. **Etykiety automatu.**  
   `./piosenkomat label scanned --push`  
   ####
   Wrzyca labele z `plan.json` na Gmaila. Pomija mejle, które w międzyczasie dostały już jakąś etykietę `song/*`. Pomyłka → `unlabel --push`.
   ####
3. **Przegląd na stronie.**  
   *(ręcznie)*  
   ####
   Wczytujesz **jeden** plik naraz: najpierw:
   - `candidates-new.hrcpsng`, potem osobno
   - `candidates-correction.hrcpsng`.  
   Nad piosenką: badge POPRAWKA, dopiski autora, pastylki z uwagami
   i **werdykt** — przełącznik „wchodzi do śpiewnika” plus pole na odpowiedź
   do osoby dodającej.
   ####
   Poprawiasz, gasisz przełącznik przy tych, co odpadają, eksportujesz
   i podmieniasz eksportem odpowiednio: 
   - `reviewed-new.hrcpsng` albo 
   - `reviewed-correction.hrcpsng`.
   ####
   **Wywalać i edytować, nie dodawać.**
   ####
4. **Decyzje z przeglądu.**  
   `./piosenkomat label reviewed --push`  
   ####
   Piosenka z ✓ → `ready-to-add`; z ✗ albo skasowana →
   `rejected/after-review`; z odpowiedzią → `reply/review-note`.
   ####
   Szczegóły i warunki STOP → [Przegląd i prepare](#przegląd-i-prepare).
   ####
5. **Piosenki do śpiewnika.**  
   `./piosenkomat prepare` (zdjęcie z plików .hrcpsng metadanych piosenkomatu), potem *(ręcznie)*  
   ####
   `reviewed-*.hrcpsng` → `final-*.hrcpsng` bez śladu piosenkomatu, plus
   `people.dart` z osób, które naprawdę weszły. Pliki `final-*` wklejasz do
   `assets/songs/all_songs.hrcpsng` i commitujesz. Dopóki tam nie są, `label added`
   kłamie (mejl zamknięty, piosenki w apce nie ma), a następny `scan` nie
   rozpozna ich jako duplikatów.
   ####
6. **Osoby dodające.**  
   *(ręcznie)*  
   ####
   Doklejasz `out/import-<data>/people.dart` na koniec `lib/values/people/data.dart`,
   zanim wkleisz piosenki → [Osoby dodające](#osoby-dodające).
   ####
7. **Domknięcie mejli.**  
   `./piosenkomat label added --push`  
   ####
   `ready-to-add` + `auto` → `added`, przeczytane. Twoje ręczne `ready-to-add`
   (bez `auto`) zostają nietknięte. Domyka **ten przebieg**; gotowe mejle
   z innego przebiegu wypisuje i zostawia, bo tamtych piosenek jeszcze nie
   wkleiłeś. `--all`, gdy wklejone są wszystkie.
   ####
8. **Sprzątanie.**  
   `./piosenkomat clean --push`  
   ####
   Kasuje katalog przebiegu, gdy nic już na niego nie czeka. Sam sprawdza
   w Gmailu, czy werdykty, odpowiedzi do osób dodających i kolejka starej apki są
   domknięte — jeśli nie, odmawia i mówi, co wisi.

Osobno, kiedy chcesz: **najpierw** `./piosenkomat reply --draft --push`,
przegląd szkiców w Gmailu, **potem** `./piosenkomat reply --push` — odpowiedzi
autorom ze starej apki i osobom dodającym → [Stara apka](#stara-apka-reply).
Bez szkicu nie wysyłasz.

## Komendy

| komenda | co robi | Gmail |
|---|---|---|
| `scan [-n N] [--newest] [-o KATALOG]` | przesiew N najstarszych (bez `-n` — całej kolejki; `--newest` — najnowszych) | czyta |
| `explain plik.eml` | klasyfikacja lokalnego pliku | nie dotyka |
| `label scanned [KATALOG]` | pokazuje plan przebiegu z `plan.json` | czyta |
| `label reviewed [KATALOG]` | pokazuje decyzje z `reviewed-*` | czyta |
| `label added [KATALOG]` | pokazuje, co domknie z przebiegu | czyta |
| `label added --all` | cała skrzynka, nie tylko przebieg | czyta |
| `unlabel [KATALOG]` | pokazuje, co cofnie na mejlach przebiegu | czyta |
| `unlabel --all` | cała skrzynka, nie tylko przebieg | czyta |
| `reply [KATALOG] [-n N]` | kto z przebiegu czeka na „zaktualizuj apkę” | czyta |
| `reply --draft [KATALOG]` | szkice do przejrzenia zamiast wysyłki | czyta |
| `reply --undraft [KATALOG]` | kasuje szkice, nikomu nic nie wysyłając | czyta |
| `reply --all …` | cała stojąca kolejka, nie tylko przebieg | czyta |
| `reopen` | kto odpisał na Twoje pytanie — wraca do kolejki | czyta |
| `clean [KATALOG]` | kasuje katalog domkniętego przebiegu | czyta |
| `prepare [KATALOG]` | `reviewed-*` → `final-*` plus `people.dart` | nie dotyka |
| `… --push` | wykonuje to, co bez flagi tylko pokazał | **pisze** |

Komendy na przebiegu bez `KATALOG` biorą **ostatni** z `out/`.

`unlabel` cofa wszystko, co nadał automat — poznaje po `song/auto`, którego Ty nie
wieszasz. Jak każda komenda na przebiegu bierze katalog, a bez niego ostatni
przebieg (wypisze, ile mejli z `auto` siedzi poza nim). **Całą skrzynkę** czyści
dopiero `--all` — także przebiegi, po których `out/` już przepadł, i paczkę, która
czeka jeszcze u Ciebie na przegląd.
Nie rusza `added` (piosenka jest w apce, zdjęcie etykiet wepchnęłoby ją z powrotem
do kolejki) — `--force`, żeby i te zeszły. Tego, że autor dostał już odpowiedź,
`unlabel` nie zgubi: to nie etykieta, tylko nasza wysłana wiadomość.

## Etykiety

```
song/
├── ready-to-add              w pliku, czeka na domknięcie (albo Twoja ręczna)
├── added                     koniec
├── correction                ZNACZNIK: zgłoszenie to poprawka — wgrywasz podmianą, nie dodaniem
├── have-a-look               ZNACZNIK obok odrzutu: piosenkomat skończył, ale rzuć okiem —
│                             identyczna z dopiskiem, zepsuty załącznik albo unparsable;
│                             zdejmujesz Ty
├── add-contributor           „wpisać osobę dodającą do apki”, tylko Ty
├── rejected/
│   ├── already-in-app        automat: piosenka IDENTYCZNA (każde pole) z tą w apce
│   ├── duplicate             automat: identyczna z nowszym zgłoszeniem w paczce
│   ├── after-review          automat zaproponował, Ty wyrzuciłeś na stronie (`label reviewed`)
│   ├── corrupted-file        automat: załącznik nie do wczytania (suma, JSON, obcięcie,
│   │                         zero zgłoszeń); zawsze z `have-a-look`
│   ├── unknown-format        automat: plik w wersji protokołu nowszej niż zna to narzędzie;
│   │                         zawsze z `have-a-look`
│   ├── unparsable            automat: nie dało się sparsować, powód nieznany (nie-piosenka,
│   │                         nieznany kształt); zawsze z `have-a-look`
│   ├── no-chords             tylko Ty
│   ├── silly                 tylko Ty (kiedyś LLM)
│   └── too-niche             tylko Ty (kiedyś LLM)
├── needs-review/             piosenka w pliku kandydatów, czeka na `label reviewed`;
│                             podkategoria na każdą uwagę
│   ├── user-message          ktoś coś dopisał
│   ├── duplicate-in-app      ten sam tytuł / podobny tekst do piosenki w apce
│   ├── duplicate-in-batch    kolizja z innym zgłoszeniem z tej samej paczki
│   ├── undeclared-correction ta sama piosenka co w apce, inne chwyty albo drobiazgi —
│   │                         ktoś poprawił i wysłał jako nową
│   ├── correction-problem    poprawka, ale w apce nie ma czego poprawiać
│   ├── missing-data          brak YouTube, chwytów lub tytułu
│   ├── no-consent            brak zgody albo nie wiadomo, kto zgłosił
│   ├── skipped-submissions   w pliku było kilka zgłoszeń, weszło pierwsze
│   └── several-contributors  kilka kart osób dodających — wkład przypisz ręcznie
├── reply/                    kolejka `reply`: autorowi trzeba odpisać, jeden mejl na autora
│   ├── old-app               mejl z najstarszej apki — blok „zaktualizuj apkę”
│   └── review-note           Twój tekst z przeglądu („Odpowiedź do autora”)
├── waiting-for-author        tekst z przeglądu poszedł, przeczytane; czekamy na
│                             odpowiedź autora (`reopen`)
└── auto                      ZNACZNIK: tę etykietę stanu nadał automat
```

- **Kolejka** to zgłoszenia piosenek (temat `Nowa piosenka` / `Poprawka piosenki`
  albo `### Kod piosenki:` w treści) w `in:inbox` bez żadnej etykiety `song/*`,
  liczonej **po wątku**. Innych mejli narzędzie nie czyta i nie etykietuje.
- **Zgłoszenie = wątek.** Reprezentantem jest najnowsza wiadomość z własnym kodem
  piosenki (nie z cytatu) od nadawcy ≠ skrzynka HarcApp; gdy takiej nie ma poza
  pierwszą — pierwsza. Pozostałe wiadomości to dopiski. Etykiety idą na cały wątek.
- `song/auto` zawsze towarzyszy jednej etykiecie stanu. Twoje decyzje to te bez `auto`.
- Czy autor dostał już odpowiedź, mówi Gmail, nie etykieta: nasza wysłana
  wiadomość w wątku (`SENT`), a przy starej apce — cokolwiek wysłanego do
  nadawcy (`in:sent to:…`), bo `reply` odpisuje raz na autora. Tak samo szkic:
  czeka w wątku, Gmail go pokazuje.
- **Przeczytane** = sprawa zamknięta: `added` i każde `rejected/*` (także
  z `have-a-look` — listą jest etykieta, nie nieprzeczytane), oraz
  `waiting-for-author` po wysłanej odpowiedzi. Pozostałe `needs-review/*`
  i `reply/*` zostają nieprzeczytane.

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

**Cechy**: `kind` (z pliku zgłoszenia; przy starych mejlach z tematu albo
niepustego bloku „Propozycja poprawki”), `legacyApp` (czy ze starej apki),
`shape` (rozpoznany kształt mejla), `senderIsContributor`, `userMessage`,
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
| `identical` | `SameText ∧ SameChords ∧ ¬MetadataDiff` — **każde pole równe** | `rejected/already-in-app`; z dopiskiem + `have-a-look` | to samo, a „dopiskiem” jest też propozycja poprawki |
| `sameSong` | tytuł, tekst ≥ 90%, chwyty, ale coś inne | uwaga `metadata-differ-from-app` | kandydat bez uwagi |
| `sameTextDifferentChords` | tytuł, tekst ≥ 90%, inne chwyty | uwaga `chords-differ-from-app` | kandydat |
| `sameTitleDifferentText` | ten sam tytuł, tekst < 90% | uwaga `same-title-in-app` | kandydat |
| `similarText` | inny tytuł, tekst ≥ 50% | uwaga `similar-text-in-app` | kandydat; cel zgadnięty tylko przy tekście ≥ 90%, inaczej `no-target-in-app` |
| brak | — | czysty kandydat | uwaga `no-target-in-app` |

**Identyczna nigdy nie idzie do pliku** — automat sam ją odrzuca, z dopiskiem
czy bez. Wszystko mniej niż identyczne idzie do `candidates-new` albo
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
| `corrupted-submission-file`, `unknown-submission-format` | blocking | ✓ | ✓ (piosenki nie ma po czym odczytać) |
| `skipped-submissions`, `several-contributors` | blocking | ✓ | ✓ |
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
  "kind": "correction", "old_app": true, "sent_at": "…",
  "app_version": "2.4.1",
  "sender": "jan@example.com", "sender_is_contributor": false,
  "conversation": [{"text": "…", "at": "…"}, {"text": "…", "ours": true}],
  "correction_message": "…",
  "correction_target": "o!_plonie_ognisko",
  "thread_id": "17a6…", "run": "import-…",
  "issues": [{"issue": "no-consent"}],
  "accepted": false, "review_note": "…"
}
```

`conversation` to rozmowa z wątku: dopiski autora i Twoje odpowiedzi (`ours`).
`accepted` i `review_note` dopisuje edytor przy przeglądzie: przełącznik
„wchodzi” i tekst z pola „Odpowiedź do autora”. Skąd przyszło zgłoszenie, mówi
`source` w **pliku zgłoszenia**; rozpoznany kształt mejla widać w rozkładzie
w `report.txt`.

`correction_target` — którą piosenkę w apce poprawia — bierze się **z mejla**:
nowy format niesie `corrected_song_id` w pliku zgłoszenia, starszy w sekcji
`### Poprawiana piosenka:` z id w bloku ``` (klienty łamią
długie linie, blok czyta się w całości), a piosenka własna pamięta
swój pierwowzór od chwili, w której wzięto ją do edycji. Gdy zgłoszenie nic nie
mówi (stara apka, apka sprzed tej zmiany), narzędzie **wolno zgaduje** po tytule
i tekście, ale nigdy nie udaje, że to dane: dokłada `correction_target_guessed`,
uwagę `guessed-correction-target` i dopisek przy „podmień” w `prepare`.
Deklaracja liczy się tylko w poprawce (piosenka przerobiona z cudzej i wysłana
jako nowa też pamięta pierwowzór — to nie deklaracja) i tylko wtedy, gdy wskazane
id **jest** w śpiewniku; inaczej to brak celu (`no-target-in-app`), nie cel.

Oba pola nigdy nie jadą do `all_songs.hrcpsng`: `toApiJsonMap` wypuszcza je tylko
na życzenie narzędzia, a `prepare` zdejmuje je przed wgraniem — razem z pamięcią
o pierwowzorze w samej piosence (`corrected_song_id`).

## Przegląd i `prepare`

`label reviewed` porównuje `candidates-*` z `reviewed-*` po id wątku
(`thread_id` w `piosenkomat`, zapasowo `contributor_data.email_thread_id`; gdyby
oba zginęły — po kolei id piosenki, tytuł, tekst):

| przełącznik | odpowiedź do osoby dodającej | mejl dostaje |
|---|---|---|
| ✓ (albo brak flagi) | — | `ready-to-add` (poprawka: + `song/correction`) |
| ✓ | jest | `ready-to-add` + `reply/review-note` |
| ✗ | — | `rejected/after-review`, przeczytane |
| ✗ | jest | `reply/review-note`, **nie** `rejected` — piosenka może wrócić z chwytami |
| skasowana z pliku | — | `rejected/after-review`, przeczytane |

**Przełącznik zastępuje kasowanie, nie zabrania go.** Brak flagi znaczy
„wchodzi”, więc dotykasz tylko tych, które odrzucasz, a kasowanie działa jak
dotąd — stare pliki zwrotne też. `prepare` bierze do `final-*` wyłącznie te z ✓.

Brak pliku zwrotnego danego rodzaju = tej części jeszcze nie przeglądałeś. Ślad
decyzji w `decisions.json` — z werdyktem i odpowiedzią, bo stamtąd bierze je
później `reply`.

**STOP** (bez wyjścia przez `--force`): piosenka spoza kandydatów (obcy `thread_id`),
zły rodzaj w pliku (poprawka w `reviewed-new`), dwie zachowane poprawki tej samej
piosenki. **Bezpieczniki** (`--force` przechodzi): pusty plik, odrzucona ponad połowa.

`prepare` zdejmuje pole `piosenkomat` z `reviewed-*` → `final-*.hrcpsng`. Przy
poprawkach ustawia `id = correction_target` — apka referencjonuje piosenki po `lclId`
(ulubione, albumy, oceny), więc poprawiony tytuł nie może zmienić id — i wypisuje
listę „co podmienić”. Cel zgadnięty dostaje w tej liście dopisek, bo podmiana
po złym id kosztuje cudzą piosenkę.

## Sprzątanie (`clean`)

Katalog przebiegu **nie jest śmieciem od razu** po wgraniu piosenek do
`all_songs`. Trzy rzeczy trzymają go przy życiu:

| co | dopóki |
|---|---|
| plan przebiegu (`plan.json`) | `label reviewed` i `label added` mają co robić |
| teksty odpowiedzi (`decisions.json`) | `reply` nie wyśle ich autorom |
| pliki `.hrcpsng` | nie skończysz przeglądu i `prepare` |

Najłatwiej przeoczyć ten drugi: odpowiedź do osoby dodającej piszesz w edytorze, ale
mejl wychodzi czasem długo później, a tekst siedzi w `decisions.json`. Katalog
skasowany za wcześnie = mejl bez Twojego tekstu.

Dlatego to komenda, a nie `rm -rf`: `clean` pyta Gmaila, czy mejle przebiegu
nie wiszą w `ready-to-add`, `needs-review/*` ani `reply/*`. Wiszą → odmawia i wypisuje, ile czego (`--force` przechodzi).
Nie wiszą → katalog leci, bo cały ślad jest już w Gmailu.

## Pytania do osób dodających

Piosenka bez chwytów nie jest ani „wchodzi”, ani „odrzucona” — jest
**wstrzymana**, dopóki osoba dodająca czegoś nie dośle. Żeby tego nie trzymać w głowie,
w edytorze piszesz odpowiedź od razu przy piosence, a narzędzie pamięta resztę.

```bash
# 1. w edytorze: gasisz przełącznik + „Brakuje chwytów. Dorzuć je i wejdzie.”
./piosenkomat label reviewed --push   # → song/reply/review-note, nieprzeczytane
./piosenkomat reply --draft --push    # szkic w wątku
#  …przejrzysz w Gmailu…
./piosenkomat reply --push            # → song/waiting-for-author, przeczytane
#  …osoba dodająca odpisuje z chwytami…
./piosenkomat reopen --push           # zdejmuje song/*, wątek wraca do kolejki
./piosenkomat scan                    # przesiewa go jak nowe zgłoszenie
```

**Dlaczego `reopen` w ogóle istnieje:** kolejka to „inbox bez `song/*`, po
wątkach”, a odpowiedź wpada do wątku, który etykiety już ma — więc
`scan` sam by jej nie zobaczył. `reopen` szuka wątków z `waiting-for-author`,
w których po naszej ostatniej wiadomości pojawiła się przychodząca (szkice
się nie liczą), i zdejmuje z nich `song/*`. Wątek wraca do kolejki i przechodzi
normalny przesiew, tyle że z nowymi chwytami.

Wątek z `added` **pomija** — piosenka jest w apce, „dzięki” od autora to nie
zgłoszenie, a poprawkę przysyła się z apki jako nową. O starą apkę `scan` drugi
raz nie zapyta: do tego autora już coś wysłaliśmy, a blok o starej apce idzie
w każdej odpowiedzi takiemu autorowi.

**Mejl jest składany, nie pisany raz.** Treść to funkcja tego, co mamy do
powiedzenia (`composeContribReply` w `harcapp_core`): powitanie + Twoje uwagi +
blok o starej apce, jeśli zgłoszenie z niej przyszło + „Czuwaj!”. Dzięki temu
osoba ze starej apki, której dopisałeś uwagę, dostaje **jeden** mejl z obiema
sprawami, a nie dwa. Kto przysłał kilka piosenek, dostaje jeden mejl ze
wszystkimi uwagami.

Gdy dochodzi kolejna sprawa, istniejący szkic jest **aktualizowany**
(`drafts.update`), nie zakładany drugi raz. Swój szkic narzędzie poznaje po
kształcie: „Dzięki za piosenki :)” na początku, „Czuwaj!” na końcu. Taki
przelicza od nowa i **wypisuje akapity, które przy tym wypadły** — bo
poprzedniej wersji uwagi nikt nie pamięta, a po cichu gubić nie wolno. Szkic
dopisany po „Czuwaj!” albo z innym początkiem to Twoja ręczna robota: zostaje
nietknięty, z komunikatem. Nieczytelny też zostaje.

## Stara apka (`reply`)

Najstarsza, nierozwijana wersja apki wysyła mejle w innym formacie: temat
`Piosenka "X"`, JSON owinięty w `{"o!_id": {…}}`, bez zgody na regulamin, bo go
jeszcze nie było. Treść bywa kompletna, więc **stary format nie blokuje importu**:
`consentVersion` dostaje sentinel `brak (stara apka)` (bez uwagi `no-consent`;
do wygrepowania, gdybyś chciał doprosić o zgodę), a mejl etykietę `song/reply/old-app`
— chyba że autor dostał już od nas odpowiedź (w tym albo innym wątku).

Razem z `reply/review-note` to kolejka odpowiedzi i jedyne źródło prawdy, komu
nie odpisano. Jedna odpowiedź na autora, nie na mejl: kto przysłał pięć piosenek,
dostaje jeden mejl w najnowszym wątku, a `reply/*` schodzi ze wszystkich pięciu. Przerwany przebieg dokańcza powtórzenie komendy. Treść:
`oldestFormatReplyMessage` z `harcapp_core`. `-n` ogranicza liczbę autorów
(Gmail tnie ok. 500 mejli na dobę).

**Zakresem jest przebieg**, jak w pozostałych komendach: bez argumentu ostatni
z `out/`. Etykieta dalej mówi, *komu* nie odpisano — katalog tylko zawęża do
tych, których sam przyniósł. Zaległość spoza przebiegu (a bywa jej sporo — to
kolejka stojąca od zawsze) bierze dopiero `--all`; własne `--query` też omija
zawężenie.

Etykietę można ruszać ręcznie: zdjęta znaczy „nie zawracaj mu głowy”, dowieszona
wsadza z powrotem do kolejki.

### Szkice (`reply --draft`)

**Zawsze najpierw szkic.** `reply --push` bez wcześniejszego `--draft` wysyła
od razu — tego nie robisz. Kolejność:

```bash
./piosenkomat reply --draft --push   # szkice w wątkach, nikt nic nie dostaje
#  …przejrzyj i popraw w Gmailu…
./piosenkomat reply --push           # wysyła gotowe szkice, z Twoimi poprawkami
```

Rozmyśliłeś się? `./piosenkomat reply --undraft --push` kasuje szkice. Nikt nic
nie dostał, więc autorzy zostają w kolejce `reply/*`.

`--draft` etykiet nie rusza: skoro nikt nic nie dostał, autor zostaje w kolejce.
Kto ma szkic, narzędzie pyta Gmaila — w którymkolwiek wątku autora, nie tylko
w najnowszym, więc drugi `--draft` nie założy drugiego szkicu, tylko przeliczy
istniejący. Wysyłka idzie przez `drafts.send`, więc to, co poprawisz w Gmailu,
leci w świat; `reply/*` schodzi.

Szkic skasowany albo wysłany ręcznie z Gmaila też jest obsłużony: jeśli w wątku
jest już nasza wysłana wiadomość, `reply --push` uznaje za odpisane i tylko
przestawia etykiety — drugiego mejla autor nie dostanie. Jeśli nie ma, składa
mejl normalnie.

Szkic potrzebuje tylko zakresu `gmail.modify`, ten sam co etykiety.

## Osoby dodające

`people.dart` w katalogu przebiegu to gotowe stałe `RegisteredContributor`
w kształcie `lib/values/people/data.dart`, tylko dla osób, których tam jeszcze nie
ma (po adresie). Adres nadawcy jest zawsze pierwszy w `emails`, bo to on siedzi
w `email_ref` piosenki i po nim `ContributorRef.resolve()` znajduje osobę.
Doklejasz na koniec `data.dart`, `data.all.g.dart` przegeneruje pre-commit.

Plik powstaje przy `prepare`, nie przy `scan`, i czyta osoby **z samych piosenek,
które wchodzą** — tych z `final-*.hrcpsng`, już bez wywalonych przy przeglądzie
i bez zgaszonego przełącznika. Dzięki temu łapią się też Twoje poprawki karty
osoby zrobione na stronie. Jedyne, czego piosenka nie niesie, to dodatkowe
adresy z bloku „Osoba dodająca” (`ContributorRef` ma jeden `email_ref`) — te
czekają w `plan.json` i `prepare` dokłada je po nadawcy.

W komentarzach na końcu pliku: nadawcy już obecni w `data.dart` oraz piosenki bez
karty osoby (mają tylko `email_ref`, nie ma kogo dopisać).

## Dev

Parser ciągnie `SongRaw`, a ten Fluttera, więc `dart run` nie działa. `./piosenkomat`
odpala pod spodem `flutter test test/cli_harness.dart`, stąd prefiks `Shell:`
w wyjściu. Testy: `flutter test` w `tool/piosenkomat`.

Jedna nazwa na jedną rzecz: żadnych aliasów komend, ukrytych synonimów flag ani
czytania plików pod starymi nazwami. Komendy są tylko te z pomocy, pisze wyłącznie
`--push`, a plan przebiegu nazywa się `plan.json`.
