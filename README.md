# multi_listenable_builder

A widget builder whose content stays synced with one or more [`Listenable`](https://api.flutter.dev/flutter/foundation/Listenable-class.html)s.

## What is this?

Many of us flutter developers use [`ChangeNotifier`](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) for state management, they may use [`ListenableBuilder`](https://api.flutter.dev/flutter/widgets/ListenableBuilder-class.html) to keep their widgets in sync with the model, but it's a mess when they need to listen to more than one `Listenable`s.

## Example

Let's say you have a model of `ChangeNotifier` like this:

```dart
class CounterModel extends ChangeNotifier {
  int _count = 0;

  void increment() {
    _count++;
    notifyListeners();
  }

  int get count => _count;
}
```

Then in the build method of your widget:

```dart
MultiListenableBuilder(
  // supply the instance of `ChangeNotifier` model,
  // whether you get it from the build context or anywhere
  notifiers: [_counterModel],
  // this builder function will be executed,
  // once the `ChangeNotifier` model is updated
  builder: (BuildContext context, _) {
    return Text(
      '${_counterModel.count}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  },
)
```

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/crizant/multi_listenable_builder/issues).
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/crizant/multi_listenable_builder/pulls).
