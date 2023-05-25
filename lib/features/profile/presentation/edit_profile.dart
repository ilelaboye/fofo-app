import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:provider/provider.dart';

import '../../../service/auth_service/auth_provider.dart';
import '../../auth/presentation/signup.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();
  late String fullname, phone, city, jobTitle, linkedin;
  String? selectedItem;
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
                validator: (value) =>
                    value!.isEmpty ? "Please enter fullname" : null,
                onSaved: (value) => fullname = value!,
              ),
              const Gap(25),
              TextInputField(
                enabled: false,
                labelText: "Email Address",
                initialValue: profile.email,
                hintText: "E.g Rachelchoo@gmail.com",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Phone Number",
                hintText: "E.g 1234567890",
                initialValue: profile.phonenumber,
                validator: (value) =>
                    value!.isEmpty ? "Please enter phone number" : null,
                onSaved: (value) => phone = value!,
              ),
              const Gap(25),
              TextInputField(
                labelText: "City, State",
                hintText: "E.g New York",
                validator: (value) =>
                    value!.isEmpty ? "Please enter city" : null,
                onSaved: (value) => city = value!,
              ),
              const Gap(25),
              TextInputField(
                labelText: "Job Title",
                hintText: "E.g Administrative Assistant",
                validator: (value) =>
                    value!.isEmpty ? "Please enter job title" : null,
                onSaved: (value) => jobTitle = value!,
              ),
              const Gap(25),
              DropDownCategory(
                  selectedItem: selectedItem,
                  onSelectItem: (item) => {
                        setState(() => {selectedItem = item})
                      }),
              // TextInputField(
              //   labelText: "Field",
              //   hintText: "Select your field",
              //   suffixIcon: Icon(
              //     PhosphorIcons.caretDown,
              //     color: AppColors.primary,
              //   ),
              // ),
              const Gap(25),
              TextInputField(
                labelText: "Linkedin",
                hintText: "Eg https://linkedin.com/in/fofoApp",
                onSaved: (value) => linkedin = value!,
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
