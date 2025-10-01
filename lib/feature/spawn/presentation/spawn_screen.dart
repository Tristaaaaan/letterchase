import 'package:flutter/material.dart';
import 'package:letterchase/feature/spawn/presentation/widgets/spawn_container.dart';

class SpawnScreen extends StatelessWidget {
  const SpawnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(hasScrollBody: false, child: SpawnContainer()),
        ],
      ),
    );
  }
}
