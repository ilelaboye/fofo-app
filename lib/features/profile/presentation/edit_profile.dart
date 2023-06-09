import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/notification.dart';
import '../../../service/auth_service/auth_provider.dart';
import '../../auth/presentation/signup.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String fullname = "",
      phonenumber = "",
      city = "",
      jobTitle = "",
      socialLinks = "",
      state = "";
  String? selectedItem;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final profile = authProvider.userProfile!;
    selectedItem = profile.field;
    print('edit profie');
    print(profile);
    return Scaffold(
      appBar: const Appbar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    onSaved: (value) => phonenumber = value!,
                  ),
                  const Gap(25),
                  TextInputField(
                    labelText: "City",
                    initialValue: profile.city,
                    hintText: "",
                    validator: (value) =>
                        value!.isEmpty ? "Please enter city" : null,
                    onSaved: (value) => city = value!,
                  ),
                  const Gap(25),
                  TextInputField(
                    labelText: "State",
                    hintText: "E.g New York",
                    initialValue: profile.state,
                    validator: (value) =>
                        value!.isEmpty ? "Please enter state" : null,
                    onSaved: (value) => state = value!,
                  ),
                  const Gap(25),
                  TextInputField(
                    labelText: "Job Title",
                    hintText: "E.g Administrative Assistant",
                    initialValue: profile.jobTitle,
                    validator: (value) =>
                        value!.isEmpty ? "Please enter job title" : null,
                    onSaved: (value) => jobTitle = value!,
                  ),
                  const Gap(25),
                  const Text(
                    'Field',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropDownCategory(
                      selectedItem: selectedItem,
                      onSelectItem: (item) => {
                            setState(() => {selectedItem = item!})
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
                    onSaved: (value) => socialLinks = value!,
                  ),
                  Gap.lg,
                  Button(
                    'Save Changes',
                    onTap: (() async {
                      final form = formKey.currentState!;
                      EasyLoading.show(status: "Loading...");
                      form.save();
                      var response =
                          await authProvider.updateProfile(context, user: {
                        "fullname": fullname,
                        "phonenumber": phonenumber,
                        "city": city,
                        "jobTitle": jobTitle,
                        "socialLinks": socialLinks,
                        "field": selectedItem,
                        "state": state
                      });
                      EasyLoading.dismiss();
                      print('back');
                      print(response);
                      if (response['status']) {
                        showNotification(
                            context, true, "Profile updated successfully");
                      }

                      // context.pop()
                    }),
                  ),
                  const Gap(50)
                ],
              )),
        ),
      ),
    );
  }
}
