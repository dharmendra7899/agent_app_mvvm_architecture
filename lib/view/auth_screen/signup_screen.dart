import "package:agent_app/res/contents/messages.dart";
import "package:agent_app/res/contents/texts.dart";
import "package:agent_app/res/widgets/app_button.dart" show AppButton;
import "package:agent_app/res/widgets/app_text_field.dart" show AppTextField;
import "package:agent_app/res/widgets/context_extension.dart";
import "package:agent_app/theme/colors.dart";
import "package:agent_app/utils/routes/routes_names.dart" show RouteNames;
import "package:agent_app/utils/utils.dart" show Utils;
import "package:agent_app/viewModel/auth_provider.dart" show AuthViewModel;
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ValueNotifier<bool> _obSecureNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _obSecureNotifier2 = ValueNotifier<bool>(false);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
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
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    Text(
                      texts.signUp,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(texts.welcome, style: context.textTheme.bodyLarge),
                    SizedBox(height: 40),
                    AppTextField(
                      labelText: texts.firstName,
                      mandatory: true,
                      controller: _firstNameController,
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      textCapitalization: TextCapitalization.words,
                      keyBoardType: TextInputType.text,
                      hintText: "Enter Your First Name",
                      prefixIcon: const Icon(Icons.person),
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? Messages.FIRST_NAME_REQ
                                  : null,
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      labelText: texts.lastName,
                      mandatory: true,
                      controller: _lastNameController,
                      keyBoardType: TextInputType.text,
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      textCapitalization: TextCapitalization.words,
                      hintText: "Enter Your Last Name",
                      prefixIcon: const Icon(Icons.person),
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? Messages.LAST_NAME_REQ
                                  : null,
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      labelText: texts.mobile,
                      mandatory: true,
                      controller: _mobileNameController,
                      keyBoardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textCapitalization: TextCapitalization.none,
                      hintText: "Enter Your 10-Digit Mobile Number",
                      prefixIcon: const Icon(Icons.phone_android),
                      validator: (val) => Utils.validateMobileNumber(val ?? ''),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      labelText: texts.emailAddress,
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
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: _obSecureNotifier2,
                      builder: ((context, value, child) {
                        return AppTextField(
                          labelText: texts.confirmPassword,
                          mandatory: true,
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocus,
                          obscureText: _obSecureNotifier2.value,
                          keyBoardType: TextInputType.visiblePassword,
                          obscuringCharacter: "*",
                          hintText: "Enter Your Confirm Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          iconData:
                              _obSecureNotifier2.value
                                  ? InkWell(
                                    onTap: () {
                                      _obSecureNotifier2.value =
                                          !_obSecureNotifier2.value;
                                    },
                                    child: const Icon(Icons.visibility),
                                  )
                                  : InkWell(
                                    onTap: () {
                                      _obSecureNotifier2.value =
                                          !_obSecureNotifier2.value;
                                    },
                                    child: const Icon(Icons.visibility_off),
                                  ),
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return Messages.CONFIRM_PASSWORD_REQ;
                            }else
                             if (_passwordController.text != value) {
                              return Messages.CON_PASSWORD_NOT_MATCHED;
                            }
                            return null;
                          },
                        );
                      }),
                    ),
                    SizedBox(height: height * 0.03),
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
                
                    SizedBox(height: 10),
                    AppButton(
                      title: "Sign Up",
                      onPressed: () {
                        _passwordFocus.unfocus();
                        if (formKey.currentState == null ||
                            formKey.currentState!.validate()) {
                          if (!isChecked) {
                            Utils.flushBarErrorMessage(
                              Messages.TERMS_REQ, context,
                            );
                          }else{
                            Map data = {
                              "email": _emailController.text.toString(),
                              "password": _passwordController.text.toString(),
                            };
                            authViewmodel.apiSignUp(data, context);
                            debugPrint("hit API");
                          }
          
                        }
                      },
                      isLoading: authViewmodel.signupLoading,
                    ),
                    SizedBox(height: height * 0.005),
                    Align(alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.login);
                        },
                        child: Text(
                          "Already have an account? Login Up!",
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
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
