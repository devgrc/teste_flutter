// lib/features/splash/splash_state.dart

abstract class SplashState {}

class SplashStateInitial extends SplashState {}

class AuthenticatedUser extends SplashState {
  final String userId; // Você pode adicionar mais propriedades, se necessário

  AuthenticatedUser(this.userId);
}

class UnauthenticatedUser extends SplashState {}
