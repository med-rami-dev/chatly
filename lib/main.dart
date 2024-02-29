import 'package:chatly/firebase_options.dart';
import 'package:chatly/presentation/Screens/chat_page.dart';
import 'package:chatly/presentation/cubit/auth/auth_cubit.dart';
import 'package:chatly/presentation/cubit/chat%20cubit/chat_cubit.dart';
import 'package:chatly/presentation/Screens/login_page.dart';
import 'package:chatly/presentation/Screens/register_page.dart';
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
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage()
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
