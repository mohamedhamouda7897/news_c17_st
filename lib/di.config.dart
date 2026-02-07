// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/api_manager.dart' as _i331;
import 'repository/home_remote_repo.dart' as _i955;
import 'repository/home_repo.dart' as _i195;
import 'screens/bloc/cubit.dart' as _i712;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i331.ApiManager>(() => _i331.ApiManager());
    gh.factory<_i195.HomeRepo>(
      () => _i955.HomeRemoteRepo(gh<_i331.ApiManager>()),
    );
    gh.factory<_i712.HomeCubit>(() => _i712.HomeCubit(gh<_i195.HomeRepo>()));
    return this;
  }
}
