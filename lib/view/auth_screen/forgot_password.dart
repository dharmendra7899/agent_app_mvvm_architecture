import 'package:agent_app/res/contents/messages.dart';
import 'package:agent_app/res/contents/texts.dart';
import 'package:agent_app/res/widgets/app_button.dart';
import 'package:agent_app/res/widgets/app_text_field.dart' show AppTextField;
import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/theme/colors.dart';
import 'package:agent_app/utils/utils.dart';
import 'package:agent_app/viewModel/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, LengthLimitingTextInputFormatter;
import 'package:provider/provider.dart' show Provider;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ValueNotifier<bool> _obSecureNotifier = ValueNotifier<bool>(false);

  final ValueNotifier<bool> _obSecureNotifier1 = ValueNotifier<bool>(false);

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _otpController = TextEditingController();

  final TextEditingController _newConPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  final FocusNode _emailFocus = FocusNode();

  final FocusNode _otpFocus = FocusNode();

  final FocusNode _newPasswordFocus = FocusNode();

  final FocusNode _newConPasswordFocus = FocusNode();

  bool isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _newConPasswordController.dispose();
    super.dispose();
  }

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
          backgroundColor: appColors.primary,
          foregroundColor: appColors.appWhite,
          centerTitle: true,
          title: Text(
            texts.forgotPassword,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: appColors.appWhite,
            ),
          ),
        ),
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
                  SizedBox(height: height * 0.03),
                  Text(
                    'Enter your email for the verification process. we will send code to your email${authViewmodel.isShowNewPassword ==
                        true ? " - ${_emailController.text}" : "."}',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: appColors.appBlack,

                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  !authViewmodel.isShowNewPassword
                      ? AppTextField(
                        labelText: texts.emailAddress,
                        mandatory: true,
                        controller: _emailController,
                        focusNode: _emailFocus,
                        keyBoardType: TextInputType.emailAddress,
                        hintText: "Enter Your Email",
                        prefixIcon: const Icon(Icons.email_outlined),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(130),
                        ],
                        onFieldSubmitted: (value) {
                          Utils.changeNodeFocus(
                            context,
                            current: _emailFocus,
                            next: _emailFocus,
                          );
                        },
                        validator: (val) => Utils.validateEmail(val ?? ''),
                      )
                      : SizedBox(),

                  Visibility(
                    visible: authViewmodel.isShowNewPassword ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          labelText: texts.otp,
                          mandatory: true,
                          controller: _otpController,
                          focusNode: _otpFocus,
                          keyBoardType: TextInputType.number,
                          hintText: "Enter Your OTP",
                          prefixIcon: const Icon(Icons.pin),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "OTP is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ValueListenableBuilder(
                          valueListenable: _obSecureNotifier,
                          builder: ((context, value, child) {
                            return AppTextField(
                              labelText: texts.newPassword,
                              mandatory: true,
                              controller: _newPasswordController,
                              focusNode: _newPasswordFocus,
                              obscureText: _obSecureNotifier.value,
                              keyBoardType: TextInputType.visiblePassword,
                              obscuringCharacter: "*",
                              hintText: "Enter Your Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
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
                              validator:
                                  (val) => Utils.passwordValidator(val ?? ''),
                            );
                          }),
                        ),
                        const SizedBox(height: 20),
                        ValueListenableBuilder(
                          valueListenable: _obSecureNotifier1,
                          builder: ((context, value, child) {
                            return AppTextField(
                              labelText: texts.confirmNewPassword,
                              mandatory: true,
                              controller: _newConPasswordController,
                              focusNode: _newConPasswordFocus,
                              obscureText: _obSecureNotifier1.value,
                              keyBoardType: TextInputType.visiblePassword,
                              obscuringCharacter: "*",
                              hintText: "Enter Your Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              iconData:
                                  _obSecureNotifier1.value
                                      ? InkWell(
                                        onTap: () {
                                          _obSecureNotifier1.value =
                                              !_obSecureNotifier1.value;
                                        },
                                        child: const Icon(Icons.visibility),
                                      )
                                      : InkWell(
                                        onTap: () {
                                          _obSecureNotifier1.value =
                                              !_obSecureNotifier1.value;
                                        },
                                        child: const Icon(Icons.visibility_off),
                                      ),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return Messages.NEW_PASSWORD_REQ;
                                } else if (_newPasswordController.text !=
                                    value) {
                                  return Messages.CON_NEW_PASSWORD_NOT_MATCHED;
                                }
                                return null;
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.08),

                  AppButton(
                    title:
                        !authViewmodel.isShowNewPassword
                            ? texts.sendOTP
                            : texts.updatePassword,
                    onPressed: () {
                      _newPasswordFocus.unfocus();

                      if (formKey.currentState == null ||
                          formKey.currentState!.validate()) {
                        if (!authViewmodel.isShowNewPassword) {
                          authViewmodel.updatePasswordStatus(true);
                        } else {
                          authViewmodel.updatePasswordStatus(false);
                        }

                        debugPrint("hit API");
                      }
                    },
                    isLoading: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
