import 'dart:async';

List<StreamSubscription> activeListeners = [];

void cancelAllListeners() {
  for (var listener in activeListeners) {
    listener.cancel();
  }
  activeListeners.clear();
  print("All Firebase listeners cancelled.");
}