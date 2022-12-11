part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const ADD_PEGAWAI = _Paths.ADD_PEGAWAI;
}

abstract class _Paths {
  static const HOME = '/home';
  static const ADD_PEGAWAI = '/add-pegawai';
}
