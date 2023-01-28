GENHTML=C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml
LCOV=C:\ProgramData\chocolatey\lib\lcov\tools\bin\lcov

## Setup Commands ----------------------------------------

ensure_flutter_version: ## Ensures flutter version is stable 
	fvm install stable
	fvm use stable
	fvm global stable

## Note: If you are using a specific flutter version, change 'stable' to the desired '{flutter version}' you want to use

clean: ## Delete the build/ and .dart_tool/ directories
	fvm flutter clean
	
pub_clean: ## Empties the entire system cache to reclaim extra disk space or remove problematic packages
	fvm flutter pub cache clean	

pub_get: ## Gets pubs
	fvm flutter pub get

pub_outdated: ## Check for outdated packages
	fvm flutter pub outdated

pub_repair: ## Performs a clean reinstallation of all packages in your system cache
	fvm flutter pub cache repair

l10n: ## Generates strings
	flutter pub run intl_utils:generate

build_runner: ## This command generates the files for the code generated dependencies
	fvm flutter pub run build_runner build --delete-conflicting-outputs

build_runner_watch: ## This command generates the files for the code generated dependencies 'automatically during development' 
	fvm flutter pub run build_runner watch --delete-conflicting-outputs

format: ## This command formats the codebase and run import sorter
	fvm dart format lib test

clean_rebuild: ensure_flutter_version clean pub_clean pub_get l10n build_runner format

rebuild: ensure_flutter_version pub_get l10n build_runner format

lint: ## Analyzes the codebase for issues
	fvm flutter analyze lib test
	fvm dart analyze lib test

lcov_gen: ## Generates lcov
	flutter test --coverage

lcov_gen_ci: ## Generates lcov in CI environment
	flutter test --dart-define=CI=true --coverage

lcov_gen_unit: ## Generates lcov for unit tests only
	fvm flutter test test/unit --coverage 

lcov_gen_widget: ## Generates lcov for widget tests only
	fvm flutter test test/widget --coverage 

lcov_report_mac: ## Generates lcov report for macOS
	lcov  --remove coverage/lcov.info 'lib/app/*' 'lib/bootstrap.dart' '*.g.dart'  '*.freezed.dart' '*.dto.dart' '*.config.dart' '*.chopper.dart' '*_webview.dart' '**/service/*' '**/model/*'   -o coverage/lcov.info
	genhtml coverage/lcov.info -o coverage/
	open coverage/index.html		

lcov_report_win:  ## Generates lcov report for Windows
	perl ${LCOV} --remove coverage/lcov.info 'lib/app/*' 'lib/bootstrap.dart' '*.g.dart'  '*.freezed.dart' '*.dto.dart' '*.config.dart' '*.chopper.dart' '*_webview.dart' '**/service/*' '**/model/*'   -o coverage/lcov.info
	perl ${GENHTML} -o coverage\html coverage\lcov.info
	CMD /C start coverage/html/index.html	

lcov_win: lcov_gen lcov_report_win ## Generates the lcov report and automatically opens the coverage report for Windows

lcov_mac: lcov_gen lcov_report_mac  ## Generates the lcov report and automatically opens the coverage report for macOS

update_goldens: ## Updates the golden files
	flutter test --update-goldens

delete_goldens_win: ## Delete the all golden files in Windows
	CMD /C FOR /d /r "test/widget" %d IN ("goldens") DO @IF EXIST "%d" rd /s /q "%d"

delete_failures_win: ## Delete the all failed golden files in Windows
	CMD /C FOR /d /r "test/widget" %d IN ("failures") DO @IF EXIST "%d" rd /s /q "%d"

delete_failures_mac:  ## Delete the all golden files in macOS
	find ./test/widget -type d -name "failures" -exec rm -rf {} \;

delete_goldens_mac:  ## Delete the all failed golden files in macOS
	find ./test/widget -type d -name "goldens" -exec rm -rf {} \;

goldens_win: delete_goldens_win delete_failures_win update_goldens ## Deletes the existing goldens and failures and update the golden files for Windows

goldens_mac: delete_goldens_mac delete_failures_mac update_goldens ## Deletes the existing goldens and failures and update the golden files for macOS

metrics: ## Generates dart code metrics report
	fvm flutter pub run dart_code_metrics:metrics analyze lib --reporter=html

launch_metrics_mac: ## Launch code metrics report for macOS
	open metrics/index.html

launch_metrics_win:	 ## Launch code metrics report for windows
	CMD /C start metrics/index.html	

metrics_win: metrics launch_metrics_win  ## Generates dart code metrics report and automatically launch code metrics report

metrics_mac: metrics launch_metrics_mac  ## Generates dart code metrics report and automatically launch code metrics report

check_unused_codes: ## Runs the dart code metrics and checks for unused code
	fvm flutter pub run dart_code_metrics:metrics check-unused-code lib 
	
check_unused_files:  ## Runs the dart code metrics and checks for unused files
	fvm flutter pub run dart_code_metrics:metrics check-unused-files lib 		

dependency_validator: ## This command runs dependency_validator
	dart run dependency_validator	