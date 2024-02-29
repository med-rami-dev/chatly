import 'package:chatly/presentation/cubit/login%20cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContinueAsGuest extends StatelessWidget {
  const ContinueAsGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<LoginCubit>(context).loginAsGuest();
      },
      child: Container(
        alignment: Alignment.center,
        height: 65,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text("Continue as Guest"),
      ),
    );
  }
}
