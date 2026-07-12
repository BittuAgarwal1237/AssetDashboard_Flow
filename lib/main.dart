import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'config/Supabaseconfig.dart';

// Global Supabase client instance jise aap pure app mein kahin bhi use kar sakte hain
final supabase = Supabase.instance.client;

Future<void> main() async {
  // Flutter binding ko initialize karna zaroori hai async setup se pehle
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Firebase Initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 2. Supabase Initialize
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  runApp(const AssetFlowApp());
}

class AssetFlowApp extends StatelessWidget {
  const AssetFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AssetFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Dashboard hata kar ek normal initial screen de di hai jahan se aap shuru kar sakte hain
      home: const Scaffold(
        body: Center(
          child: Text(
            'Firebase & Supabase Initialized Successfully!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}