# IntoTheMultiverse

## Intro

Marvel API demo that shows a list a comic characters and allows navigation to the character detail.
To fetch data from the API you will need to get the API keys for free on: https://developer.marvel.com

## Technical considerations

In this project, I chose an MVVM-C architecture with Constructor-based Dependency Injection for testability purposes.
I've also used Combine to manage the view's state (Easier to understand what the code is doing and to mantain).

## Improvements

- Add Protocols to ViewModels to ease testability with a tool like Sourcery and allow it to be decoupled
- Increase test on the view controllers
- Improve the UI in both UIKit views and SwiftUI
- View controllers: Retry loading on failure
- Comics list: Add pagination

## Contributing

To contribute to this project, just add your pull request and the logic of the commit message will be as follow:

One commit message per line, prefixed with one of the following:
- `!` Fix for a bug or issue
- `+` A feature, file or something that was *added*
- `-` A feature, file or something that was *removed*
- `/` Change, changes or refactor

## Authors

Roger Pintó
