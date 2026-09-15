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
   `rejected/after-review`; z odpowiedzią → `contributor/to-ask`.
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
   (bez `auto`) zostają nietknięte.
   ####
8. **Sprzątanie.**  
   `./piosenkomat clean --push`  
   ####
   Kasuje katalog przebiegu, gdy nic już na niego nie czeka. Sam sprawdza
   w Gmailu, czy werdykty, odpowiedzi do osób dodających i kolejka starej apki są
   domknięte — jeśli nie, odmawia i mówi, co wisi.

Osobno, kiedy chcesz: `./piosenkomat reply --push` — odpowiedzi autorom ze
starej apki → [Stara apka](#stara-apka-reply).

## Komendy

| komenda | co robi | Gmail |
|---|---|---|
| `scan [-n N] [--newest] [-o KATALOG]` | przesiew N najstarszych (bez `-n` — całej kolejki; `--newest` — najnowszych) | czyta |
| `explain plik.eml` | klasyfikacja lokalnego pliku | nie dotyka |
| `label scanned [KATALOG]` | pokazuje plan przebiegu z `plan.json` | czyta |
| `label reviewed [KATALOG]` | pokazuje decyzje z `reviewed-*` | czyta |
| `label added [KATALOG]` | pokazuje, co domknie | czyta |
| `unlabel [KATALOG]` | pokazuje, co cofnie | czyta |
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
├── contributor/              napisałeś coś osobie dodającej przy przeglądzie
│   ├── to-ask                kolejka: mejl do wysłania (`reply`)
│   └── asked                 poszło; czekamy na odpowiedź (`reopen`)
├── old-app/                  ZNACZNIK: mejl z najstarszej, nierozwijanej apki
│   ├── to-reply              kolejka: autorowi trzeba odpisać (`reply`)
│   ├── drafted               szkic czeka w wątku na Twoje oko; wisi OBOK to-reply
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
- Jedyny wyjątek od „`song/*` = poza kolejką”: `old-app/replied`. To znacznik
  o nadawcy (dostał już odpowiedź), nie stan zgłoszenia — wątek z samą tą
  etykietą jest w kolejce.
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
| `similarText` | inny tytuł, tekst ≥ 50% | uwaga `similar-text-in-app` | kandydat; cel zgadnięty tylko przy tekście ≥ 90%, inaczej `no-target-in-app` |
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

`correction_target` — którą piosenkę w apce poprawia — bierze się **z mejla**:
apka wysyła sekcję `### Poprawiana piosenka:` z id w bloku ``` (klienty łamią
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
| ✓ | jest | `ready-to-add` + `contributor/to-ask` |
| ✗ | — | `rejected/after-review`, przeczytane |
| ✗ | jest | `contributor/to-ask`, **nie** `rejected` — piosenka może wrócić z chwytami |
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
nie wiszą w `ready-to-add`, `needs-review/*`, `contributor/to-ask` ani
`old-app/to-reply`. Wiszą → odmawia i wypisuje, ile czego (`--force` przechodzi).
Nie wiszą → katalog leci, bo cały ślad jest już w Gmailu.

## Pytania do osób dodających

Piosenka bez chwytów nie jest ani „wchodzi”, ani „odrzucona” — jest
**wstrzymana**, dopóki osoba dodająca czegoś nie dośle. Żeby tego nie trzymać w głowie,
w edytorze piszesz odpowiedź od razu przy piosence, a narzędzie pamięta resztę.

```bash
# 1. w edytorze: gasisz przełącznik + „Brakuje chwytów. Dorzuć je i wejdzie.”
./piosenkomat label reviewed --push   # → song/contributor/to-ask, nieprzeczytane
./piosenkomat reply --draft --push    # szkic w wątku
#  …przejrzysz w Gmailu…
./piosenkomat reply --push            # → song/contributor/asked
#  …osoba dodająca odpisuje z chwytami…
./piosenkomat reopen --push           # zdejmuje song/*, wątek wraca do kolejki
./piosenkomat scan                    # przesiewa go jak nowe zgłoszenie
```

**Dlaczego `reopen` w ogóle istnieje:** kolejka to „inbox bez `song/*`, po
wątkach”, a odpowiedź wpada do wątku, który etykiety już ma — więc
`scan` sam by jej nie zobaczył. `reopen` szuka wątków z `contributor/asked`,
w których po naszej ostatniej wiadomości pojawiła się przychodząca (szkice
się nie liczą), i zdejmuje z nich `song/*`. Wątek wraca do kolejki i przechodzi
normalny przesiew, tyle że z nowymi chwytami.

Dwa wyjątki. Wątek z `added` **pomija** — piosenka jest w apce, „dzięki” od
autora to nie zgłoszenie, a poprawkę przysyła się z apki jako nową.
`old-app/replied` **zostawia** — to jedyna etykieta `song/*`, która nie
wyłącza z kolejki, bo mówi o nadawcy, nie o zgłoszeniu; dzięki niej `scan`
nie zapyta o starą apkę drugi raz.

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
do wygrepowania, gdybyś chciał doprosić o zgodę), a mejl etykietę `song/old-app/to-reply`.

Ta etykieta jest kolejką odpowiedzi i jedynym źródłem prawdy, komu nie odpisano.
Jedna odpowiedź na autora, nie na mejl: kto przysłał pięć piosenek, dostaje jeden
mejl w najnowszym wątku, a `to-reply` schodzi ze wszystkich pięciu i wchodzi
`replied`. Przerwany przebieg dokańcza powtórzenie komendy. Treść:
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

Żeby zobaczyć mejl przed wysyłką, rozbij `reply` na dwa kroki:

```bash
./piosenkomat reply --draft --push   # szkice w wątkach, nikt nic nie dostaje
#  …przejrzyj i popraw w Gmailu…
./piosenkomat reply --push           # wysyła gotowe szkice, z Twoimi poprawkami
```

Rozmyśliłeś się? `./piosenkomat reply --undraft --push` kasuje szkice i zdejmuje
`drafted`. Nikt nic nie dostał, więc autorzy zostają w kolejce `to-reply`.

`--draft` wiesza `old-app/drafted` **obok** `to-reply`, nie zamiast: skoro nikt
nic nie dostał, autor zostaje w kolejce. Drugi `--draft` pomija tych, co szkic
już mają — po etykiecie, a gdyby ta zeszła (`unlabel`), po samym szkicu
w wątku. Wysyłka idzie przez `drafts.send`, więc to, co poprawisz w Gmailu,
leci w świat; obie etykiety schodzą i wchodzi `replied`.

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
