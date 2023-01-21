# Domain-Driven Bloc

[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A Flutter Project Blueprint for Building Maintainable and Scalable Flutter Apps.

## Credits

This project was originally developed by [Very Good Ventures][very_good_ventures_link] 🦄

It has been forked and adapted for creating different app templates with a clean architecture based on domain driven design

This fork is not officially maintained or affiliated with Very Good Ventures.

---

## Getting Started 🚀

This app template can be generated using [mason_cli][mason_cli_link] with customized variables.

Ensure you have [mason_cli][mason_cli_link] installed.

```sh
# Activate mason_cli from https://pub.dev
dart pub global activate mason_cli
```

```sh
# Or install from https://brew.sh
brew tap felangel/mason
brew install mason
```

Installation

```sh
# Install locally
mason add domain_driven_bloc
```

```sh
# Or install globally
mason add -g domain_driven_bloc
```

Usage 🚀

```sh
# Generate the domain_driven_bloc app template
mason make domain_driven_bloc
```

## What's Included ✨

Out of the box, Domain-Driven Bloc includes:

- ✅ [Cross Platform Support][flutter_cross_platform_link] - Built-in support for iOS, Android, Web, and Windows (MacOS/Linux coming soon!)
- ✅ [Build Flavors][flutter_flavors_link] - Multiple flavor support for development, staging, and production
- ✅ [Internationalization Support][internationalization_link] - Internationalization support using synthetic code generation to streamline the development process
- ✅ [Sound Null-Safety][null_safety_link] - No more null-dereference exceptions at runtime. Develop with a sound, static type system.
- ✅ [Bloc][bloc_link] - Integrated bloc architecture for scalable, testable code which offers a clear separation between business logic and presentation
- ✅ [Testing][testing_link] - Unit and Widget(Golden) Tests with more than 80% line coverage
- ✅ [Logging][logging_link] - Built-in, extensible logging to capture uncaught Flutter and Dart Exceptions
- ✅ [Continuous Integration][github_actions_link] - Lint, format, test, and enforce code coverage using [GitHub Actions][github_actions_link]
- ✅ [Dependabot Integration][github_dependabot_link] - Automated dependency updates built into GitHub
- ✅ [Flutter Version Management][fvm_link] - A simple CLI to manage Flutter SDK versions.
- ✅ [Makefile][makefile_link] - A simple way to organize and standardize project commands

  ## Additional Packages:

  #### State Management

  ✅ [Flutter Bloc](https://pub.dev/packages/flutter_bloc) \
   ✅ [Flutter Hooks](https://pub.dev/packages/flutter_hooks)

  #### Functional Programming

  ✅ [Dartz](https://pub.dev/packages/dartz)

  #### Data Classes

  ✅ [Freezed](https://pub.dev/packages/freezed) \
   ✅ [Json Serializable](https://pub.dev/packages/json_serializable)

  #### Navigation

  ✅ [Go Router](https://pub.dev/packages/go_router)

  #### Dependency Injection

  ✅ [Injectable](https://pub.dev/packages/injectable) \
   ✅ [Get It](https://pub.dev/packages/get_it)

  #### Responsive

  ✅ [Responsive Framework](https://pub.dev/packages/responsive_framework)

  #### Environment Variable Management

  ✅ [Dotenv](https://pub.dev/packages/flutter_dotenv)

  #### HTTP Client

  ✅ [Chopper](https://pub.dev/packages?q=chopper)

  #### Local Storage

  ✅ [Secure Storage](https://pub.dev/packages/flutter_secure_storage) \
   ✅ [Shared Preferences](https://pub.dev/packages/shared_preferences)

  #### Logging

  ✅ [Logger](https://pub.dev/packages/logger)

  #### Localization

  ✅ [Intl](https://pub.dev/packages/intl) \
   ✅ [Intl Utils](https://pub.dev/packages/intl_utils)

  #### Testing

  ✅ [Alchemist](https://pub.dev/packages/alchemist) \
   ✅ [Golden Toolkit](https://pub.dev/packages/golden_toolkit) \
   ✅ [Bloc Test](https://pub.dev/packages/bloc_test)

  #### Mock

  ✅ [Mockito](https://pub.dev/packages/mockito) \
   ✅ [Mocktail Image Network](https://pub.dev/packages/mocktail_image_network) \
   ✅ [Faker](https://pub.dev/packages/faker)

  #### Code Quality

  ✅ [Flutter Gen](https://pub.dev/packages/flutter_gen) \
   ✅ [Very Good Analysis](https://pub.dev/packages/flutter_lints) \
   ✅ [Dart Code Metrics](https://pub.dev/packages/dart_code_metrics) \
   ✅ [Dependency Validator](https://pub.dev/packages/dependency_validator)

## Output📦

### Features ⭐

- ✴️ Domain-Driven-Bloc - A clean architecture based on domain driven design
- ✴️ Authentication - A mock authentication implementation using [Reqres][reqres_link] API.
- ✴️ Home - Displays the post found in the sub-reddit [FlutterDev][flutter_dev_link].
- ✴️ Profile - Displays the basic information of the mocked user.
- ✴️ Dark Mode - Switch between Light and Dark themes
- ✴️ Unit Testing - Performs a unit test to verify the correctness of a unit of logic under the Bloc and repository layers
- ✴️ Widget(Goldens) Testing - Performs a widget tests that uses a special matcher that compares your widget with an image file and expects that it looks the same

### Folder Structure 📁

```sh
├── .github
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── dependabot.yaml
│   └── workflows
│       └── main.yaml
├── .idea
│   └── runConfigurations
│       ├── development.xml
│       ├── production.xml
│       └── staging.xml
├── .vscode
│   ├── extensions.json
│   └── launch.json
├── android
├── assets
│   ├── env
│   ├── fonts
│   ├── icons
│   ├── images
│   └── l10n
│       └── app_en.arb
├── ios
├── lib
│   ├── app
│   │   ├── config
│   │   ├── constants
│   │   ├── generated
│   │   ├── observers
│   │   ├── routes
│   │   ├── themes
│   │   ├── utils
│   │   └── app.dart
│   ├── core
│   │   ├── data
│   │   │   ├── model
│   │   │   ├── repository
│   │   │   └── service
│   │   ├── domain
│   │   │   ├── bloc
│   │   │   ├── interface
│   │   │   └── model
│   │   └── presentation
│   │       ├── screens
│   │       └── widgets
│   ├── features
│   │   ├── auth
│   │   │   ├── data
│   │   │   │   ├── model
│   │   │   │   ├── repository
│   │   │   │   └── service
│   │   │   ├── domain
│   │   │   │   ├── bloc
│   │   │   │   ├── interface
│   │   │   │   └── model
│   │   │   └── presentation
│   │   │       ├── screens
│   │   │       └── widgets
│   │   ├── home
│   │   │   ├── data
│   │   │   │   ├── model
│   │   │   │   ├── repository
│   │   │   │   └── service
│   │   │   ├── domain
│   │   │   │   ├── bloc
│   │   │   │   ├── interface
│   │   │   │   └── model
│   │   │   └── presentation
│   │   │       ├── screens
│   │   │       └── widgets
│   │   └── profile
│   │       ├── data
│   │       │   ├── model
│   │       │   ├── repository
│   │       │   └── service
│   │       ├── domain
│   │       │   ├── bloc
│   │       │   ├── interface
│   │       │   └── model
│   │       └── presentation
│   │           ├── screens
│   │           └── widgets
│   ├── bootstrap.dart
│   ├── main_development.dart
│   ├── main_production.dart
│   └── main_staging.dart
├── test
│   ├── utils
│   ├── unit
│   │   ├── bloc
│   │   │   ├── core
│   │   │   └── features
│   │   │       ├── auth
│   │   │       └── home
│   │   └── repository
│   │       ├── core
│   │       └── features
│   │           ├── auth
│   │           └── home
│   ├── widget
│   │   ├── core
│   │   │   ├── screens
│   │   │   │   ├── goldens(generated)
│   │   │   │   └── failures(generated)
│   │   │   └── widgets
│   │   │       ├── goldens(generated)
│   │   │       └── failures(generated)
│   │   └── features
│   │       ├── auth
│   │       │   ├── screens
│   │       │   │   ├── goldens(generated)
│   │       │   │   └── failures(generated)
│   │       │   └── widgets
│   │       │       ├── goldens(generated)
│   │       │       └── failures(generated)
│   │       ├── home
│   │       │   ├── screens
│   │       │   │   ├── goldens(generated)
│   │       │   │   └── failures(generated)
│   │       │   └── widgets
│   │       │       ├── goldens(generated)
│   │       │       └── failures(generated)
│   │       └── profile
│   │           ├── screens
│   │           │   ├── goldens(generated)
│   │           │   └── failures(generated)
│   │           └── widgets
│   │               ├── goldens(generated)
│   │               └── failures(generated)
│   └── flutter_test_config.dart
├── web
├── .gitignore
├── analysis_options.yaml
├── coverage_badge.svg
├── LICENSE
├── Makefile
├── pubspec.lock
├── pubspec.yaml
└── README.md
```

### Screenshots 📷

<table>
  <tr>
    <td>Login Screen</td>
    <td>Home Screen</td>
    <td>Profile Screen</td>
  </tr>
  <tr>
    <td><img src="https://raw.github.com/Arnooodles/domain_driven_bloc/main/screenshots/login_screen.png" width=270 height=520></td>
    <td><img src="https://raw.github.com/Arnooodles/domain_driven_bloc/main/screenshots/home_screen.png" width=270 height=520></td>
    <td><img src="https://raw.github.com/Arnooodles/domain_driven_bloc/main/screenshots/profile_screen.png" width=270 height=520></td>
  </tr>
</table>

[bloc_link]: https://bloclibrary.dev
[flutter_cross_platform_link]: https://flutter.dev/docs/development/tools/sdk/release-notes/supported-platforms
[flutter_flavors_link]: https://flutter.dev/docs/deployment/flavors
[flutter_dev_link]: https://www.reddit.com/r/FlutterDev/
[fvm_link]: https://fvm.app/
[github_actions_link]: https://github.com/features/actions
[github_dependabot_link]: https://github.com/dependabot
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[logging_link]: https://api.flutter.dev/flutter/dart-developer/log.html
[makefile_link]: https://www.gnu.org/software/make/manual/make.html#Reading
[mason_cli_link]: https://pub.dev/packages/mason_cli
[null_safety_link]: https://flutter.dev/docs/null-safety
[reqres_link]: https://reqres.in/
[testing_link]: https://flutter.dev/docs/testing
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_blog_link]: https://verygood.ventures/blog/flutter-starter-app-very-good-core-cli
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_ventures_link]: https://verygood.ventures
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
