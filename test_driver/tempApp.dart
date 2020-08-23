import 'package:flutter_driver/driver_extension.dart';
import 'package:p7app/main.dart' as app;


void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
//flutter drive --flavor dev --target=test_driver/job_segment/alljobs.dart
//flutter drive --target=test_driver/job_segment/alljobs.dart -d macOS