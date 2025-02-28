import 'package:agent_app/modules/auth/repository/auth_repository.dart';
import 'package:agent_app/network/api_client.dart';
import 'package:agent_app/network/response_model.dart';
import 'package:agent_app/network/server_error.dart';
import 'package:agent_app/res/app_urls.dart';
import 'package:fpdart/fpdart.dart';

class AuthService implements AuthRepository {
  final ApiClient apiClient;

  AuthService({required this.apiClient});

  @override
  Future<Either<String, ResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var res = await apiClient.postApi(
        url: AppUrls.loginEndPoint,
        body: {'username': email, 'password': password},
      );

      return Right(res!);
    } on ServerError catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      var res = await apiClient.postApi(
        url: AppUrls.registerEndPoint,
        body: {
          'full_name': name,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      return Right(res?.message ?? '');
    } on ServerError catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResponseModel>> forgotPassword({
    required String email,
  }) async {
    try {
      var res = await apiClient.postApi(
        url: AppUrls.forgetPasswordEndPoint,
        body: {'email': email},
      );
      return Right(res!);
    } on ServerError catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResponseModel>> verifySignUpOtp({
    required String email,
    required String otp,
  }) async {
    try {
      var res = await apiClient.postApi(
        url: AppUrls.verifyEmailEndPoint,
        body: {'email': email, 'otp': otp},
      );
      return Right(res!);
    } on ServerError catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResponseModel>> resetPassword({
    required String password,
    required String confirmPassword,
    required String email,
    required String otp,
  }) async {
    try {
      var res = await apiClient.postApi(
        url: AppUrls.updatePasswordEndPoint,
        body: {
          'otp': otp,
          'email': email,
          'new_password': password,
          'confirm_new_password': confirmPassword,
        },
      );
      return Right(res!);
    } on ServerError catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
