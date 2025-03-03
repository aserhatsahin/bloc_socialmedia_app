import 'package:bloc_socialmedia_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:bloc_socialmedia_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:bloc_socialmedia_app/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:bloc_socialmedia_app/screens/authentication/sign_in_screen.dart';
import 'package:bloc_socialmedia_app/screens/authentication/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  /*************  ✨ Codeium Command ⭐  *************/
  /// The UI of the welcome screen.
  ///
  /// Includes a title, a [TabBar] and a [TabBarView].
  ///
  /// The [TabBar] has two tabs: "Sign In" and "Sign Up".
  /// The [TabBarView] shows the corresponding screen when the respective tab
  /// is selected.
  ///
  /******  aeab7002-8696-4348-b8c4-73740ee64cdd  *******/
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: kToolbarHeight),
                TabBar(
                  controller: tabController,
                  unselectedLabelColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha(150),
                  labelColor: Theme.of(context).colorScheme.onSurface,
                  indicatorSize:
                      TabBarIndicatorSize.tab, // SADECE SEÇİLİ OLAN SEKMEYİ ÇİZ
                  indicatorWeight: 3.5, // Çizginin kalınlığı
                  indicatorPadding:
                      EdgeInsets.zero, //sekmenin tamaminin altini kaplamasi

                  tabs: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sign In', style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sign Up', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      BlocProvider<SignInBloc>(
                        create:
                            (context) => SignInBloc(
                              userRepository:
                                  context
                                      .read<AuthenticationBloc>()
                                      .userRepository,
                            ),
                        child: SignInScreen(),
                      ),

                      BlocProvider<SignUpBloc>(
                        create:
                            (context) => SignUpBloc(
                              userRepository:
                                  context
                                      .read<AuthenticationBloc>()
                                      .userRepository,
                            ),
                        child: SignUpScreen(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
