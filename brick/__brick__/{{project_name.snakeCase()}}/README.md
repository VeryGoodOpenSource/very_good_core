# {{project_name.titleCase()}}

[![ci][ci_badge]][ci_badge_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

---

## Setting up 💻

### Installing FVM

- Windows
  1. Install chocolatey from [here][chocolatey_link].
  2. Then, `choco install fvm`
- MacOS
  1. `brew tap leoafarias/fvm`
  2. `brew install fvm`

### Installing Make

This project uses a makefile to easily run commands

- Windows
  1. Install chocolatey from [here][chocolatey_link].
  2. Then, `choco install make.`
- MacOS
  1. `brew install make`

**Note**: To learn more about the pre defined `make` commands, see the **Makefile** found in the root of the project directory.

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

Before running the project, run the command `make rebuild` to ensure that all dependencies are installed.
To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

**Note**: Before running your test, make sure that the golden files are already generated. If not, run the following command: `make goldens_win` for Windows and `make goldens_mac` for macOS.

```sh
$ make lcov
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```Mac
# Generate Coverage Report
$ make lcov_report_mac
```

To setup lcov on windows check this [guide](https://fredgrott.medium.com/lcov-on-windows-7c58dda07080).

```Windows
# Generate Coverage Report
$ make lcov_report_win
```

### Generating goldens file

```Mac
# Generate goldens for macOS
$ make goldens_mac
```

```Windows
# Generate goldens for Windows
$ make goldens_win
```

### Updating Remote Goldens File

1. Update the `goldensVersion` variable found in `flutter_test_config.dart` under **TestConfig** class
2. Generate the goldens file (`make goldens_mac` or `make goldens_win`)

### Modifying Goldens Tests Threshold

1. Modify the `goldenTestsThreshold` variable found in `flutter_test_config.dart` under **TestConfig** class
2. Update

## Static Code Analysis

### Dart Code Metrics

```Analyze
# Generate Dart Code Metrics HTML Report for Windows
$ make metrics_win

# Generate Dart Code Metrics HTML Report for macOS
$ make metrics_win
```

```Check unused files/codes
# Generate Json Report for unused codes
$ make check_unused_codes

# Generate Json Report for unused files
$ make  check_unused_files
```

### Dependency Validator

```Check unused dependencies
# Run dependency validator
$ make dependency_validator
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and [intl][intl_link] and uses [intl_utils][intl_utils_link] to create a binding between your translations from .arb files and your Flutter app.

### Localization Naming Conventions

1.  For common or general purpose strings:
    - Pattern
    ```
    "common_$string" : "$value"
    ```
        - Examples
        ```
         "common_ok": "OK",
         "common_cancel": "Cancel",
        ```
2.  For featured specific strings:
    - Pattern
    ```
    "$featureName__$where__$string" : "$value"
    ```
        - Examples
        ```
         "login__button_text__sign_in": "Sign In",
         "login__button_text__sign_up": "Sign Up",
         "registration__label_text__first_name":"First Name",
        ```

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `assets/l10n/app_en.arb`.

```arb
{
    "@@locale": "en",
    "common_ok": "OK",
    "common_cancel": "Cancel",
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "common_ok": "OK",
    "common_cancel": "Cancel",
    "login__button_text__sign_in": "Sign In",
    "login__button_text__sign_up": "Sign Up",
    "registration__label_text__first_name":"First Name",
}
```

3. Use the new string

```dart
import 'package:{{project_name.snakeCase()}}/app/utils/extensions.dart';

@override
Widget build(BuildContext context) {
  return Text(context.l10n.common_ok);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `assets/l10n/`.

```
├── l10n
│   ├── app_en.arb
│   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "common_ok": "OK",
    "common_cancel": "Cancel",
    "login__button_text__sign_in": "Sign In",
    "login__button_text__sign_up": "Sign Up",
    "registration__label_text__first_name":"First Name",

}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "common_ok": "OK",
    "common_cancel": "Cancelar",
    "login__button_text__sign_in": "Registrarse",
    "login__button_text__sign_up": "Inscribirse",
    "registration__label_text__first_name":"Primer nombre",
}
```

[ci_badge]: https://github.com/VeryGoodOpenSource/very_good_coverage/workflows/ci/badge.svg
[ci_badge_link]: https://github.com/VeryGoodOpenSource/very_good_coverage/actions
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[intl_link]: https://pub.dev/packages/intl
[intl_utils_link]: https://pub.dev/packages/intl_utils
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
[chocolatey_link]: https://chocolatey.org/install
