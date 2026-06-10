# Contributing

We welcome contributions! This document provides guidelines for
contributing to documenteR.

## Submitting Bugs

### Before Submitting

Before submitting a bug report, please do the following:

- **Make sure you’re on the latest version.** Your problem may have been
  solved already.
- **Try older versions.** If you’re on the latest release, try rolling
  back a few minor versions to help narrow down when the problem first
  arose.
- **Search the project’s issue tracker** to make sure it’s not a known
  issue.

### Bug Report Contents

Make sure your report includes:

- **Operating system:** Windows? macOS? Linux? Include version details.
- **R version:** Output from `R.version.string` or
  [`sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html).
- **Package version:** Output from `packageVersion("documenteR")`.
- **RStudio version:** If the addin is involved, include your RStudio
  build.
- **Installation method:** r-universe, GitHub
  ([`devtools::install_github`](https://devtools.r-lib.org/reference/install-deprecated.html)),
  or source.
- **Steps to reproduce:** Include a minimal example, the command or
  addin steps you used, and the full output or error message.

## Contributing Changes

### Licensing

By contributing to this project, you agree that your contributions will
be licensed under the same terms as the rest of the project (see the
`LICENSE` file in the repository root).

- Per-file copyright/license headers are typically not needed. Please
  don’t add your own copyright headers to new files unless the project’s
  license actually requires them.

### Version Control

- **Always make a new branch** for your work, no matter how small.
- **Don’t submit unrelated changes in the same branch/pull request.**
- **Base your branch on `main`** for new features and most bug fixes.
- If your PR has been sidelined for a while, **rebase or merge to latest
  `main`** before resubmitting.

### Code Formatting

- **Follow the style used in the repository.** Consistency with the rest
  of the project always trumps other considerations.
- Use snake_case for functions and variables, `<-` for assignment, and
  2-space indentation.

### Documentation

Documentation is required for all contributions:

- **Roxygen2 comments** must be created or updated for exported
  functions.
- **README or pkgdown docs** should be updated when user-facing behavior
  changes.
- **Changelog entry** should credit the contributor when the change is
  user-visible.

### Tests

Tests are required for all contributions:

- **Bug fixes** must include a test proving the existence of the bug
  being fixed.
- **New features** must include tests proving they actually work.
- Run
  [`devtools::test()`](https://devtools.r-lib.org/reference/test.html)
  locally before opening a pull request.

## Workflow Example

Here’s an example workflow for contributing:

### Preparing Your Fork

1.  Fork the repository on GitHub.
2.  Clone your fork: `git clone git@github.com:yourname/documenteR.git`
3.  `cd documenteR`
4.  Install development dependencies:
    [`devtools::install_dev_deps()`](https://devtools.r-lib.org/reference/install_deps.html)
5.  Create a branch: `git checkout -b fix-description main`

### Making Your Changes

1.  Write tests expecting the correct/fixed functionality; make sure
    they fail initially.
2.  Implement your changes.
3.  Run tests again:
    [`devtools::test()`](https://devtools.r-lib.org/reference/test.html)
4.  Run a full check:
    [`devtools::check()`](https://devtools.r-lib.org/reference/check.html)
5.  Update documentation as needed.
6.  Commit your changes: `git commit -m "Brief description of changes"`

### Creating Pull Requests

1.  Push your branch: `git push origin HEAD`
2.  Visit GitHub and click the “Pull request” button.
3.  In the description field, reference the issue number (if fixing an
    existing issue) or describe the issue and your fix.
4.  Submit and be patient - maintainers will review when they can.

## Questions?

If you have questions about contributing, please [open an
issue](https://github.com/sdhutchins/documenteR/issues) or contact the
maintainers.
