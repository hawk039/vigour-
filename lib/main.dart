import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants.dart';
import 'core/theme.dart';
import 'features/authentication/data/repositories/auth_repository.dart';
import 'features/authentication/presentation/screens/signup_screen.dart';
import 'features/authentication/presentation/screens/update_password_screen.dart';
import 'features/authentication/presentation/view_models/login_view_model.dart';
import 'features/authentication/presentation/view_models/reset_password_view_model.dart';
import 'features/authentication/presentation/view_models/signup_view_model.dart';
import 'features/home/data/repositories/quote_repository.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/home/presentation/view_models/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  // Initialize Hive
  await Hive.initFlutter();
  
  // Open boxes
  await Hive.openBox<Map>('favorites_box');
  await Hive.openBox('settings_box');

  final quoteRepository = QuoteRepository();
  final authRepository = AuthRepository();
  
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: authRepository),
        ChangeNotifierProvider(
          create: (_) => SignupViewModel(repository: authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(repository: authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(repository: quoteRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ResetPasswordViewModel(repository: authRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.passwordRecovery) {
        _navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => const UpdatePasswordScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Vigour',
          theme: AppTheme.lightTheme,
          home: const AuthGate(),
        );
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    return StreamBuilder<AuthState>(
      stream: authRepository.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.data?.session ?? authRepository.currentSession;
        if (session != null) {
          return const HomeScreen();
        } else {
          return const SignupScreen();
        }
      },
    );
  }
}
