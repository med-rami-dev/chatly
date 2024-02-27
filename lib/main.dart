import 'package:chatly/firebase_options.dart';
import 'package:chatly/presentation/Screens/chat_page.dart';
import 'package:chatly/presentation/cubit/login%20cubit/login_cubit.dart';
import 'package:chatly/presentation/Screens/login_page.dart';
import 'package:chatly/presentation/Screens/register_page.dart';
import 'package:chatly/presentation/cubit/register%20cubit/register_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* This is to use Multi Bloc Provider to provide the "LoginCubit" and "RegisterCubit" and "ChatCubit" to the entire app

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          Navigate.id: (context) => Navigate(),
          ChatPage.id: (context) => ChatPage()
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
