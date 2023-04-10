part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const ADD_PEGAWAI = _Paths.ADD_PEGAWAI;
  static const LOGIN = _Paths.LOGIN;
  static const NEW_PASSWORD = _Paths.NEW_PASSWORD;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  static const HOME = '/home';
  static const ADD_PEGAWAI = '/add-pegawai';
  static const LOGIN = '/login';
  static const NEW_PASSWORD = '/new-password';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const PROFILE = '/profile';
}
