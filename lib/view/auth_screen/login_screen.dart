import 'package:agent_app/res/widgets/app_button.dart' show AppButton;
import 'package:agent_app/res/widgets/app_text_field.dart';
import 'package:agent_app/res/widgets/round_button.dart' show RoundButton;
import 'package:agent_app/utils/routes/routes_names.dart' show RouteNames;
import 'package:agent_app/utils/utils.dart' show Utils;
import 'package:agent_app/viewModel/auth_provider.dart' show AuthViewModel;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _obSecureNotifier = ValueNotifier<bool>(false);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authViewmodel = Provider.of<AuthViewModel>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTextField(
                    labelText: "Email",
                    mandatory: true,
                    controller: _emailController,
                    focusNode: _emailFocus,
                    keyBoardType: TextInputType.emailAddress,
                    hintText: "Enter Your Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    onFieldSubmitted: (value) {
                      Utils.changeNodeFocus(
                        context,
                        current: _emailFocus,
                        next: _passwordFocus,
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      String pattern =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return "Email is not valid";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: _obSecureNotifier,
                    builder: ((context, value, child) {
                      return AppTextField(
                        labelText: "Password",
                        mandatory: true,
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        obscureText: _obSecureNotifier.value,
                        keyBoardType: TextInputType.visiblePassword,
                        obscuringCharacter: "*",
                        hintText: "Enter Your Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        iconData:
                            _obSecureNotifier.value
                                ? InkWell(
                                  onTap: () {
                                    _obSecureNotifier.value =
                                        !_obSecureNotifier.value;
                                  },
                                  child: const Icon(Icons.visibility),
                                )
                                : InkWell(
                                  onTap: () {
                                    _obSecureNotifier.value =
                                        !_obSecureNotifier.value;
                                  },
                                  child: const Icon(Icons.visibility_off),
                                ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      );
                    }),
                  ),

                  SizedBox(height: height * 0.08),

                  AppButton(
                    title: "Login",
                    onPressed: () {
                      _passwordFocus.unfocus();
                      if (formKey.currentState == null ||
                          formKey.currentState!.validate()) {
                        Map data = {
                          "email": _emailController.text.toString(),
                          "password": _passwordController.text.toString(),
                        };
                        authViewmodel.apiLogin(data, context);
                        debugPrint("hit API");
                      }
                    },
                    isLoading: authViewmodel.loading,
                  ),

                  SizedBox(height: height * 0.02),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.signupScreen);
                    },
                    child: const Text("Don't have an account yet? Sign Up!"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _emailFocus.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
  }
}
