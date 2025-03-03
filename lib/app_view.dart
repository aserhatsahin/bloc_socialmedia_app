import 'package:bloc_socialmedia_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:bloc_socialmedia_app/screens/home/home_screen.dart';
import 'package:bloc_socialmedia_app/screens/authentication/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocioS',

      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Color(0xFFF8F9FA), // Açık, hafif gri arka plan (soft beyaz)
          onSurface: Color(0xFF222222), // Koyu gri, okunaklı yazılar için
          primary: Color(
            0xFF0066FF,
          ), // Parlak mavi (Daha canlı bir ana renk, interaktif öğeler için)
          onPrimary: Color(0xFFFFFFFF), // Beyaz (Primary üzerindeki metinler)
          secondary: Color(
            0xFFFFC107,
          ), // Sarı (Eylem çağrıları, butonlar için dikkat çekici renk)
          onSecondary: Color(
            0xFF222222,
          ), // Koyu gri (Secondary üzerindeki metinler)
          tertiary: Color(
            0xFF00C853,
          ), // Canlı yeşil (Başarı mesajları, olumlu durumlar)
          error: Color(0xFFE53935), // Kırmızı (Hata mesajları için)
          outline: Color(
            0xFFBDBDBD,
          ), // Yumuşak gri (Çerçeveler ve sınırlar için)
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return HomeScreen();
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
