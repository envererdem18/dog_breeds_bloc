import 'package:dog_breeds_bloc/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:dog_breeds_bloc/src/features/splash/widgets/checkerboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    if (mounted) {
      context.read<HomeBloc>().add(SplashOperationsEvent(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CheckerboardWidget(),
      ),
    );
  }
}
