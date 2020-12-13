# testing_in_flutter

A Sample app that shows different types of testing in Flutter.

This particular sample uses the [Provider][] package but any other state management approach
would do.

[provider]: https://pub.dev/packages/provider

## Goals for this sample

Show how to perform:

- Widget Testing **[Coming soon]**,
- ~~Flutter Driver(Integration) Testing,~~
- Flutter Integration Test **[Coming soon]**
- Performance Testing **[Coming soon]**
- State Management Testing using the [Provider][] package.
- Unit Testing using the [mockito][] package.

## How to run tests
- Navigate to the project's root folder using command line and follow the instructions below.

### To run tests using only the Flutter SDK:
The Flutter SDK can run unit tests and widget tests in a virtual machine, without the need of a physical device or emulator.
- To run all the test files in the `test/` directory in one go, run `flutter test`.
- To run a particular test file, run `flutter test test/<file_path>`

## Questions/issues

If you have a general question about testing in Flutter, the best places to go are:

- [Flutter documentation](https://flutter.dev/)
- [StackOverflow](https://stackoverflow.com/questions/tagged/flutter)

If you run into an issue with the sample itself, please
[file an issue](https://github.com/steffenSuess/testing_in_flutter/issues).