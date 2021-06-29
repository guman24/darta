import 'dart:async';

class PasswordToggleBloc {
  bool isVisible;

  final _visibilityStateController = StreamController<bool>();

  StreamSink<bool> get stateVisibilitySink => _visibilityStateController.sink;
  Stream<bool> get stateVisibilityStream => _visibilityStateController.stream;

  final _visibilityEventController = StreamController<String>();
  StreamSink<String> get eventVisibilitySink => _visibilityEventController.sink;
  Stream<String> get eventVisibilityStream => _visibilityEventController.stream;

  PasswordToggleBloc() {
    isVisible = false;
    eventVisibilityStream.listen((event) {
      if (event == "Toggle") {
        if (isVisible) {
          isVisible = false;
        } else {
          isVisible = true;
        }
      }
      stateVisibilitySink.add(isVisible);
    });
  }

  void dispose() {
    _visibilityStateController.close();
    _visibilityEventController.close();
  }
}
