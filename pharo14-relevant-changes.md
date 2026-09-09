# Pharo14 Relevant Spec Changes

This summary covers the `Pharo14` branch in `pharo-spec/Spec`, using the divergence from `Pharo13` as the start point.

- Merge base: `0438768`, merged on 2025-05-21.
- First branch-specific commit: `ed95ff53`, committed on 2025-05-23.
- Current checked HEAD: `553f463`, merged on 2026-05-27.
- Scope inspected: 315 commits and 82 merged PRs targeting `Pharo14`.

Sources:

- [GitHub compare: `Pharo13...Pharo14`](https://github.com/pharo-spec/Spec/compare/Pharo13...Pharo14)
- [Merged PRs targeting `Pharo14`](https://github.com/pharo-spec/Spec/pulls?q=is%3Apr+base%3APharo14+merged%3A%3E%3D2025-05-23)

## Summary 

Not many major changes.

Raw volume is not tiny: 315 commits, 82 merged PRs. But most are fixes, deprecation rewrites, cleanup, test
adjustments, and small API polish.

The genuinely relevant areas are basically:

- code editor / code presenter work
- refactoring command migration
- Morphic layout fixes
- list/tree/filtering behavior
- dialog/window/modal behavior
- action/command cleanup
- Pharo 14 compatibility/deprecation cleanup

So I’d characterize it as: moderate branch activity, but only a handful of real feature/API themes.

## Relevant Changes

### Branch Setup And Baseline

1. Pharo 14 branch setup: workflows were moved to P14, with early baseline/dependency setup such as Alexandrie packages.
   Sources: [compare](https://github.com/pharo-spec/Spec/compare/Pharo13...Pharo14)

### Styling And List Presenters

2. List and easy-list styling: list row, intercell, and color styles were added, with easy-list style plumbing connected to content views.
   Sources: [#1774](https://github.com/pharo-spec/Spec/pull/1774), [#1775](https://github.com/pharo-spec/Spec/pull/1775)

3. Filtering and sortable presenters: filtering list ports, filter-change events, filtering selectable list rewrite, and sortable string table/column fixes were integrated.
   Sources: [#1804](https://github.com/pharo-spec/Spec/pull/1804), [#1791](https://github.com/pharo-spec/Spec/pull/1791), [#1888](https://github.com/pharo-spec/Spec/pull/1888), [#1885](https://github.com/pharo-spec/Spec/pull/1885)

### Window, Dialog, And Modal Behavior

4. Modal/window lifecycle: modal resize and will-close announcements were fixed, `SpWindowMorph` was introduced, and modal testing support was added.
   Sources: [#1776](https://github.com/pharo-spec/Spec/pull/1776), [#1777](https://github.com/pharo-spec/Spec/pull/1777)

5. Dialog/API cleanup: standard dialogs were refactored, `SpInformUserDialog` was aligned with the `Sp**Dialog` API, and `SpSelectMultipleDialog>>openModal` now returns selected items.
   Sources: [#1840](https://github.com/pharo-spec/Spec/pull/1840), [#1899](https://github.com/pharo-spec/Spec/pull/1899), [#1855](https://github.com/pharo-spec/Spec/pull/1855)

### Tree And Selection Behavior

6. Tree/list selection behavior: tree `selectAll`, tree path selection fixes, root-update selection preservation, and chooser value-change announcements were added or fixed.
   Sources: [#1785](https://github.com/pharo-spec/Spec/pull/1785), [#1803](https://github.com/pharo-spec/Spec/pull/1803), [#1859](https://github.com/pharo-spec/Spec/pull/1859), [#1871](https://github.com/pharo-spec/Spec/pull/1871)

### Layout And Morphic Backend Fixes

7. Morphic layout correctness: BoxLayout fixed-size behavior, border/spacing extent calculations, and related regression tests were fixed or added.
   Sources: [#1813](https://github.com/pharo-spec/Spec/pull/1813), [#1817](https://github.com/pharo-spec/Spec/pull/1817), [#1820](https://github.com/pharo-spec/Spec/pull/1820), [#1825](https://github.com/pharo-spec/Spec/pull/1825), [#1843](https://github.com/pharo-spec/Spec/pull/1843)

### Code Presenter And Refactoring Commands

8. Code presenter/editor work: node selection, high-level `SpCodeEditorPresenter`, dirty/conflict state, and bindings exposure were introduced.
   Sources: [#1889](https://github.com/pharo-spec/Spec/pull/1889), [#1891](https://github.com/pharo-spec/Spec/pull/1891), [#1896](https://github.com/pharo-spec/Spec/pull/1896)

9. Spec refactoring commands: refactoring commands were migrated onto Spec/code presenter APIs, then cleaned up with command visibility handling and tests.
   Sources: [#1892](https://github.com/pharo-spec/Spec/pull/1892), [#1894](https://github.com/pharo-spec/Spec/pull/1894), [#1895](https://github.com/pharo-spec/Spec/pull/1895)

### Actions, Commands, And Toolbars

10. Actions, command groups, and toolbar behavior: priorities, IDs, dynamic groups, submenu toolbar behavior, and command naming cleanup were added.
    Sources: [#1856](https://github.com/pharo-spec/Spec/pull/1856), [#1867](https://github.com/pharo-spec/Spec/pull/1867), [#1868](https://github.com/pharo-spec/Spec/pull/1868), [#1884](https://github.com/pharo-spec/Spec/pull/1884)

### Integration Cleanup And Deprecations

11. Pharo integration cleanup: extensions were reduced or moved, duplicate overrides removed, unused/empty classes removed, and deprecation rewrites applied.
    Sources: [#1811](https://github.com/pharo-spec/Spec/pull/1811), [#1821](https://github.com/pharo-spec/Spec/pull/1821), [#1865](https://github.com/pharo-spec/Spec/pull/1865), [#1903](https://github.com/pharo-spec/Spec/pull/1903), [#1913](https://github.com/pharo-spec/Spec/pull/1913)

### CLI, Non-Interactive Use, And Tests

12. CLI/non-interactive behavior: the command-line runner moved to Clap, `inform:` was made safe for non-interactive images, and evaluation error handling was fixed.
    Sources: [#1819](https://github.com/pharo-spec/Spec/pull/1819), [#1844](https://github.com/pharo-spec/Spec/pull/1844), [#1915](https://github.com/pharo-spec/Spec/pull/1915)

13. Backend-agnostic tests: test suites were moved away from direct Morphic/widget assumptions where possible.
    Sources: [#1874](https://github.com/pharo-spec/Spec/pull/1874), [#1879](https://github.com/pharo-spec/Spec/pull/1879)
