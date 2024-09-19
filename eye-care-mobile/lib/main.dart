import 'package:eyecare_mobile/firebase_options.dart';
import 'package:eyecare_mobile/shared/styles/color_scheme_1.dart';
import 'package:eyecare_mobile/shared/widgets/custom_scroll_behavior.dart';
import 'package:eyecare_mobile/view_model/auth.view_model.dart';
import 'package:eyecare_mobile/view_model/cart.view_model.dart';
import 'package:eyecare_mobile/view_model/category.view_model.dart';
import 'package:eyecare_mobile/view_model/consultation.view_model.dart';
import 'package:eyecare_mobile/view_model/object.view_model.dart';
import 'package:eyecare_mobile/view_model/order.view_model.dart';
import 'package:eyecare_mobile/view_model/policy.view_model.dart';
import 'package:eyecare_mobile/view_model/product.view_model.dart';
import 'package:eyecare_mobile/view_model/rating.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => {
        runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => AuthViewModel()..loadUser(),
              ),
              ChangeNotifierProvider(
                create: (_) => CategoryViewModel()..fetchCategories(),
              ),
              ChangeNotifierProvider(
                create: (_) => ProductViewModel()..fetchProducts(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartViewModel()..loadCart(),
              ),
              ChangeNotifierProvider(
                create: (_) =>
                    ConsultationViewModel()..fetchUserConsultations(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrderViewModel()..fetchOrders(),
              ),
              ChangeNotifierProvider(
                create: (_) => ObjectViewModel()..fetchObjects(),
              ),
              ChangeNotifierProvider(
                create: (_) => RatingViewModel(),
              ),
              ChangeNotifierProvider(
                create: (_) => PolicyViewModel(),
              ),
            ],
            child: const EyeCareApp(),
          ),
        )
      });
}

class EyeCareApp extends StatefulWidget {
  const EyeCareApp({super.key});

  @override
  State<EyeCareApp> createState() => _EyecareApp();
}

class _EyecareApp extends State<EyeCareApp> {
  AuthViewModel? authViewModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
      title: 'Eye Care',
      theme: ThemeData(
        colorScheme: const ColorScheme1(),
        useMaterial3: true,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoTransitionsBuilder(),
            TargetPlatform.iOS: NoTransitionsBuilder(),
          },
        ),
      ),
      routerConfig: context.watch<AuthViewModel>().routerConfig,
    );
  }
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
