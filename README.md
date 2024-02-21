# Very Good Core

## 🚶‍♂️ [Repository has moved](https://github.com/VeryGoodOpenSource/very_good_templates/tree/main/very_good_core)

The Very Good Core template is now developed within the [Very Good Templates](https://github.com/VeryGoodOpenSource/very_good_templates) repository, and can be found at [very_good_templates/very_good_core](https://github.com/VeryGoodOpenSource/very_good_templates/tree/main/very_good_core).

Please file new issues on
[Very Good Templates](https://github.com/VeryGoodOpenSource/very_good_templates).

---

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]
[![Very Good Ventures][logo_black]][very_good_ventures_link_light]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Very Good Flutter Starter Project created by the Very Good Ventures Team 🦄

💡 **Note**: This README file is for a developer that wants to use Very Good Core. For contributing information please refer to the [CONTRIBUTING file](./CONTRIBUTING.md).

---

## What's Included ✨

Out of the box, Very Good Core includes:

- ✅ [Cross Platform Support][flutter_cross_platform_link] - Built-in support for iOS, Android, Web, and Windows (MacOS/Linux coming soon!)
- ✅ [Build Flavors][flutter_flavors_link] - Multiple flavor support for development, staging, and production
- ✅ [Internationalization Support][internationalization_link] - Internationalization support using synthetic code generation to streamline the development process
- ✅ [Sound Null-Safety][null_safety_link] - No more null-dereference exceptions at runtime. Develop with a sound, static type system.
- ✅ [Bloc][bloc_link] - Integrated bloc architecture for scalable, testable code which offers a clear separation between business logic and presentation
- ✅ [Testing][testing_link] - Unit and Widget Tests with 100% line coverage (Integration Tests coming soon!)
- ✅ [Logging][logging_link] - Built-in, extensible logging to capture uncaught Flutter and Dart Exceptions
- ✅ [Very Good Analysis][very_good_analysis_link] - Strict Lint Rules which are used at [Very Good Ventures][very_good_ventures_link]
- ✅ [Continuous Integration][github_actions_link] - Lint, format, test, and enforce code coverage using [GitHub Actions][github_actions_link]
- ✅ Dependabot Integration

_\* Learn more at [Flutter Starter App: Very Good Core & CLI][very_good_cli_blog_link]_

## Quick Start 🚀

1. Install a valid [Flutter SDK](https://docs.flutter.dev/get-started/install) in your local environment. Compatible Flutter SDK versions with [Very Good CLI][very_good_cli_link] can be found within the [Flutter release archive](https://docs.flutter.dev/release/archive), ensure it has a Dart version compatible with [Very Good CLI's Dart version constraint](https://github.com/VeryGoodOpenSource/very_good_cli/blob/main/pubspec.yaml).

2. [Install Very Good CLI](https://cli.vgv.dev/docs/overview#installing):

```sh
# 💻 Install Very Good CLI from pub.dev
dart pub global activate very_good_cli
```

3. Generate a project using Very Good Core:

```sh
# 🚀 Create a new project using Very Good Core
very_good create flutter_app <project-name>
```

Where `<project-name>` is the name of your project.

💡 **Note**: Optionally, you can [generate a project using Very Good Core with mason](https://brickhub.dev/bricks/very_good_core/0.4.0#usage).

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
[very_good_ventures_link]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core
[very_good_ventures_link_dark]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core#gh-dark-mode-only
[very_good_ventures_link_light]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core#gh-light-mode-only
[bloc_link]: https://bloclibrary.dev
[flutter_cross_platform_link]: https://flutter.dev/docs/development/tools/sdk/release-notes/supported-platforms
[flutter_flavors_link]: https://flutter.dev/docs/deployment/flavors
[github_actions_link]: https://github.com/features/actions
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[logging_link]: https://api.flutter.dev/flutter/dart-developer/log.html
[null_safety_link]: https://flutter.dev/docs/null-safety
[testing_link]: https://flutter.dev/docs/testing
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_blog_link]: https://verygood.ventures/blog/flutter-starter-app-very-good-core-cli
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[coverage_badge]: coverage_badge.svg
