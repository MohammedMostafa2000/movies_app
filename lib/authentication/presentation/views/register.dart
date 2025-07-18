import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/authentication/presentation/viewModels/register_view_model.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/dialog_utils.dart';
import 'package:movies_app/core/routes_manager.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int avatarId = 0;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneNumberController;

  final List<String> avatarsList = [
    AssetsManager.avatar1,
    AssetsManager.avatar2,
    AssetsManager.avatar3,
    AssetsManager.avatar4,
    AssetsManager.avatar5,
    AssetsManager.avatar6,
    AssetsManager.avatar7,
    AssetsManager.avatar8,
    AssetsManager.avatar9,
  ];
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 12),
        child: Consumer<RegisterViewModel>(
          builder: (context, viewModel, child) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 160.h,
                  child: CarouselSlider(
                    items: avatarsList.map(
                      (element) {
                        return ClipOval(
                          child: Image.asset(
                            element,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ).toList(),
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          avatarId = index;
                        });
                        log(index.toString());
                      },
                      enlargeCenterPage: true,
                      enlargeFactor: 0.52,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      viewportFraction: 0.4,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Name',
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Phone Number',
                ),
                SizedBox(height: 20.h),
                CustomElevatedButton(
                  onPressed: () {
                    _createAccount(context, viewModel);
                  },
                  color: ColorsManager.orange,
                  title: 'Create Account',
                  titleStyle: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 22.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already Have Account ?   ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
                    ),
                    CustomTextButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: 'Login',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createAccount(BuildContext context, RegisterViewModel viewModel) async {
    DialogUtils.showLoadingDialog("wait...", context);

    await viewModel.register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      phoneNumber: phoneNumberController.text,
      avatarId: avatarId,
    );
    if (context.mounted) {
      DialogUtils.hideDialog(context);
      if (viewModel.message == 'User created successfully') {
        DialogUtils.showDialogMessage(context, message: viewModel.message, posActionTitle: "Ok",
            posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.loginView);
        });
      } else {
        DialogUtils.showDialogMessage(context,
            message: viewModel.message, negActionTitle: "Cancel", negAction: () {});
      }
    }

    log(viewModel.message.toString());
  }
}

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80.r,
      backgroundImage: AssetImage(image),
    );
  }
}
