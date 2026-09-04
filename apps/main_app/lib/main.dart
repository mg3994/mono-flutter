import 'package:flutter/material.dart';
import 'package:domain/domain.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:core_ui/core_ui.dart';

void main() {
  final IAuthService authService = InMemoryAuthService(authenticated: true);
  runApp(MainApp(authService: authService));
}

class MainApp extends StatelessWidget {
  final IAuthService authService;

  const MainApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<bool>(
            future: authService.isAuthenticated(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Authenticated: ${snapshot.data}'),
                  const SizedBox(height: 16),
                  PrimaryButton(label: 'Continue', onPressed: () {}),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
