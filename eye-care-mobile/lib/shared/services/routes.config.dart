import 'package:eyecare_mobile/pages/auth/auth_home.dart';
import 'package:eyecare_mobile/pages/auth/auth_login.dart';
import 'package:eyecare_mobile/pages/auth/auth_signup.dart';
import 'package:eyecare_mobile/pages/cart/cart_list.dart';
import 'package:eyecare_mobile/pages/category/category_products.dart';
import 'package:eyecare_mobile/pages/consultation/consultation.dart';
import 'package:eyecare_mobile/pages/home/home.dart';
import 'package:eyecare_mobile/pages/product_details/product_details.dart';
import 'package:eyecare_mobile/pages/product_details/product_search.dart';
import 'package:eyecare_mobile/pages/profile/profile.dart';
import 'package:eyecare_mobile/pages/shop/shop.dart';
import 'package:eyecare_mobile/pages/virtual_try_on/virtual_try_on.dart';
import 'package:eyecare_mobile/shared/widgets/account_verification.dart';
import 'package:eyecare_mobile/shared/widgets/password_reset.dart';
import 'package:eyecare_mobile/shared/widgets/password_token.dart';
import 'package:eyecare_mobile/shared/widgets/terms_and_conditions.dart';
import 'package:eyecare_mobile/shared/widgets/verify_payment.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> unprotectedRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const AuthHome(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const AuthLogin(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) => const AuthSignup(),
  ),
  GoRoute(
    path: '/terms-conditions',
    builder: (context, state) => const TermsAndConditions(),
  ),
  GoRoute(
    path: '/password-reset',
    builder: (context, state) => const PasswordReset(),
  ),
  GoRoute(
    path: '/password-token',
    builder: (context, state) => const PasswordToken(),
  ),
  GoRoute(
    path: '/verify-account',
    builder: (context, state) => const AccountVerification(),
  ),
];

final List<GoRoute> protectedRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const Home(),
  ),
  GoRoute(
    path: '/shop',
    builder: (context, state) => const Shop(),
  ),
  GoRoute(
    path: '/product-search',
    builder: (context, state) => const ProductSearch(),
  ),
  GoRoute(
    path: '/category',
    builder: (context, state) => CategoryProducts(
      categoryId: state.extra! as String,
    ),
  ),
  GoRoute(
    path: '/product_details',
    builder: (context, state) => ProductDetails(
      productId: state.extra! as String,
    ),
  ),
  GoRoute(
    path: '/virtual',
    builder: (context, state) => VirtualTryOn(
      productId: state.extra! as String,
    ),
  ),
  GoRoute(
    path: '/cart',
    builder: (context, state) => const CartList(),
  ),
  GoRoute(
    path: '/consultation',
    builder: (context, state) => const Consultation(),
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) => const Profile(),
  ),
  GoRoute(
    path: '/verify-payment',
    builder: (context, state) => const VerifyPayment(),
  ),
];
