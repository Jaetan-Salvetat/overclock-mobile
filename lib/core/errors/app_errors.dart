enum AppError {
  noBody,
  invalidToken,
  timeout,
  unknown;

  String get label {
    switch (this) {
      case AppError.invalidToken:
        return 'Token de connexion invalide';
      case AppError.timeout:
        return 'Le serveur a pris trop de temps à répondre';
      default:
        return 'Une erreur est survenue';
    }
  }

  static AppError fromString(String value) {
    switch (value) {
      case 'no_body':
        return AppError.noBody;
      case 'invalid_token':
        return AppError.invalidToken;
      default:
        return AppError.unknown;
    }
  }

  static AppError fromObject(Object? obj) {
    if (obj is AppError) {
      return obj;
    }
    return AppError.unknown;
  }
}
