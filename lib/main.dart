import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Create a Controller (StateNotifier)
class CounterController extends StateNotifier<int> {
  CounterController() : super(0);

  void increment() {
    state++;
  }

  // Random Functionality 1: Reset
  void reset() {
    state = 0;
  }

  // Random Functionality 2: Set to a Random Number
  void setToRandom() {
    state = Random().nextInt(100);
  }
}

// 2. Define the Provider
final counterProvider = StateNotifierProvider<CounterController, int>((ref) {
  return CounterController();
});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Riverpod Advance Counter'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Counter Value:', style: TextStyle(fontSize: 20)),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: count % 2 == 0 ? Colors.blue : Colors.red, // Count color changes if even/odd
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Button 1: Reset
                ElevatedButton.icon(
                  onPressed: () => ref.read(counterProvider.notifier).reset(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.orange),
                ),
                const SizedBox(width: 20),
                // Button 2: Random Number
                ElevatedButton.icon(
                  onPressed: () => ref.read(counterProvider.notifier).setToRandom(),
                  icon: const Icon(Icons.casino),
                  label: const Text('Random'),
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
