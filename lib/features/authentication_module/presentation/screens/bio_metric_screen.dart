import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/routers/route_names.dart';
import '../controller/biometric_bloc.dart';
import '../controller/biometric_event.dart';
import '../controller/biometric_state.dart';

class BioMetricScreen extends StatefulWidget {
  const BioMetricScreen({super.key});

  @override
  State<BioMetricScreen> createState() => _BioMetricScreenState();
}

class _BioMetricScreenState extends State<BioMetricScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<BiometricBloc>().add(AuthenticateWithBiometrics());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BiometricBloc, BiometricState>(
        listener: (context, state) {
          if (state is BiometricSuccess || state is BiometricNotAvailable) {
            Navigator.pushReplacementNamed(context, RoutersNames.onBoardingScreen);
          } else if (state is BiometricFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Authentication Failed or Unavailable")),
            );
          }
        },
        child: BlocBuilder<BiometricBloc, BiometricState>(
          builder: (context, state) {
            if (state is BiometricLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BiometricFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Biometric authentication failed or is unavailable.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<BiometricBloc>().add(AuthenticateWithBiometrics());
                      },
                      child: const Text("Retry Authentication"),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text("Waiting for authentication..."));
          },
        ),
      ),
    );
  }
}