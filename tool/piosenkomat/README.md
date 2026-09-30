# piosenkomat

Przesiewa mejle z piosenkami na `harcapp@gmail.com`. Kompletne nowe piosenki
trafiają do pliku `.hrcpsng` do wczytania na stronie, a mejle dostają te same
etykiety, których używasz przy ręcznym przeglądaniu, plus znacznik `song/auto`.
Parsowaniem zajmuje się `harcapp_core`, nic tu nie zgaduje.

**Gmail to jedyny wspólny stan.** Etykiety mówią, co się dzieje z mejlem, a szkice
w wątkach — co pójdzie do autorów. Lokalnie jest tylko katalog roboczy **jednego**
otwartego przebiegu, `out/run/`, a po domknięciu jego ślad w `archive/`.

**Obsługuje wyłącznie zgłoszenia wysłane z apki.** Zgłoszenia ze strony
(`harcapp.web.app`) są poza zakresem i są **aktywnie odsiewane** — po znaczniku
`[hrcpsng/web]` w temacie, a gdy jest plik zgłoszenia, także po polu `origin`
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
  "origin": "app-android",
  "app_version": "2.4.1",
  "rules_version": "v05.10.2025",
  "submissions": [
    {
      "kind": "correction",
      "correction_target": "o!_barka",
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
  metadanymi. Dziś apka wysyła jedno. Przy kilku narzędzie **nie rusza żadnego**
  — jeden wątek to jedna piosenka — tylko wiesza `song/multiple-songs`
  + `have-a-look` i zostawia mejl nieprzeczytany: ogarniasz ręcznie.
- **`sender_is_contributor`** rozstrzyga to, co dotąd zgadywała heurystyka: czy
  adres nadawcy doklejać do karty osoby dodającej. Przy `false` adres służy
  wyłącznie do odpisania i **nie** wchodzi do `people.dart`.
- Kolejka łapie nowy format dwiema drogami — znacznik `[hrcpsng/app]` w temacie
  **albo** rozszerzenie załącznika — bo temat jest edytowalny przez człowieka.

Stare kształty mejla (`fenced`, `legacy`, `old-app`) działają dalej, obok.
`report.txt` pokazuje ich rozkład (mejl, którego nie da się odczytać, liczy się
osobno jako `unknown`); po nim poznasz, kiedy wolno skasować stare
czytniki — a schodzą **razem** ze starymi członami kolejki, jednym ruchem.

## Setup (raz)

1. Google Cloud: włącz Gmail API, utwórz klienta OAuth typu **Desktop**.
2. Pobrany JSON zapisz jako `tool/piosenkomat/secrets/credentials.json` (katalog jest w `.gitignore`).
3. Pierwsze uruchomienie otworzy przeglądarkę. Zaloguj się na `harcapp@gmail.com`.
   Token ląduje w `tool/piosenkomat/secrets/gmail_token.json`. Zakres jeden:
   `gmail.modify` — etykiety, szkice i wysyłka (`messages.send` i `drafts.send` go
   przyjmują). Token bez niego narzędzie odrzuca i prosi o ponowne zalogowanie.

Uruchamiaj z korzenia repo przez `./piosenkomat`. Ścieżki `secrets/`, `out/` i `archive/` są względem
`tool/piosenkomat/` i wszystkie trzy są w `.gitignore` — są w nich klucze i adresy autorów.

## Przebieg

**Przebieg jest jeden naraz**: od `scan --push` do `finalize --push` nowego nie
otworzysz → [Jeden przebieg naraz](#jeden-przebieg-naraz). Komendy nie biorą
katalogu — zawsze pracują na `out/run/`. Co jest otwarte i jaki jest następny
krok, mówi w każdej chwili `./piosenkomat status`.

1. **Przesiew.**  
   `./piosenkomat scan -n 20` — sam raport, niczego nie zmienia.  
   `./piosenkomat scan -n 20 --push` — otwiera przebieg.
   ####
   Czyta kolejkę, parsuje, porównuje z apką i między sobą → [Jak automat
   decyduje](#jak-automat-decyduje). Z `--push` nadaje etykiety w Gmailu (mejle,
   które w międzyczasie dostały jakąś `song/*`, pomija), zakłada szkice z blokiem
   o starej apce → [Odpowiedzi do autorów](#odpowiedzi-do-autorów) i zapisuje
   `out/run/`:
   - `report.txt`, `plan.json`, `drafts.json` (co narzędzie wpisało do szkiców),
   - `candidates-new.hrcpsng`, `candidates-correction.hrcpsng` — o ile coś do nich
     poszło,
   - puste `reviewed-*.hrcpsng` — miejsca na eksport po przeglądzie.
   ####
2. **Przegląd na stronie.**  
   *(ręcznie)*  
   ####
   Wczytujesz **jeden** plik naraz: najpierw `candidates-new.hrcpsng`, potem
   osobno `candidates-correction.hrcpsng`. Nad piosenką karta: **werdykt** —
   przełącznik „Do zatwierdzenia” / „Do odrzucenia” — badge POPRAWKA, pastylki
   z uwagami, rozmowa z osobą dodającą i pole na odpowiedź do niej.
   ####
   Poprawiasz, gasisz przełącznik przy tych, co odpadają, eksportujesz i zapisujesz
   eksport w miejsce pustego pliku: `reviewed-new.hrcpsng` albo
   `reviewed-correction.hrcpsng`. **Wywalać i edytować, nie dodawać.**
   ####
3. **Decyzje z przeglądu.**  
   `./piosenkomat review --push`
   ####
   Piosenka z ✓ → `ready-to-add`; z ✗ albo skasowana → `rejected/after-review`;
   z odpowiedzią → `reply/review-note` i szkic z Twoim tekstem w wątku. Do tego
   `final-*.hrcpsng` — piosenki, które wchodzą, bez śladu piosenkomatu — oraz
   `people.dart` z osób, które naprawdę weszły. **Wolno powtarzać**: zmieniasz
   zdanie na stronie, zapisujesz nowy eksport, odpalasz jeszcze raz.
   Szczegóły i warunki STOP → [Przegląd](#przegląd-review).
   ####
4. **Do śpiewnika.**  
   *(ręcznie)*  
   ####
   `out/run/people.dart` doklejasz na koniec `lib/values/people/data.dart` →
   [Osoby dodające](#osoby-dodające), potem `final-*.hrcpsng` wklejasz do
   `assets/songs/all_songs.hrcpsng` i commitujesz. Poprawki podmieniasz po id —
   listę „podmień” wypisuje `review`. Piosenka `oc!_…` leży w `final-*`
   w sekcji `conf` i tam też wklejasz ją w `all_songs` — apka szuka jej tylko tam. `all_songs` nie może mieć zdublowanego
   id: taki się nie wczyta (`scan`, `finalize`, strona) — dostajesz listę id
   do naprawienia, a test `all_songs_test` nie przejdzie przed commitem.
   ####
5. **Domknięcie.**  
   `./piosenkomat finalize --push`
   ####
   Sprawdza, że nic nie czeka na przegląd, przegląd jest aktualny (etykiety,
   `final-*` i szkice zgadzają się z eksportem), a piosenki z `final-*` **są**
   w `all_songs` (inaczej STOP). Wtedy `ready-to-add` + `auto`
   → `added`, przeczytane, a `out/run/` → `archive/<przebieg>/` z `summary.md`.
   Od tej chwili wolno kolejny `scan --push` → [Domknięcie i
   archiwum](#domknięcie-finalize-i-archiwum).

Osobno, kiedy chcesz — także w trakcie przebiegu albo długo po nim: przeglądasz
szkice w Gmailu (poprawiasz, co trzeba), potem `./piosenkomat reply --push`
wysyła je autorom → [Odpowiedzi do autorów](#odpowiedzi-do-autorów). Odpowiedzi
przebiegu nie blokują.

Pomyłka w otwartym przebiegu? `./piosenkomat unlabel --push` cofa go w całości:
etykiety, szkice bez Twojego tekstu i `out/run/`. Mejle wracają do kolejki.

## Komendy

| komenda | bez `--push` | z `--push` |
|---|---|---|
| `status` | co jest otwarte, co czeka, następny krok — aktualność przeglądu sprawdza tak samo jak `finalize`, więc nie wyśle do komendy, która stanie | — |
| `scan [-n N] [--newest] [--query Q]` | raport przesiewu N najstarszych zgłoszeń (wątków, każdy w całości; bez `-n` — całej kolejki; `--newest` — najnowszych) | otwiera przebieg: etykiety, szkice z blokiem, `out/run/`; dokańcza przerwany |
| `review [--force]` | co przestawi, co pójdzie do `final-*`, jakie szkice | etykiety, `final-*`, `people.dart`, szkice z tekstem do autora |
| `finalize [--force]` | czy wolno domknąć i jak będzie wyglądać `summary.md` | `added`, `summary.md`, `out/run/` → `archive/` |
| `reply [-n N]` | kto czeka na odpowiedź i co by poszło | wysyła szkice z kolejki `reply/*` |
| `reopen [--query Q]` | kto odpisał na Twój tekst | zdejmuje `song/*` z tych wątków — wracają do kolejki |
| `unlabel [--all] [--force]` | co cofnie | cofa otwarty przebieg: etykiety automatu, szkice bez Twojego tekstu, `out/run/` |
| `explain plik.eml …` | klasyfikacja lokalnych plików, bez Gmaila — przez to samo sito co `scan` (zgłoszenie ze strony i mejl nie o piosence tylko wypisuje) | — |

Flagi:
- `review --force` pomija bezpieczniki (pusty eksport, odrzucona ponad połowa);
- `finalize --force` domyka mimo piosenek z `final-*`, których nie widać w `all_songs`;
- `unlabel --all` bierze całą skrzynkę, nie tylko otwarty przebieg — także mejle
  z domkniętych; `unlabel --force` zdejmuje też z `added` i kasuje `out/run/`
  z eksportami z przeglądu;
- `--query Q` to własne query Gmaila zamiast kolejki (`scan`) albo zamiast
  czekających na autora (`reopen`).

Ścieżki: `--songs-db PLIK` (`scan`, `finalize`, `explain`; domyślnie
`assets/songs/all_songs.hrcpsng` szukany w górę katalogów), `--credentials PLIK`
i `--token PLIK` (komendy łączące się z Gmailem; domyślnie
`secrets/credentials.json` i `secrets/gmail_token.json`). Ścieżka względna —
tu i w `explain` — liczy się od katalogu, w którym odpalasz `./piosenkomat`,
a domyślne — od `tool/piosenkomat/`. Lista komend:
`./piosenkomat --help`, flagi komendy: `./piosenkomat scan --help` (i tak dalej) —
generowane z ich definicji, więc żadnej nie brakuje. Zbędny argument to błąd
użycia (`scan 20` nie bierze po cichu całej kolejki).

`unlabel` cofa to, co nadał automat — poznaje po `song/auto`, którego Ty nie
wieszasz; Twoje ręczne etykiety zostają. Bez `--all` cofa otwarty przebieg:
z `out/run/` — mejle z jego planu, bez katalogu — wątki z otwartym werdyktem
w Gmailu (przebieg otwarty gdzie indziej). Nie rusza `added` (piosenka jest w apce,
zdjęcie etykiet wepchnęłoby ją z powrotem do kolejki) — `--force`, żeby i te
zeszły. Tego, że autor dostał już odpowiedź, `unlabel` nie zgubi: to nie etykieta,
tylko nasza wysłana wiadomość.

## Jeden przebieg naraz

Dwa przebiegi naraz to dwa komplety plików kandydatów i dwa przeglądy, które się
nie widzą: duplikat z pierwszej paczki nie wyjdzie w drugiej, dopóki pierwsza nie
jest w `all_songs`. Dlatego `scan --push` rusza tylko, gdy **nic** nie jest otwarte.

**Otwarty** jest przebieg, gdy:
- istnieje `out/run/`, albo
- w Gmailu wisi werdykt automatu: mejl z `song/auto` i `ready-to-add` albo
  `needs-review`.

**Rozstrzyga Gmail**, katalog to tylko podpowiedź. Przebieg otwarty na innym
komputerze albo ze skasowanym `out/run/` dalej blokuje: `scan`, `status`, `review`
i `finalize` mówią, ile mejli czeka, zamiast odsyłać do `scan --push`. Domykasz go
tam, gdzie jest, albo cofasz: `./piosenkomat unlabel --push` zdejmuje etykiety
automatu z wątków z otwartym
werdyktem, a domknięte sprawy zostawia. Te wątki wracają do kolejki, a piosenka
wklejona już do `all_songs` wyjdzie przy kolejnym `scan` jako „już w apce” albo
z uwagą, że jest do niej podobna.

**Przerwany `scan --push`** nie zostawia połowy przebiegu. Katalog powstaje obok
(`out/.run-tmp/`) i dopiero gotowy zostaje przemianowany na `out/run/`. Plan
dostaje `pushed_at` dopiero wtedy, gdy etykiety i szkice są w Gmailu. Bez tego
`review` i `finalize` nie ruszą, a kolejny `scan --push` dokańcza przebieg:
nadaje etykiety mejlom, które jeszcze ich nie mają, i zakłada brakujące szkice.

## Etykiety

```
song/
├── ready-to-add              w pliku, czeka na `finalize` (albo Twoja ręczna)
├── added                     koniec
├── correction                ZNACZNIK: zgłoszenie to poprawka — wgrywasz podmianą, nie dodaniem
├── have-a-look               ZNACZNIK obok odrzutu: piosenkomat skończył, ale rzuć okiem —
│                             identyczna z dopiskiem, zepsuty załącznik, unparsable
│                             albo multiple-songs; zdejmujesz Ty
├── multiple-songs            w jednym mejlu kilka piosenek — automat ich nie rusza
│                             (ani plik, ani porównania), nieprzeczytane; ogarniasz ręcznie
├── add-contributor           „wpisać osobę dodającą do apki”, tylko Ty
├── rejected/
│   ├── already-in-app        automat: piosenka IDENTYCZNA (każde pole) z tą w apce
│   ├── duplicate             automat: identyczna z nowszym zgłoszeniem w paczce
│   ├── after-review          automat zaproponował, odpadła przy przeglądzie (`review`)
│   ├── corrupted-file        automat: załącznik nie do wczytania (suma, JSON, obcięcie,
│   │                         zero zgłoszeń); zawsze z `have-a-look`
│   ├── unknown-format        automat: plik w wersji protokołu nowszej niż zna to narzędzie;
│   │                         zawsze z `have-a-look`
│   ├── unparsable            automat: nie dało się sparsować, powód nieznany (nie-piosenka,
│   │                         nieznany kształt); zawsze z `have-a-look`
│   ├── no-chords             tylko Ty
│   ├── silly                 tylko Ty (kiedyś LLM)
│   └── too-niche             tylko Ty (kiedyś LLM)
├── needs-review/             piosenka w pliku kandydatów, czeka na przegląd i `review`;
│                             podkategoria na każdą uwagę
│   ├── user-message          ktoś coś dopisał
│   ├── duplicate-in-app      ten sam tytuł / podobny tekst do piosenki w apce
│   ├── duplicate-in-batch    kolizja z innym zgłoszeniem z tej samej paczki
│   ├── undeclared-correction ta sama piosenka co w apce, inne chwyty albo drobiazgi —
│   │                         ktoś poprawił i wysłał jako nową
│   ├── correction-problem    poprawka, ale w apce nie ma czego poprawiać, cel zgadnięty
│   │                         albo treść znacząco różna od celu (`no-target-in-app`,
│   │                         `guessed-correction-target`, `differs-from-target`)
│   ├── missing-data          brak YouTube, chwytów lub tytułu
│   ├── no-consent            brak zgody albo nie wiadomo, kto zgłosił
│   ├── several-contributors  kilka kart osób dodających — wkład przypisz ręcznie
│   └── guessed-contributor   adres nadawcy doklejony do jedynej karty na zgadywanie
│                             (stary format nie mówi, czy nadawca to ta osoba)
├── reply/                    kolejka `reply`: autorowi trzeba odpisać, odpowiedź czeka w szkicu
│   ├── old-app               mejl z najstarszej apki — blok „zaktualizuj apkę” w każdym takim wątku
│   └── review-note           Twój tekst z przeglądu (pole odpowiedzi w edytorze)
├── waiting-for-author        tekst z przeglądu poszedł, przeczytane; czekamy na
│                             odpowiedź autora (`reopen`)
└── auto                      ZNACZNIK: tę etykietę stanu nadał automat
```

- **Kolejka** to zgłoszenia piosenek w `in:inbox`: temat `Nowa piosenka` /
  `Poprawka piosenki` albo ze znacznikiem `[hrcpsng/app]`, załącznik
  `.hrcpsngsbm`, albo w treści `### Kod piosenki:` lub `NIE EDYTUJ PONIŻSZEGO
  TEKSTU` (najstarsza apka). Bez żadnej etykiety `song/*`, liczonej **po
  wątku**, i bez zgłoszeń ze strony (`[hrcpsng/web]` w temacie) — te odpadają
  już w query, więc nie zajmują miejsc w `-n`. Innych mejli narzędzie nie czyta
  i nie etykietuje.
- **Zgłoszenie = wątek.** Reprezentantem jest najnowsza wiadomość z własnym kodem
  piosenki (nie z cytatu) od nadawcy ≠ skrzynka HarcApp; gdy takiej nie ma poza
  pierwszą — pierwsza. Pozostałe wiadomości to dopiski. Etykiety idą na cały wątek.
- `song/auto` zawsze towarzyszy jednej etykiecie stanu. Twoje decyzje to te bez `auto`.
- Czy odpowiedź już poszła, mówi Gmail, nie etykieta: nasza wysłana wiadomość
  w wątku (`SENT`), a przy starej apce — nasza wiadomość z blokiem o niej w **tym**
  wątku. Tak samo odpowiedź, która czeka: to szkic w wątku, Gmail go pokazuje.
- **Przeczytane** = sprawa zamknięta: `added` i każde `rejected/*` (także
  z `have-a-look` — listą jest etykieta, nie nieprzeczytane), oraz
  `waiting-for-author` po wysłanej odpowiedzi. Zamknięta sprawa z tekstem do
  autora, który jeszcze nie poszedł (`reply/review-note`), zostaje
  nieprzeczytana do wysyłki; sam blok o starej apce (`reply/old-app`) jej nie
  trzyma. `needs-review/*` zostają nieprzeczytane.

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
niepustego bloku „Propozycja poprawki”), `isOldApp` (czy ze starej apki),
`shape` (rozpoznany kształt mejla), `senderIsContributor`, `userMessage`,
`correctionMessage`, `sentAt`, nadawca, zgoda, sparsowana piosenka, `appMatch`
(najbliższa piosenka w apce) i `alsoInApp` (do dwóch kolejnych). Najbliższe inne
zgłoszenie w paczce to fakt o paczce, nie o zgłoszeniu: liczy je
`matchWithinBatch`, a `decide` dostaje je obok cech.

### Podobieństwo

Całe porównanie mieszka w rdzeniu (`harcapp_core/song_book/similarity/similarity.dart`,
jeden import), bo tego samego używa edytor na stronie. Porównanie dwóch piosenek to
lista dowodów:
- `SharedLines` — które wersy jednej mają odpowiednik w drugiej, w obie strony
  (trigramy znaków ≥ 0,7; literówki, kolejność zwrotek, powtórzenia refrenu
  i sklejone wersy tego nie ruszają, dopisane i ucięte zwrotki widać po asymetrii;
  wokalizy „laj la” ważą zero);
- `SameText` — dosłownie równy po zbiciu białych znaków;
- `LayoutDiff` — ten sam tekst albo te same chwyty, ale inaczej ułożone: wersy
  łamane inaczej, inny podział na zwrotki, inne wcięcia (refren), akordy przy
  innych wersach (spacje na końcu wersu i ich ciągi w środku się nie liczą);
- `SameChords` (`a` ≠ `A`; dwie bez chwytów to „obie bez chwytów”) i `ChordsMatch` — pary akordów niezależne od tonacji
  i kolejności zwrotek, z transpozycją;
- `MeterMatch` (sylaby w wersach), `SameRecording` (ten sam film YouTube);
- `SameTitle` — tytuł główny jednej to tytuł drugiej (sam wspólny ukryty się nie liczy);
- `SameId`, `MetadataDiff` (które z: tytuł dosłownie, ukryte tytuły, autorzy,
  kompozytorzy, wykonawcy, data, YouTube, tagi się różnią; `null == []`).

Wniosek to reguła nad listą (`levelOf`). **Tekst rozstrzyga, tytuł tylko opisuje**:
ta sama treść pod innym tytułem to ta sama piosenka. Pokrycie to udział wersów
(wagą długości), które mają odpowiednik; poniżej 40 znaków tekstu nie dowodzi niczego.

| poziom | reguła | `new` → | `correction` → |
|---|---|---|---|
| `identical` | `SameText ∧ SameChords ∧ ¬LayoutDiff ∧ ¬MetadataDiff` — **każde pole równe, także układ** | `rejected/already-in-app`; z dopiskiem + `have-a-look` | to samo, a „dopiskiem” jest też propozycja poprawki |
| `sameSong` | wersy w obie strony ≥ 90% (albo `SameText`) | chwyty te same z dokładnością do kolejności → `metadata-differ-from-app`, inaczej `chords-differ-from-app` | kandydat bez uwagi |
| `longer` | wersy ≥ 90% tylko w jedną stronę: zgłoszenie ma dopisane zwrotki | uwaga `more-verses-than-app` (→ `undeclared-correction`) | kandydat |
| `shorter` | to samo w drugą stronę: fragment piosenki z apki | uwaga `fewer-verses-than-app` | uwaga `differs-from-target` — podmiana skasowałaby brakujące zwrotki |
| `variant` | ≥ 50% wersów w którąś stronę | uwaga `variant-of-app` | uwaga `differs-from-target` |
| `related` | wspólne wersy w obie strony (≥ 10%, co najmniej dwa), wersy „w połowie te same”, te same chwyty albo metrum przy częściowo podobnym tekście, ten sam film | uwaga `similar-text-in-app` | uwaga `differs-from-target`; cel zgadnięty tylko z tym samym tytułem |
| `sameTitleDifferentText` | ten sam tytuł, treść niepodobna | uwaga `same-title-in-app` | z celem z apki `differs-from-target`, bez — `no-target-in-app` |
| `sameIdDifferentSong` | to samo id, a poza tym nic — id zajęte przez inną piosenkę | kandydat bez uwagi (edytor pokazuje dowód `SameId`) | z celem z apki `differs-from-target`, bez — `no-target-in-app` |
| brak | — | czysty kandydat | z celem z apki `differs-from-target`, bez — `no-target-in-app` |

**Poprawka znacząco różna od celu dostaje ostrzeżenie.** Cel wskazany przez apkę
zostaje — to dane ze zgłoszenia — ale gdy treść nie jest już tą samą piosenką
(od `shorter` w dół: fragment, wariant, przeróbka, wspólny tylko tytuł albo id,
nic), poprawka dostaje pomarańczową pastylkę `differs-from-target` z tym, jak
bardzo odbiega („„Płonie ognisko” w apce: treść niepodobna …”). Bez niej trafiłaby
do pliku jako „bez zarzutu”, a po wklejeniu `final-*` zastąpiłaby pod starym id
inną piosenkę. Drobne zmiany i dopisane zwrotki to zwykła poprawka — bez uwag.

Uwaga mówi o najsilniejszym trafieniu i wymienia do dwóch kolejnych („też …”),
o ile są podobne treścią (od `related` w górę; sam tytuł albo id to za mało) —
dwie podobne piosenki w apce to często dwie wersje tej samej. Cel poprawki bez deklaracji zgadujemy od `variant` w górę (co najmniej połowa
wspólnych wersów), a słabsze podobieństwo tylko z tym samym tytułem. Najbliższa
piosenka w apce to najsilniejszy poziom — piosenka o tym samym tytule i innym
tekście przegrywa z piosenką o tym samym tekście. Progi są skalibrowane na całym
śpiewniku; `test/song_book/similarity/songbook_test.dart` pilnuje par ze śpiewnika,
scenariuszy (literówki, refren, zwrotki, przeróbki) i tego, ile par w bazie coś łączy.

**Identyczna nigdy nie idzie do pliku** — automat sam ją odrzuca, z dopiskiem
czy bez. Wszystko mniej niż identyczne idzie do `candidates-new` albo
`candidates-correction`: bez uwag → `ready-to-add`, z uwagami → `needs-review`
plus podkategoria na każdą uwagę.

**W paczce** zgłoszenia grupują się zależnie od rodzaju: nowe po tytule
głównym **albo** treści (ta sama piosenka pod innym tytułem; grupa to spójna składowa), poprawki po `correction_target` (poprawka może zmieniać tytuł), a poprawki bez celu — po tytule głównym. W grupie
identyczne zlewają się do **najnowszej** (reszta → `rejected/duplicate`), a pozostałe
idą do pliku z uwagą. Każde wskazuje jedno najbliższe inne zgłoszenie tego samego
rodzaju: najpierw z własnej grupy, a spoza niej tylko o tym samym tytule głównym
albo podobne treścią (poziom od `related` w górę); w obrębie tego — najsilniejszy
poziom, potem bliskość tekstu. Pastylkę wybiera to, co je łączy, nie grupa:
poprawki tej samej piosenki → `same-target-in-batch`, ten sam tytuł główny →
`same-title-in-batch`, poza tym `similar-text-in-batch`. **W paczce „ten sam
tytuł” to tytuł główny** —
wspólny tytuł ukryty łapie dopiero tekst (z apką `hid_titles` liczą się jak tytuł). Duplikat
z innego przebiegu wyjdzie dopiero, gdy pierwsza wersja będzie w `all_songs`.

### Uwagi

| uwaga | waga | `new` | `correction` |
|---|---|---|---|
| `missing-title`, `missing-chords`, `missing-youtube` | blocking | ✓ | — (poprawka to diff) |
| `no-consent`, `no-contributor-email` | blocking | ✓ | ✓ |
| `several-contributors` | blocking | ✓ | ✓ (każdy format: adresu nadawcy nie doklejamy do żadnej karty) |
| `guessed-contributor` | decision | ✓ | ✓ (tylko formaty bez `sender_is_contributor`) |
| `chords-differ-from-app`, `metadata-differ-from-app` | decision | ✓ | — |
| `same-title-in-app`, `similar-text-in-app` | decision | ✓ | — (normalny kształt poprawki) |
| `more-verses-than-app`, `fewer-verses-than-app`, `variant-of-app` | decision | ✓ | — (normalny kształt poprawki) |
| `same-title-in-batch`, `similar-text-in-batch` | decision | ✓ | gdy celu nie ma albo jest inny — dwie podobne poprawki **różnych** piosenek są podejrzane: zwykle jedna celuje w złą |
| `same-target-in-batch` | decision | — | ✓ (dwie poprawki tej samej piosenki) |
| `no-target-in-app` | decision | — | ✓ (brak celu albo zadeklarowane id, którego w śpiewniku nie ma lub bez `@wykonawca` pasuje kilka) |
| `guessed-correction-target` | decision | — | ✓ (cel dobrany po podobieństwie albo znaleziony dopiero bez `@wykonawca`) |
| `differs-from-target` | decision | — | ✓ (cel jest, a treść to już nie ta sama piosenka: fragment, wariant, przeróbka albo coś zupełnie innego) |
| `user-message` | decision | ✓ | ✓ (tylko `userMessage`; blok poprawki jest oczekiwany) |

Uwaga, która ma podkategorię 1:1, nazywa się tak samo jak ona (`user-message`,
`guessed-contributor`, `several-contributors`). Zepsuty albo nowszy załącznik
uwagą nie jest — piosenki nie ma, więc nie ma czego oglądać w pliku: to odrzut
(`rejected/corrupted-file`, `rejected/unknown-format`) z powodem w raporcie.

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
  "correction_target": "o!_plonie_ognisko", "correction_target_guessed": true,
  "thread_id": "17a6…", "run": "run-…",
  "issues": [{"issue": "no-consent"}, {"issue": "guessed-correction-target", "detail": "…"}],
  "rejected": true, "review_note": "…"
}
```

`conversation` to rozmowa z wątku: dopiski autora i Twoje odpowiedzi (`ours`).
Twoich w kolejce nie ma (leżą w wysłanych), więc `scan` dociąga je z wątku
i pokazuje bez ramki — samą sprawę; etykiet na nich nie wiesza.
`rejected` i `review_note` dopisuje edytor przy przeglądzie: zgaszony
przełącznik i tekst z pola odpowiedzi. Pola są tylko wtedy, gdy mają coś do
powiedzenia — domyślnie piosenka wchodzi i nie ma odpowiedzi. Skąd przyszło zgłoszenie, mówi
`origin` w **pliku zgłoszenia**; rozpoznany kształt mejla widać w rozkładzie
w `report.txt`.

`correction_target` — którą piosenkę w apce poprawia — bierze się **z mejla**:
plik zgłoszenia niesie `correction_target`, a piosenka własna pamięta swój
pierwowzór (`based_on_song_id`) od chwili, w której wzięto ją do edycji — tylko
tak mówi o nim mejl bez pliku. Id sprzed zmiany
wykonawcy w apce szukamy też bez członu `@wykonawca` — jedno trafienie to cel
zgadnięty, kilka to brak celu. Gdy zgłoszenie nic nie
mówi (stara apka, apka sprzed tej zmiany), narzędzie **wolno zgaduje** po tytule
i tekście, ale nigdy nie udaje, że to dane: dokłada `correction_target_guessed`,
uwagę `guessed-correction-target` i dopisek przy „podmień” w `review`.
Deklaracja liczy się tylko w poprawce (piosenka przerobiona z cudzej i wysłana
jako nowa też pamięta pierwowzór — to nie deklaracja) i tylko wtedy, gdy wskazane
id **jest** w śpiewniku; inaczej to brak celu (`no-target-in-app`), nie cel.

Oba pola nigdy nie jadą do `all_songs.hrcpsng`: `toApiJsonMap` wypuszcza je tylko
na życzenie narzędzia, a `review --push` zdejmuje je w `final-*` — razem z pamięcią
o pierwowzorze w samej piosence (`based_on_song_id`).

## Przegląd (`review`)

`review` porównuje `candidates-*` z `reviewed-*` po id wątku (`thread_id`
w `piosenkomat`; gdyby zginął — po kolei id piosenki, tytuł, tekst):

| przełącznik | odpowiedź do osoby dodającej | mejl dostaje |
|---|---|---|
| ✓ (brak `rejected`) | — | `ready-to-add` (poprawka: + `song/correction`) |
| ✓ | jest | `ready-to-add` + `reply/review-note` |
| ✗ | — | `rejected/after-review`, przeczytane |
| ✗ | jest | `reply/review-note`, **nie** `rejected` — piosenka może wrócić z chwytami |
| skasowana z pliku | — | `rejected/after-review`, przeczytane |

**`review` można odpalać wiele razy.** Etykiety liczą się od tego, co mejl ma
teraz w Gmailu, więc zmiana zdania („nie” → „tak” i odwrotnie) przestawia
etykietę, a to, co się zgadza, zostaje. Tekst do autora idzie raz: gdy wątek ma
już `waiting-for-author`, `reply/review-note` nie wraca, a `review` wypisuje
„JUŻ ODPISANE” — tekst zmieniony po wysłaniu wysyłasz ręcznie. Szkice też się
przeliczają, ale tylko te, których nie poprawiałeś w Gmailu → [Szkice](#szkice).

**Przełącznik zastępuje kasowanie, nie zabrania go.** Brak `rejected` znaczy
„wchodzi”, więc dotykasz tylko tych, które odrzucasz, a kasowanie działa jak
dotąd. Do `final-*` idą wyłącznie te z ✓.

**Bez kompletu eksportów nic nie rusza.** Pusty plik zwrotny (tak zostawia go
`scan`) albo brak pliku = tej części jeszcze nie było w przeglądzie, więc
`review` i `finalize` stają (STOP, bez `--force`) i wypisują, którego eksportu
brakuje. Przeglądu na raty nie ma: najpierw oba pliki, potem komenda. Eksport bez
żadnej piosenki to co innego — „odrzucam wszystko”, bezpiecznik niżej.

**STOP** (bez wyjścia przez `--force`): piosenka spoza kandydatów (obcy
`thread_id`), zły rodzaj w pliku (poprawka w `reviewed-new`), dwie zachowane
poprawki tej samej piosenki, sprzeczne kopie jednego zgłoszenia (różny
przełącznik, różna odpowiedź do autora, dwie zachowane kopie jednej poprawki).
Nowa piosenka rozbita na stronie na dwie wchodzi cała. **Bezpieczniki**
(`--force` przechodzi): eksport bez żadnej piosenki, odrzucona ponad połowa.

**`final-*`** to `reviewed-*` bez pola `piosenkomat`. Przy poprawkach `review`
ustawia `id = correction_target` — apka referencjonuje piosenki po `lclId`
(ulubione, albumy, oceny), więc poprawiony tytuł nie może zmienić id — i wypisuje
listę „co podmienić”. Cel zgadnięty dostaje w tej liście dopisek, bo podmiana po
złym id kosztuje cudzą piosenkę.

## Domknięcie (`finalize`) i archiwum

`finalize --push` kończy przebieg, kiedy piosenki są już w `all_songs`. Staje, gdy:
- coś czeka na przegląd (`needs-review` od automatu),
- brakuje eksportu albo przegląd ma STOP; bezpieczników `review` (pusty
  eksport, odrzucona ponad połowa) `finalize` już nie sprawdza — przeszły albo
  przełamałeś je `--force` przy `review --push`,
- przegląd jest nieaktualny: eksport w `reviewed-*` zmienił się po `review --push`,
  więc etykiety w Gmailu, `final-*` albo szkice odpowiedzi nie zgadzają się z tym,
  co z niego wynika teraz — `finalize` liczy przegląd od nowa i porównuje.
  Szkic nieruszony w Gmailu, a z innym tekstem niż na stronie, zatrzymuje
  domknięcie: po archiwizacji nie przeliczyłby go już nikt, a `reply --push`
  wysłałby stary tekst. Szkic poprawiony w Gmailu jest Twój i nie przeszkadza,
- piosenek z `final-*` nie ma w `all_songs` w tej samej postaci (brak id albo pod
  nim inna wersja) — `--force`, jeśli świadomie inaczej.

Potem mejle z `ready-to-add` + `auto` dostają `added` i są przeczytane (Twoje
ręczne `ready-to-add` zostają nietknięte), a `out/run/` przenosi się do
`archive/<przebieg>/` — nazwa to data i godzina `scan --push`, np.
`run-2026-09-28T101500`. W archiwum zostaje cały katalog, a na wierzchu
`summary.md`: nowe piosenki, poprawki (co podmieniło które id i czy cel był
zgadnięty), co odpadło przy przeglądzie i które wątki czekały jeszcze na
odpowiedź (mają `reply/*`; szkicu narzędzie tu nie sprawdza). Na sucho
`finalize` pokazuje to podsumowanie, zanim cokolwiek zmieni.
Archiwum jest poza gitem — są w nim adresy autorów.

Odpowiedzi do autorów domknięcia nie blokują: czekają dalej w szkicach, a
`reply --push` wyśle je, kiedy zechcesz.

## Odpowiedzi do autorów

Odpowiedź do autora czeka w Gmailu jako **szkic w wątku jego zgłoszenia** — to
jej jedyny stan. Etykieta `reply/*` mówi, że czeka, szkic — co pójdzie. Szkice
zakłada `scan --push` (blok o starej apce) i `review --push` (Twój tekst
z przeglądu); `reply --push` tylko je wysyła. Kolejka odpowiedzi jest jedna dla
wszystkich przebiegów i żadnego nie blokuje.

### Pytania do osób dodających

Piosenka bez chwytów nie jest ani „wchodzi”, ani „odrzucona” — jest
**wstrzymana**, dopóki osoba dodająca czegoś nie dośle. Żeby tego nie trzymać
w głowie, w edytorze piszesz odpowiedź od razu przy piosence, a narzędzie
pamięta resztę.

```bash
# 1. w edytorze: gasisz przełącznik + „Brakuje chwytów. Dorzuć je i wejdzie.”
./piosenkomat review --push           # → song/reply/review-note + szkic w wątku
#  …przeglądasz szkic w Gmailu…
./piosenkomat reply --push            # → song/waiting-for-author, przeczytane
#  …osoba dodająca odpisuje z chwytami…
./piosenkomat reopen --push           # zdejmuje song/*, wątek wraca do kolejki
./piosenkomat scan --push             # w kolejnym przebiegu — jak nowe zgłoszenie
```

**Dlaczego `reopen` w ogóle istnieje:** kolejka to „inbox bez `song/*`, po
wątkach”, a odpowiedź wpada do wątku, który etykiety już ma — więc `scan` sam by
jej nie zobaczył. `reopen` szuka wątków z `waiting-for-author`, w których po
naszej ostatniej wiadomości pojawiła się przychodząca (szkice się nie liczą),
i zdejmuje z nich `song/*`. Wątek wraca do kolejki i przechodzi normalny
przesiew, tyle że z nowymi chwytami.

Wątek z `added` albo `ready-to-add` **pomija** — piosenka jest w apce albo
w pliku, „dzięki” od autora to nie zgłoszenie, a poprawkę przysyła się z apki
jako nową. Bloku o starej apce `scan` drugi raz nie dołoży, jeśli poszedł już
w tym wątku.

**Jedna odpowiedź na piosenkę, w jej wątku.** Uwaga jest przy piosence,
a odpowiedź autora wraca do właściwego wątku — `reopen` przywraca dokładnie tę
piosenkę. Kto przysłał cztery piosenki i do każdej dostał uwagę, dostaje cztery
mejle, każdy w swoim wątku.

**Twoja jest tylko sprawa, ramkę dokłada narzędzie.** W polu odpowiedzi piszesz
samą treść („Brakuje chwytów…”). Mejl składa `composeContribReply`
w `harcapp_core`: „Dzięki za piosenki :)” + Twoja odpowiedź + blok o starej apce,
jeśli zgłoszenie z niej przyszło + „Czuwaj!” + stopka pod kreską („Każdą kolejną
piosenkę wyślij proszę osobnym mejlem…”). Edytor pokazuje tę ramkę na szaro nad
polem i pod nim — tą samą funkcją, więc widzisz cały mejl, a ramki nie da się ani
zapomnieć, ani zepsuć. Gwiazdka proponuje samą sprawę z pastylek `missing-*`.

### Stara apka

Najstarsza, nierozwijana wersja apki wysyła mejle w innym formacie: temat
`Piosenka "X"`, JSON owinięty w `{"o!_id": {…}}`, bez zgody na regulamin, bo go
jeszcze nie było. **Format i zgoda to osobne fakty**: zgody nie ma, więc piosenka
dostaje uwagę `no-consent` i w `contributor_data` wpis `brak` — tak samo jak
zgłoszenie z nowszej apki, w którym zgody zabrakło (do wygrepowania, gdyby
trzeba było doprosić o zgodę). Przyjmujesz ją normalnie, przełącznikiem. Mejl
dostaje też etykietę `song/reply/old-app` — chyba że blok poszedł już w tym
wątku (wątek wrócił przez `reopen`).

**Blok „zaktualizuj apkę” (`kOldAppReplyBlock`) jest pod każdym mejlem ze
starej apki — w każdym jej wątku, nigdy raz na autora.** Z tekstem z przeglądu
jedzie w tym samym mejlu, bez tekstu idzie mejl z samym blokiem. Kto przysłał ze
starej apki trzy piosenki, dostaje blok w trzech mejlach, każdym w swoim wątku.
Blok wysłany autorowi w innym wątku (albo wcześniejszym przebiegu) nie zwalnia
z niego nowego zgłoszenia. Wysłany — przez `reply --push` albo ręcznie z Gmaila —
zdejmuje `reply/old-app` tylko ze swojego wątku. Nie zdejmuje
`reply/review-note`: tekst, który nie poszedł, dalej czeka.

Etykietę można ruszać ręcznie: zdjęta znaczy „nie zawracaj mu głowy”, dowieszona
wsadza z powrotem do kolejki — szkic dołoży wtedy `review --push`, o ile wątek
jest w otwartym przebiegu, a inaczej odpisujesz sam.

### Szkice

**Narzędzie rusza tylko szkic, którego nie poprawiałeś w Gmailu:** samą ramkę,
blok o starej apce albo tekst z przeglądu dokładnie taki, jaki samo wpisało — co
wpisało, pamięta w `out/run/drafts.json`. Taki szkic przelicza, gdy zmieni się
plan albo tekst na stronie, i kasuje, gdy odpowiedzi ma nie być. Szkic
poprawiony w Gmailu jest Twój: poprawki nie znikają przy kolejnym
`review --push`, a dopóki przegląd się nie zmieni, narzędzie o nim milczy. Gdy
zmienisz też tekst na stronie, `review` mówi o różnicy wierszem `!` — poprawiasz
szkic w Gmailu albo go kasujesz, a `review --push` założy nowy. Swój szkic
narzędzie poznaje po kształcie: powitanie na początku, pożegnanie i stopka na
końcu (łamanie linii przez Gmaila nie przeszkadza). Szkic w innym kształcie
albo nieczytelny zostaje nietknięty. `unlabel` jest ostrożniejszy: kasuje tylko
szkice bez żadnego tekstu.

**`reply --push` wysyła szkice przez `drafts.send`**, więc to, co poprawisz
w Gmailu, leci w świat, a `reply/*` schodzi (z tekstem z przeglądu →
`waiting-for-author`, przeczytane). Wysyła tylko szkic w naszym kształcie z tym,
na co wątek czeka: przy `reply/review-note` — z jakimkolwiek tekstem poza ramką;
przy samym `reply/old-app` — bez tekstu. Inny szkic (sprzed przeglądu, z Twoim
tekstem z Gmaila wycofanym potem przy przeglądzie, pisany ręcznie, nieczytelny)
zostaje w wątku,
etykiety się nie ruszają, a `reply` mówi, co z nim zrobić. `-n` ogranicza liczbę
mejli w jednym odpaleniu (Gmail tnie ok. 500 na dobę); przerwaną wysyłkę dokańcza
powtórzenie komendy.

Szkicu nie ma, a **ostatnia** wiadomość w wątku to nasza wysłana? Odpisane
ręcznie z Gmaila: `reply --push` tylko przestawia etykiety — drugiego mejla autor
nie dostanie. Szkicu nie ma i nic nie poszło — `reply` to wypisuje; w otwartym
przebiegu szkic odtworzy `review --push`, inaczej odpisujesz ręcznie.

## Osoby dodające

`people.dart` w `out/run/` to gotowe stałe `RegisteredContributor`
w kształcie `lib/values/people/data.dart`, tylko dla osób, których tam jeszcze nie
ma (po adresie). Adres nadawcy jest zawsze pierwszy w `emails`, bo to on siedzi
w `email_ref` piosenki i po nim `ContributorRef.resolve()` znajduje osobę.
Doklejasz na koniec `data.dart`, `data.all.g.dart` przegeneruje pre-commit.

Plik powstaje przy `review --push`, nie przy `scan`, i czyta osoby **z samych
piosenek, które wchodzą** — tych z `final-*.hrcpsng`, już bez wywalonych przy
przeglądzie i bez zgaszonego przełącznika. Dzięki temu łapią się też Twoje poprawki karty
osoby zrobione na stronie. Jedyne, czego piosenka nie niesie, to dodatkowe
adresy z bloku „Osoba dodająca” (`ContributorRef` ma jeden `email_ref`) — te
czekają w `plan.json` i `review` dokłada je po nadawcy.

W komentarzach na końcu pliku:
- **znani z innego adresu** — osoba jest w `data.dart`, ale zgłoszenie przyszło
  z adresu, którego tam nie ma. Adres dopisujesz ręcznie do `emails` jej wpisu
  (komentarz mówi, którego i co), inaczej piosenka nie znajdzie jej po `email_ref`;
- **adresy z różnych wpisów** — adresy nadawcy wskazują dwie różne osoby
  z `data.dart`; narzędzie nie zgaduje, sprawdzasz sam;
- nadawcy już obecni w `data.dart` (nic do dopisania) oraz piosenki bez karty
  osoby (mają tylko `email_ref`, nie ma kogo dopisać).

## Dev

Parser ciągnie `SongRaw`, a ten Fluttera, więc `dart run` nie działa. `./piosenkomat`
odpala pod spodem `flutter test test/cli_harness.dart`, stąd prefiks `Shell:`
w wyjściu. Testy: `flutter test` w `tool/piosenkomat`.

Komendy łączą się ze skrzynką przez `Mailbox` (`mailbox.dart`); `GmailMailbox`
to prawdziwy Gmail, a testy podstawiają `FakeMailbox` (`test/fake_mailbox.dart`)
przez `runPiosenkomat(args, connect: …, root: …)` — `root` to katalog z `out/`
i `archive/`, w testach tymczasowy. Tak `test/run_test.dart` sprawdza cały
przebieg (blokadę, szkice, wysyłkę, `finalize`, `reopen`) bez żywej skrzynki.

Komendy leżą w `lib/commands/`, po pliku na komendę; wspólna baza i `Stop` są
w `command.dart`, a `cli.dart` tylko je spina. Komenda, która nie może iść dalej,
rzuca `Stop` — „STOP.” i kod wyjścia 1 dokłada jedno miejsce. Reguły, które nie
potrzebują skrzynki (co trzyma przebieg otwarty, które zmiany etykiet wolno
wypchnąć, jakie szkice mają być), siedzą przy swoich danych — `plan.dart`,
`review.dart`, `reply.dart`, `model.dart` — i tam mają testy. Polityka to jedna
tabela w `decide.dart`; jej wiersze, po jednym na regułę z [Jak automat
decyduje](#jak-automat-decyduje), sprawdza `test/decide_test.dart` na samych
faktach, bez mejli. Mejl z Gmaila czyta się w całości (`format: raw`)
tym samym czytnikiem MIME (`eml.dart`), co pliki `.eml` w `explain`: charsety
(UTF-8, ISO-8859-1/2, windows-1250) i nagłówki RFC 2047. Mejl, którego nie da
się rozebrać, idzie jako „nie do odczytania”, zamiast przerywać `scan`.

Jedna nazwa na jedną rzecz: żadnych aliasów komend, ukrytych synonimów flag ani
czytania plików pod starymi nazwami. Komendy są tylko te z pomocy, pisze wyłącznie
`--push`, przebieg leży w `out/run/`, a jego plan nazywa się `plan.json`.
