import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/authentication/presentation/viewModels/login_view_model.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/dialog_utils.dart';
import 'package:movies_app/core/routes_manager.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Consumer<LoginViewModel>(
              builder: (context, viewModel, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 70.h),
                  Image.asset(
                    AssetsManager.appIcon,
                    height: 118.h,
                  ),
                  SizedBox(height: 70.h),
                  CustomTextFormField(
                    controller: emailController,
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    controller: passwordController,
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility_off),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Row(
                    children: [
                      Spacer(),
                      CustomTextButton(
                        title: 'Forget Password ?',
                      ),
                    ],
                  ),
                  SizedBox(height: 34.h),
                  CustomElevatedButton(
                    onPressed: () {
                      _login(viewModel, context);
                    },
                    color: ColorsManager.orange,
                    title: 'Login',
                    titleStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t Have Account ?   ',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
                      ),
                      CustomTextButton(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesManager.registerView);
                        },
                        title: 'Create One',
                      ),
                    ],
                  ),
                  SizedBox(height: 26.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Divider(
                        color: ColorsManager.orange,
                        thickness: 1.sp,
                        indent: 80.w,
                        endIndent: 80.w,
                      ),
                      Container(
                        padding: REdgeInsets.symmetric(horizontal: 12),
                        color: ColorsManager.black121312,
                        child: Text(
                          'OR',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 15.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 26.h),
                  CustomElevatedButton(
                    onPressed: () {},
                    color: ColorsManager.orange,
                    title: 'Login With Google',
                    titleStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(LoginViewModel viewModel, BuildContext context) async {
    DialogUtils.showLoadingDialog("wait...", context);

    await viewModel.login(
      email: emailController.text,
      password: passwordController.text,
    );
    if (context.mounted) {
      DialogUtils.hideDialog(context);
      if (viewModel.message == 'Success Login') {
        DialogUtils.showDialogMessage(context, message: viewModel.message, posActionTitle: "Ok",
            posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.mainLayoutView);
        });
      } else {
        DialogUtils.showDialogMessage(context,
            message: viewModel.message, negActionTitle: "Cancel", negAction: () {});
      }
    }
    log(viewModel.token);
  }
}
