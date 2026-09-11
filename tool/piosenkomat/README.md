# piosenkomat

Przesiewa mejle z piosenkami na `harcapp@gmail.com`. Kompletne nowe piosenki
trafiają do pliku `.hrcpsng` do wczytania na stronie, a mejle dostają te same
etykiety, których używasz przy ręcznym przeglądaniu, plus znacznik `song/auto`.
Parsowaniem zajmuje się `parseContribEmail` z `harcapp_core`, nic tu nie zgaduje.

## Przebieg krok po kroku

1. **Przesiew.**  
   `./piosenkomat scan -n 20`  
   ####
   Czyta kolejkę (inbox bez `song/*`), parsuje, wykrywa duplikaty i zapisuje
   katalog `out/import-<data>/`: `report.txt`, plan etykiet `labels.json`,
   a przy imporcie `songs.hrcpsng`, `reviewed.hrcpsng` i `people.dart`.
   Gmaila tylko czyta — `scan` nigdy niczego nie etykietuje. `-n` pomiń, żeby
   wziąć całą kolejkę; `--newest` bierze najnowsze zamiast najstarszych;
   `-o` wskazuje własny katalog przebiegu.
   ####
2. **Etykiety automatu.**  
   `./piosenkomat label scanned --write`  
   ####
   Wiesza werdykty z `labels.json`: `ready-to-add`, `rejected/…`,
   `needs-review/…`, `old-app/to-reply`, każdy ze znacznikiem `song/auto`.  
   Pomija mejle, które w międzyczasie dostały już jakąś etykietę `song/*`.  
   Pomyłka? `./piosenkomat unlabel --write` cofa cały przebieg.
   ####
3. **Przegląd na stronie.**  
   *(ręcznie)*  
   ####
   Wczytujesz `out/import-<data>/songs.hrcpsng` na stronie ze śpiewnikiem,
   wyrzucasz co niepotrzebne, poprawiasz co trzeba, eksportujesz z powrotem
   i podmieniasz eksportem `out/import-<data>/reviewed.hrcpsng`.
   ####
4. **Odrzucenia z przeglądu.**  
   `./piosenkomat label reviewed --write`  
   ####
   Porównuje `songs.hrcpsng` z `reviewed.hrcpsng`: czego nie ma w tym drugim,
   traci `ready-to-add` i dostaje `rejected/after-review`. Zatwierdzone zostają
   bez zmian. Bez `--write` tylko pokazuje różnicę.
   ####
5. **Osoby dodające.**
   *(ręcznie)*  
   ####
   Doklejasz `out/import-<data>/people.dart` na koniec `lib/values/people/data.dart`.  
   Po kroku 4, bo dopiero on mówi, czyje piosenki wypadły i kogo nie ma po co dopisywać.
   ####
6. **Piosenki do śpiewnika aplikacji.**  
   *(ręcznie)*  
   ####
   Zatwierdzone piosenki muszą trafić do `assets/songs/all_songs.hrcpsng` i do
   commita. Dopóki tam nie są, `label added` z kroku 7 kłamie (mejl zamknięty,
   piosenki w apce nie ma), a następny `scan` nie rozpozna ich jako duplikatów.
   ####
7. **Domknięcie mejli.** 
   `./piosenkomat label added --write`  
   ####
   `ready-to-add` + `auto` → `added` i oznaczenie jako przeczytane. Rusza
   wyłącznie mejle, które automat sam wstawił do pliku; Twoje ręczne
   „ready-to-add” zostają nietknięte.

Osobno, kiedy chcesz: `./piosenkomat reply --write` — odpowiedzi autorom ze
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
./piosenkomat label scanned --write      # nadaje etykiety
./piosenkomat label reviewed --write     # → „rejected/after-review”
./piosenkomat label added --write        # → „added” + przeczytane
./piosenkomat unlabel --write            # cofa etykiety całego przebiegu
./piosenkomat reply                      # kto czeka na „zaktualizuj apkę”
./piosenkomat reply --write              # wyślij; → „old-app/replied”
./piosenkomat explain plik.eml           # klasyfikacja lokalnego pliku, bez Gmaila
```

Bez `--write` nic w Gmailu się nie zmienia — `scan` i `explain` nie mają tej flagi,
bo nie piszą do skrzynki nigdy. Komendy operujące na przebiegu biorą bez argumentu
**ostatni** katalog z `out/`; własny wskażesz, podając go wprost:
`./piosenkomat label scanned out/import-<data> --write`.

`label scanned` nadaje plan także długo po `scan`, bez ponownego czytania mejli.
`unlabel` jest jego odwrotnością: zdejmuje dokładnie te etykiety, które nadał ten
przebieg, i zostawia w spokoju mejle, które od tamtej pory ruszyły dalej
(`--force`, żeby i je cofnąć).

Stare nazwy (`process`, `apply`, `review`, `commit`, `unapply`, `check`) oraz flaga
`--apply` dalej działają jako ciche aliasy, ale nie ma ich w pomocy.

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
├── add-contributor           „wpisać osobę dodającą do apki”, tylko Ty
├── rejected/
│   ├── already-in-app        automat: ten sam tytuł i tekst, co w śpiewniku
│   ├── duplicate             automat: ten sam tytuł i tekst, co starsze zgłoszenie w paczce
│   ├── after-review          automat zaproponował, Ty wyrzuciłeś na stronie (`label reviewed`)
│   ├── no-chords             tylko Ty
│   ├── silly                 tylko Ty (kiedyś LLM)
│   └── too-niche             tylko Ty (kiedyś LLM)
├── needs-review/             automat spasował; podkategoria na każdy powód
│   ├── user-message          ktoś coś dopisał
│   ├── possible-duplicate    podobna treść albo ten sam tytuł z inną treścią
│   ├── missing-data          brak YouTube, chwytów lub tytułu
│   ├── no-consent            brak zgody albo nadawcy
│   ├── correction            poprawka istniejącej piosenki
│   ├── reply                 odpowiedź w wątku
│   └── unparsable            błąd parsowania albo temat spoza szablonów apki
├── old-app/                  ZNACZNIK: mejl z najstarszej, nierozwijanej apki
│   ├── to-reply              kolejka: autorowi trzeba odpisać (`reply`)
│   └── replied               odpowiedź poszła
└── auto                      ZNACZNIK: tę etykietę stanu nadał automat
```

Zasady:

- Kolejka to zgłoszenia piosenek (temat `Nowa piosenka` / `Poprawka piosenki` albo
  `### Kod piosenki:` w treści) w `in:inbox` bez żadnej etykiety `song/*`. Innych mejli
  narzędzie nie czyta i nie etykietuje. Gmail jest jedynym stanem.
- `song/auto` zawsze towarzyszy jednej etykiecie stanu. Twoje decyzje to te bez `Auto`.
- Automat odrzuca sam tylko, gdy **jedynym** powodem jest identyczna piosenka
  w śpiewniku albo identyczna w paczce. Każdy inny powód, także w połączeniu, daje
  `needs-review` plus podkategorię na każdy powód (mejl może mieć kilka).
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

## Warunki auto-importu

Wszystkie muszą być spełnione, inaczej mejl idzie do `needs-review` albo `rejected/…`:

- mejl się parsuje,
- temat pasuje do szablonu apki (`Nowa piosenka`, albo `Piosenka` ze starej wersji),
  nie jest poprawką ani odpowiedzią na inny mejl,
- miejsce na własną wiadomość jest puste,
- jest tytuł, chwyty i YouTube,
- jest zgoda z wersją regulaminu (poza starą apką, patrz niżej), a nadawca to nie
  skrzynka HarcApp,
- nie jest duplikatem (patrz niżej).

`contributor_data` dostaje adres nadawcy, datę mejla i wersję regulaminu z mejla.
Brak chwytów czy YouTube blokuje tak samo w każdej wersji apki — automat niczego
nie dopisuje za autora.

## Duplikaty

Tytuły porównywane po normalizacji jak w wyszukiwarce na stronie. Teksty jako zbiory słów,
indeks Jaccarda; kolejność zwrotek i wielkość liter bez znaczenia. Dwa progi: 90% to
„ta sama piosenka”, 50% to „podejrzanie podobna”.

| Tytuł | Tekst | Efekt |
|---|---|---|
| jak w śpiewniku | ≥ 90% | `rejected/already-in-app`, automat |
| jak w śpiewniku | < 90% | `needs-review/possible-duplicate` |
| inny | ≥ 50% do czegoś w śpiewniku | `needs-review/possible-duplicate` z nazwą pierwowzoru |
| jak starsze zgłoszenie w paczce | ≥ 90% | `rejected/duplicate`, starsze wchodzi |
| jak inne zgłoszenie w paczce | < 90% | oba `needs-review/possible-duplicate` |
| inny niż w paczce | ≥ 50% do innego zgłoszenia | oba `needs-review/possible-duplicate` |

Porównania w paczce dotyczą tylko kandydatów, którzy przeszli resztę warunków. Duplikat
wysłany w innym przebiegu wyjdzie dopiero, gdy pierwsza wersja będzie w `all_songs.hrcpsng`.
W raporcie przy każdym trafieniu jest procent i tytuł pierwowzoru.

## Przegląd (`label reviewed`)

`scan` obok `songs.hrcpsng` zostawia jego kopię jako `reviewed.hrcpsng`.
Po przejrzeniu piosenek na stronie eksportujesz to, co zostało, i podmieniasz nim
`reviewed.hrcpsng`. `label reviewed` porównuje oba pliki: czego nie ma w `reviewed`,
to odrzucone — mejl traci „ready-to-add” i dostaje `rejected/after-review`.
Bez `--write` tylko pokazuje różnicę. Ślad decyzji ląduje w `review.json`.

Piosenki wiąże ze zgłoszeniami `email_msg_id` w `contributor_data` — automat
wpisuje tam id mejla, więc poprawiony przy przeglądzie tytuł niczego nie psuje.
Gdyby strona to pole zgubiła, `label reviewed` schodzi po kolei na id piosenki, tytuł
i wreszcie tekst (ten sam próg, co przy duplikatach). Czego nie umie związać
z przebiegiem, zostawia w spokoju i wypisuje jako pominięte.

Bezpieczniki: pusty `reviewed.hrcpsng` albo odrzucona ponad połowa przebiegu
przerywają robotę — to prawie zawsze znaczy, że podmieniony został nie ten plik.
`--force`, jeśli naprawdę tak ma być. Etykiety zmienia tylko na mejlach, które
dalej mają „ready-to-add” i „auto”.

Mejl to dziś jedna piosenka. Gdyby kiedyś niósł kilka, `label reviewed` odetykietuje go
tylko wtedy, gdy wypadną wszystkie — przy części wypisze ostrzeżenie i zostawi
decyzję Tobie.

## Osoby dodające

W katalogu przebiegu, obok `songs.hrcpsng`, powstaje `people.dart` z gotowymi stałymi `RegisteredContributor`
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
