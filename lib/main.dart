import 'package:bloc_socialmedia_app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp();
  runApp(const MainApp());
}


