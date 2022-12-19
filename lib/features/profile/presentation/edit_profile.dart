import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../service/auth_service/auth_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final profile = authProvider.userProfile!;
    print('edit profie');
    print(profile);
    return Scaffold(
      appBar: const Appbar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Form(
              child: Column(
            children: [
              TextInputField(
                labelText: "Full Name",
                hintText: "E.g Rachel Choo",
                initialValue: profile.fullname,
              ),
              const Gap(25),
              TextInputField(
                labelText: "Email Address",
                hintText: "E.g Rachelchoo@gmail.com",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Phone Number",
                hintText: "E.g 1234567890",
                prefix: ClipRRect(
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: Insets.sm),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Corners.xsRadius,
                          bottomLeft: Corners.xsRadius,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "+234",
                          style: context.textTheme.bodyMedium!
                              .size(16)
                              .changeColor(Colors.white),
                        ),
                        const Icon(
                          PhosphorIcons.caretDown,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(25),
              TextInputField(
                labelText: "City, State",
                hintText: "E.g New York",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Job Title",
                hintText: "E.g Administrative Assistant",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Field",
                hintText: "Select your field",
                suffixIcon: Icon(
                  PhosphorIcons.caretDown,
                  color: AppColors.primary,
                ),
              ),
              const Gap(25),
              TextInputField(
                labelText: "Linkedin",
                hintText: "Eg https://linkedin.com/in/fofoApp",
              ),
              Gap.lg,
              Button(
                'Save Changes',
                onTap: () => context.pop(),
              ),
              const Gap(50)
            ],
          )),
        ),
      ),
    );
  }
}
