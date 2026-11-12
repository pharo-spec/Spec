## Where to find correct information

"The image" below means a running Pharo image with Spec loaded (for example reached through a Pharo MCP
server, or a Playground). No local copy of the book is needed: everything else is read from GitHub.

1. **Book index first.** Read the index of the book *Application Building with Spec 2.0*:
   https://raw.githubusercontent.com/SquareBracketAssociates/BuildingApplicationWithSpec2/master/BOOK-INDEX.md
   (repository https://github.com/SquareBracketAssociates/BuildingApplicationWithSpec2).
   - Search its `Solves:` lines for the problem, or its `API:` names and the reverse index at the end for a class or selector.
   - Each chapter entry gives the chapter file path (e.g. `Chapters/LayoutContruction/Layout.md`). Read only that file, from
     `https://raw.githubusercontent.com/SquareBracketAssociates/BuildingApplicationWithSpec2/master/<path>`,
     and only the quoted `###` section, not the whole book. For example:
     ```
     curl -s https://raw.githubusercontent.com/SquareBracketAssociates/BuildingApplicationWithSpec2/master/Chapters/Menus/Menus.md | grep -n '^### '
     ```
     lists the section headings with their line numbers. With a local clone of the book, use
     `grep -n '^### <heading>' Chapters/<Chapter>/<file>.md` instead.
   - Always read the chapter's `Stale:` line before reusing book code
     (e.g. `addKeybindingsTo:` is now `addKeyBindingsTo:`; `SpDialogPresenter` does not exist).
   - The book's own classes (`Imdb…`, `Mail…`, `Todo…`) are not in the image; their code is in
     https://github.com/SquareBracketAssociates/CodeOfSpec20Book.
2. **Image examples for the current API.** Use the `Image examples:` line of the index:
   - class-side `example…` methods of the widget presenters (`SpTablePresenter class>>exampleSorting`, …);
   - presenters of the `Spec2-Examples` package, gathered by `SpDemo open`.
   - the `SpPresenter` subclasses of the `NewTools-*` packages, always loaded since they are the IDE tools
     (inspector, debugger, playground, finder, settings browser, …): real, well-written Spec applications.
   Read their source in the image before imitating them. Many `example…` methods open a window
   instead of answering an instance; do not run them in tests.
3. **The image decides.** The book is the reference for design, the image for API names.
   When they disagree, follow the image and say so. If an index entry is wrong, report it
   (issue or pull request on the book repository) with the fix to `BOOK-INDEX.md`.
4. Topics the book does not cover (actions API `addActionWith:`/`addShortcutWith:`/`SpAction`,
   `SpListViewPresenter`): use the image examples listed at the end of the index.

## Rules for Spec UI code

- Stay backend-neutral: presenters, layouts, actions, transmissions, commands and styles only.
  Presenter and menu code MUST NOT reference Morphic or Toplo; only adapters do.
  Mention a backend only when choosing or configuring it in the application configuration.
- Structure a presenter with the three hooks `initializePresenters`, `connectPresenters` and
  `defaultLayout` (book: ThreePillarsOfSpec); use `SpPresenterWithModel` when the presenter shows a domain object.
- Open other presenters through the application (`self application instantiate:`), not through globals;
  create subpresenters with `self instantiate:` or a `newXxx` factory, never with `new` or `on:`.
- `toolNamed:` is for the Pharo IDE only: it is answered by `StPharoApplication`, so only IDE tools
  (`St…` presenters of the `NewTools-*` packages) use it. Presenters of other applications must not use it.
- Test interaction logic on presenters without opening windows when possible (book: TestingInSpec);
  close any window a test opens.
- Check new or changed presenters with the `Spec2-Rules` critiques (group 'Spec'), for example
  `(MyPresenter >> #defaultLayout) critiques` or `ReSmalllintChecker` on the package, and fix what they report.
