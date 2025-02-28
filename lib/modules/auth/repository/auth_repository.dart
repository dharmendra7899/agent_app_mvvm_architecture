import 'package:agent_app/network/response_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<String, ResponseModel>> login({
    required String email,
    required String password,
  });

  Future<Either<String, String>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<String, ResponseModel>> forgotPassword({required String email});

  Future<Either<String, ResponseModel>> verifySignUpOtp({
    required String email,
    required String otp,
  });

  Future<Either<String, ResponseModel>> resetPassword({
    required String password,
    required String confirmPassword,
    required String email,
    required String otp,
  });
}
