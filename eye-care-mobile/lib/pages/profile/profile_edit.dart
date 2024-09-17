import 'package:eyecare_mobile/model/auth.model.dart';
import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/shared/helpers/validators.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/view_model/auth.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEdit();
}

class _ProfileEdit extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fNameCtrl = TextEditingController();
  final TextEditingController _lNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();

  final Map<String, String?> _editProfileForm = {
    "firstName": null,
    "lastName": null,
    "email": null,
    "mobile": null,
    "address": null,
  };

  void updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userID = prefs.getString('ec_user_token');

        final newProfile = Auth(
          id: userID!,
          email: _editProfileForm['email']!,
          firstName: _editProfileForm['firstName']!,
          lastName: _editProfileForm['lastName']!,
          mobile: _editProfileForm['mobile'],
          address: _editProfileForm['address'],
        );

        if (mounted) {
          await context.read<AuthViewModel>().updateUserProfile(newProfile);
        }

        if (mounted) {
          showResultDialog(context, true,
              message: "Profile successfully updated.");
        }
      } catch (e) {
        if (mounted) showResultDialog(context, false, message: e.toString());
      }
    }
  }

  void autofill() {
    Auth userData = context.read<AuthViewModel>().authenticatedUser!;

    // update form
    _editProfileForm["firstName"] = userData.firstName;
    _editProfileForm["lastName"] = userData.lastName;
    _editProfileForm["email"] = userData.email;
    _editProfileForm["mobile"] = userData.mobile;
    _editProfileForm["address"] = userData.address;

    // update fields
    _fNameCtrl.text = userData.firstName!;
    _lNameCtrl.text = userData.lastName!;
    _emailCtrl.text = userData.email;
    _mobileCtrl.text = userData.mobile ?? "";
    _addressCtrl.text = userData.address ?? "";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autofill();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(title: "Edit Profile", isAuth: true),
      bottomNavigationBar: const BottomNavbar(),
      body: StaticBackground(
        body: ScrollableContainer(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Column(
                  children: <Widget>[
                    // first name
                    TextFormField(
                      controller: _fNameCtrl,
                      validator: (value) => firstNameValidator(value),
                      decoration: getInputDecorator(context, "First Name"),
                      style: getInputStyle(context),
                      onSaved: (value) =>
                          {_editProfileForm['firstName'] = value},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // last name
                    TextFormField(
                      controller: _lNameCtrl,
                      validator: (value) => lastNameValidator(value),
                      decoration: getInputDecorator(context, "Last Name"),
                      style: getInputStyle(context),
                      onSaved: (value) =>
                          {_editProfileForm['lastName'] = value},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // last name
                    TextFormField(
                      controller: _emailCtrl,
                      readOnly: true,
                      decoration: getInputDecorator(context, "Email"),
                      style: getInputStyle(context),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // last name
                    TextFormField(
                      controller: _mobileCtrl,
                      validator: (value) => mobileValidator(value),
                      decoration: getInputDecorator(context, "Mobile"),
                      style: getInputStyle(context),
                      onSaved: (value) => {_editProfileForm['mobile'] = value},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // last name
                    TextFormField(
                      controller: _addressCtrl,
                      decoration: getInputDecorator(context, "Address"),
                      style: getInputStyle(context),
                      onSaved: (value) => {_editProfileForm['address'] = value},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Button(
              backgroundColor: Theme.of(context).colorScheme.primary,
              isPrimary: true,
              text: "UPDATE PROFILE",
              onPressed: () => updateProfile(),
            ),
          ],
        ),
      ),
    );
  }
}
