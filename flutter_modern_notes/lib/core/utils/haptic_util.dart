import 'package:flutter/services.dart';

class HapticUtil {
  static void triggerHaptic() {
    HapticFeedback.lightImpact();
  }
  
  static void triggerSelection() {
    HapticFeedback.selectionClick();
  }
  
  static void triggerMedium() {
    HapticFeedback.mediumImpact();
  }
  
  static void triggerHeavy() {
    HapticFeedback.heavyImpact();
  }
}