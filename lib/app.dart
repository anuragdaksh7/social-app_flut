import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/features/auth/data/firebase_auth_repo.dart';
import 'package:social/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social/features/auth/presentation/cubits/auth_states.dart';
import 'package:social/features/auth/presentation/pages/auth_page.dart';
import 'package:social/features/home/presentation/pages/home_page.dart';
import 'package:social/features/profile/data/firebase_profile_repo.dart';
import 'package:social/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social/themes/light_mode.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final profileRepo = FirebaseProfileRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
          ),
          BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(profileRepo: profileRepo))
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            home: BlocConsumer<AuthCubit, AuthState>(
              builder: (context, authState) {
                print(authState);

                if (authState is Unauthenticated) {
                  return const AuthPage();
                } else if (authState is Authenticated) {
                  return const HomePage();
                } else {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
              listener: (context, authState) {
                if (authState is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(authState.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            )));
  }
}
