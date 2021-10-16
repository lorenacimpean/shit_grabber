import 'dart:async';

import 'package:get/get.dart';

abstract class SubscriptionState<T extends FullLifeCycleController>
    extends FullLifeCycleController with StateMixin, FullLifeCycle {
  final List<StreamSubscription> _subscriptions = [];

  void disposeLater(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  void cancelSubscriptions() {
    _subscriptions.forEach((sub) => sub.cancel());
    _subscriptions.clear();
  }
}
