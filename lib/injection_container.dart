import 'package:agent_app/helpers/session_manager.dart';
import 'package:agent_app/modules/auth/repository/auth_repository.dart';
import 'package:agent_app/modules/auth/view_model/auth_service.dart';
import 'package:agent_app/network/api_client.dart';
import 'package:agent_app/network/api_client_imp.dart';
import 'package:agent_app/network/socket_service_imp.dart';
import 'package:agent_app/res/app_urls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

init() async {
  var pref = await SharedPreferences.getInstance();

  //network
  serviceLocator.registerLazySingleton<ApiClient>(
    () => ApiClientImp(sessionManager: serviceLocator()),
  );

  //session
  serviceLocator.registerLazySingleton<SessionManager>(
    () => SessionManagerImp(sharedPreferences: pref),
  );

  //socket
  serviceLocator.registerLazySingleton<SocketService>(
    () => SocketServiceImp(url: AppUrls.socketUrl),
  );

  //auth
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthService(apiClient: serviceLocator()),
  );

  //profile
}
