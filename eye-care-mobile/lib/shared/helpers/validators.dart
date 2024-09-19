const fNamePattern = r'^[A-Z][a-z]{1,}( [A-Z][a-z]{1,})?$';
const lNamePattern = r"^[A-Z][A-Za-z\'-]+$";
const emailPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const mobilePattern = r'^09\d{9}$';
const passwordPattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$';
const countryCodeMobilePattern = r'^\+63\d{11}$';

const fieldRequiredMessage = "This field is required.";

String? requiredValidator(String? value) {
  if (value == null) {
    return null;
  }

  if (value.isEmpty) {
    return fieldRequiredMessage;
  }

  return null;
}

String? firstNameValidator(String? firstName) {
  if (firstName == null) {
    return null;
  }

  if (firstName.isEmpty) {
    return fieldRequiredMessage;
  }

  if (!RegExp(fNamePattern).hasMatch(firstName)) {
    return "Invalid first name";
  }

  return null;
}

String? lastNameValidator(String? lastName) {
  if (lastName == null) {
    return null;
  }

  if (lastName.isEmpty) {
    return fieldRequiredMessage;
  }

  if (!RegExp(fNamePattern).hasMatch(lastName)) {
    return "Invalid last name";
  }

  return null;
}

String? emailValidator(String? email) {
  if (email == null) {
    return null;
  }

  if (email.isEmpty) {
    return fieldRequiredMessage;
  }

  if (!RegExp(emailPattern).hasMatch(email)) {
    return "Invalid email";
  }

  return null;
}

String? mobileValidator(String? mobile) {
  if (mobile == null) {
    return null;
  }

  if (mobile.isEmpty) {
    // return fieldRequiredMessage;
    return null;
  }

  if (!RegExp(mobilePattern).hasMatch(mobile)) {
    return "Invalid mobile number";
  }

  return null;
}

String? passwordValidator(String? password, {bool requireInvalid = true}) {
  if (password == null) {
    return null;
  }

  if (password.isEmpty) {
    return fieldRequiredMessage;
  }

  if (!RegExp(passwordPattern).hasMatch(password) && requireInvalid) {
    return "Password should be at least 8 characters, includes at least 1 uppercase and lowercase letter, and a number.";
  }

  return null;
}

String? repeatPasswordValidator(String? confirmPassword, String password) {
  if (confirmPassword == null) {
    return null;
  }

  if (confirmPassword.isEmpty) {
    return fieldRequiredMessage;
  }

  if (confirmPassword != password) {
    return "Passwords do not match";
  }

  return null;
}
