import 'package:agent_app/res/contents/messages.dart';
import 'package:agent_app/res/contents/texts.dart';
import 'package:agent_app/res/widgets/app_button.dart' show AppButton;
import 'package:agent_app/res/widgets/app_text_field.dart';
import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/theme/colors.dart';
import 'package:agent_app/utils/routes/routes_names.dart' show RouteNames;
import 'package:agent_app/utils/utils.dart' show Utils;
import 'package:agent_app/viewModel/auth_provider.dart' show AuthViewModel;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool isChecked = false;

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
        appBar: AppBar(centerTitle: true, automaticallyImplyLeading: false),
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  Text(
                    texts.signIn,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(texts.welcome, style: context.textTheme.bodyLarge),
                  SizedBox(height: 40),
                  AppTextField(
                    labelText: texts.emailAddress,
                    mandatory: true,
                    controller: _emailController,
                    focusNode: _emailFocus,
                    keyBoardType: TextInputType.emailAddress,
                    hintText: "Enter Your Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    inputFormatters: [LengthLimitingTextInputFormatter(130)],
                    onFieldSubmitted: (value) {
                      Utils.changeNodeFocus(
                        context,
                        current: _emailFocus,
                        next: _passwordFocus,
                      );
                    },
                    validator: (val) => Utils.validateEmail(val ?? ''),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: _obSecureNotifier,
                    builder: ((context, value, child) {
                      return AppTextField(
                        labelText: texts.password,
                        mandatory: true,
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        obscureText: _obSecureNotifier.value,
                        keyBoardType: TextInputType.visiblePassword,
                        obscuringCharacter: "*",
                        hintText: "Enter Your Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        inputFormatters: [LengthLimitingTextInputFormatter(30)],
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
                        validator: (val) => Utils.passwordValidator(val ?? ''),
                      );
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        texts.forgetPassword,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: appColors.primary,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.08),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        visualDensity: VisualDensity.compact,
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: texts.iAgree,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: appColors.appBlack,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              TextSpan(
                                text: texts.terms,
                                style: TextStyle(
                                  color: appColors.secondary,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        /*   InAppWebView.route(
                                      context,
                                      ApiConstants.PRIVACY_POLICY,
                                      texts.privacy);*/
                                      },
                              ),
                              TextSpan(
                                text: texts.and,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: appColors.appBlack,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              TextSpan(
                                text: texts.privacy,
                                style: TextStyle(
                                  color: appColors.secondary,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        /* InAppWebView.route(
                                      context,
                                      ApiConstants.PRIVACY_POLICY,
                                      texts.privacy);*/
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  AppButton(
                    title: "Login",
                    onPressed: () {
                      _passwordFocus.unfocus();
                      if (formKey.currentState == null ||
                          formKey.currentState!.validate()) {
                        if (!isChecked) {
                          Utils.flushBarErrorMessage(
                            Messages.TERMS_REQ,
                            context,
                          );
                        } else {
                          Map data = {
                            "username": _emailController.text.toString(),
                            "password": _passwordController.text.toString(),
                          };
                          authViewmodel.apiLogin(data, context);
                          debugPrint("hit API");
                        }
                      }
                    },
                    isLoading: authViewmodel.loading,
                  ),

                  SizedBox(height: height * 0.005),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.signupScreen);
                      },
                      child: Text(
                        "Don't have an account yet? Sign Up!",
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
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
