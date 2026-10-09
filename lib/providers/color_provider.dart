import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorProvider extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void changeColor(int value) {
    state = value;
  }
}

final colorProvider = NotifierProvider<ColorProvider, int>(ColorProvider.new);
