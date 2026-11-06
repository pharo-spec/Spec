## Where to find correct information
## Where to find correct information

1. **Book index first.** Read
   `https://github.com/SquareBracketAssociates/BuildingApplicationWithSpec2/BOOK-INDEX.md`
   - Search its `Solves:` lines for the problem, or its `API:` names and the reverse index at the end for a class or selector.
   - Then open only the matching chapter file at the quoted `###` section heading
     (`grep -n '^### <heading>' Chapters/<Chapter>/<file>.md`), not the whole book.
   - Always read the chapter's `Stale:` line before reusing book code
     (e.g. `addKeybindingsTo:` is now `addKeyBindingsTo:`; `SpDialogPresenter` does not exist).
   - The book's own classes (`Imdb…`, `Mail…`, `Todo…`) are not in the image; their code is in
     https://github.com/SquareBracketAssociates/CodeOfSpec20Book.
2. **Image examples for the current API.** Use the `Image examples:` line of the index:
   - class-side `example…` methods of the widget presenters (`SpTablePresenter class>>exampleSorting`, …);
   - presenters of the `Spec2-Examples` package, gathered by `SpDemo open`.
   - subclasses of SpPresenter give concrete examples of exciting tools.
   Read their source in the image before imitating them. Many `example…` methods open a window
   instead of answering an instance; do not run them in tests.
3. **The image decides.** The book is the reference for design, the image for API names.
   When they disagree, follow the image and say so. If an index entry is wrong, tell the user and
   propose the fix to `BOOK-INDEX.md`.
4. Topics the book does not cover (actions API `addActionWith:`/`addShortcutWith:`/`SpAction`,
   `SpListViewPresenter`): use the image examples listed at the end of the index.

## Rules for Spec UI code

- Stay backend-neutral: presenters, layouts, actions, transmissions, commands and styles only.
  Presenter and menu code MUST NOT reference Morphic or Toplo; only adapters do.
  Mention a backend only when choosing or configuring it in the application configuration.
- Structure a presenter with the three hooks `initializePresenters`, `connectPresenters` and
  `defaultLayout` (book: ThreePillarsOfSpec); use `SpPresenterWithModel` when the presenter shows a domain object.
- Open tools and other presenters through the application (`self application newPresenter:`,
  `toolNamed:`), not through globals.
- Test interaction logic on presenters without opening windows when possible (book: TestingInSpec);
  close any window a test opens
