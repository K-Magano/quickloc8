// LoadingIndicator.dart
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      ),
    );
  }
}

// In your provider file (if using Provider)
final loadingProvider = ChangeNotifierProvider<LoadingNotifier>(
  create: (_) => LoadingNotifier(),
);

class LoadingNotifier extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

// Where you want to show the loading indicator
Consumer<LoadingNotifier>(
  builder = (context, loadingNotifier, child) {
    return Stack(
      children: [
        child, // Your actual content below
        if (loadingNotifier.isLoading) const Positioned.fill(child: LoadingIndicator()), // Overlay indicator
      ],
    );
  },
),

CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
  strokeWidth: 4.0, // Adjust thickness
  backgroundColor: Colors.black12.withOpacity(0.3), // Add background overlay
),
