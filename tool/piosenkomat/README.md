# piosenkomat

Przesiewa mejle z piosenkami na `harcapp@gmail.com`. Kompletne nowe piosenki
trafiają do pliku `.hrcpsng` do wczytania na stronie, a mejle dostają te same
etykiety, których używasz przy ręcznym przeglądaniu, plus znacznik `song/auto`.
Parsowaniem zajmuje się `parseContribEmail` z `harcapp_core`, nic tu nie zgaduje.

## Setup (raz)

1. Google Cloud: włącz Gmail API, utwórz klienta OAuth typu **Desktop**.
2. Pobrany JSON zapisz jako `tool/piosenkomat/secrets/credentials.json` (katalog jest w `.gitignore`).
3. Pierwsze uruchomienie otworzy przeglądarkę. Zaloguj się na `harcapp@gmail.com`.
   Token ląduje w `tool/piosenkomat/secrets/gmail_token.json`. Zakres: `gmail.modify`.
4. W Gmailu zmień nazwy istniejących etykiet na te z drzewa niżej (zmiana nazwy
   zachowuje etykietę na mejlach). Nazwy muszą zgadzać się co do znaku z `lib/model.dart`. Małe litery i myślniki, bez spacji, dzięki czemu nazwa w pasku i w `label:` są identyczne.

Uruchamiaj z korzenia repo przez `./piosenkomat`. Ścieżki `secrets/` i `out/` są względem `tool/piosenkomat/`.

## Użycie

```bash
./piosenkomat process -n 20            # podgląd: 20 najstarszych z kolejki + pliki, Gmail nietknięty
./piosenkomat process -n 20 --apply    # to samo + etykiety
./piosenkomat apply out/import-<data>.labels.json --apply   # etykiety z wcześniejszego podglądu
# wczytaj out/import-<data>.hrcpsng na stronie;
# doklej out/import-<data>.people.dart do lib/values/people/data.dart;
# odrzucone przenieś w Gmailu z „ready-to-add” do „rejected/…”
./piosenkomat commit                   # lista tego, co automat wstawił do pliku
./piosenkomat commit --apply           # → „added” + przeczytane
./piosenkomat check plik.eml           # klasyfikacja lokalnego pliku, bez Gmaila
```

Bez `--apply` nic w Gmailu się nie zmienia. Każdy `process` zapisuje plan etykiet
`out/import-<data>.labels.json`; `apply` nadaje go później bez ponownego czytania mejli,
pomijając te, które w międzyczasie dostały już etykietę `song/*`. `-n` pomiń, żeby wziąć całą kolejkę;
`--newest` bierze najnowsze zamiast najstarszych.

## Etykiety

```
song/
├── ready-to-add              w pliku, czeka na commit (albo Twoja ręczna)
├── added                     koniec
├── add-contributor           „wpisać osobę dodającą do apki”, tylko Ty
├── rejected/
│   ├── already-in-app        automat: ten sam tytuł i tekst, co w śpiewniku
│   ├── duplicate             automat: ten sam tytuł i tekst, co starsze zgłoszenie w paczce
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
│   └── unparsable            błąd parsowania, stary format, temat nie o piosence
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
- `commit` dotyka wyłącznie mejli z `ready-to-add` **i** `auto`. Twoje ręczne
  „ready-to-add” czekają na Ciebie jak dotąd.

Przydatne zapytania:

| Co | Zapytanie |
|---|---|
| wszystko, co rozpatrzył automat | `label:song/auto` |
| dodane przez automat | `label:song/added label:song/auto` |
| dodane przez Ciebie | `label:song/added -label:song/auto` |
| automatyczne odrzucenia do wyrywkowej kontroli | `label:song/rejected label:song/auto` |

## Warunki auto-importu

Wszystkie muszą być spełnione, inaczej mejl idzie do `needs-review` albo `rejected/…`:

- mejl się parsuje i nie jest ze starej wersji apki,
- temat zawiera `Nowa piosenka`, nie jest poprawką ani odpowiedzią na inny mejl,
- miejsce na własną wiadomość jest puste,
- jest tytuł, chwyty i YouTube,
- jest zgoda z wersją regulaminu, a nadawca to nie skrzynka HarcApp,
- nie jest duplikatem (patrz niżej).

`contributor_data` dostaje adres nadawcy, datę mejla i wersję regulaminu z mejla.

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

## Osoby dodające

Obok `.hrcpsng` powstaje `.people.dart` z gotowymi stałymi `RegisteredContributor`
w kształcie `lib/values/people/data.dart`, tylko dla osób, których tam jeszcze nie ma
(sprawdzane po adresie). Adres nadawcy jest zawsze pierwszy w `emails`, bo to on siedzi
w `email_ref` piosenki i po nim `ContributorRef.resolve()` znajduje osobę. Doklejasz
plik na koniec `data.dart`, `data.all.g.dart` przegeneruje pre-commit.

W komentarzach na końcu pliku: nadawcy już obecni w `data.dart` oraz piosenki bez bloku
„Osoba dodająca” (te mają tylko `email_ref`, nie ma kogo dopisać).

## Dev

Parser ciągnie `SongRaw`, a ten Fluttera, więc `dart run` nie działa. `./piosenkomat`
odpala pod spodem `flutter test test/cli_harness.dart`, stąd prefiks `Shell:`
w wyjściu. Testy: `flutter test` w `tool/piosenkomat`.
