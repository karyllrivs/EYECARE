import 'package:eyecare_mobile/model/consultation.model.dart';
import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/view_model/auth.view_model.dart';
import 'package:eyecare_mobile/view_model/consultation.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  State<Consultation> createState() => _Consultation();
}

class _Consultation extends State<Consultation> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fNameCtrl = TextEditingController();
  final TextEditingController _lNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  final TextEditingController _dateCtrl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();

  final Map<String, dynamic> _consultationForm = {
    "slotId": null,
    "date": null,
    "time": null,
    "mobile": null,
  };

  void autofill() {
    _fNameCtrl.text =
        context.read<AuthViewModel>().authenticatedUser!.firstName!;
    _lNameCtrl.text =
        context.read<AuthViewModel>().authenticatedUser!.lastName!;
    _emailCtrl.text = context.read<AuthViewModel>().authenticatedUser!.email;
    _mobileCtrl.text =
        context.read<AuthViewModel>().authenticatedUser!.mobile ?? '';

    _consultationForm["mobile"] = _mobileCtrl.text;
  }

  void _selectSlot(value) {
    ConsultationSlotModel selectedSlot =
        consultationSlots.firstWhere((slot) => slot.id == value);

    setState(() {
      _consultationForm['slotId'] = selectedSlot.id;
      _consultationForm['date'] = selectedSlot.date;
      _consultationForm['time'] = selectedSlot.time;

      _dateCtrl.text = selectedSlot.date;
      _timeCtrl.text = selectedSlot.time;
    });
  }

  Future<void> addConsultation() async {
    if (consultationSlots.isEmpty) {
      showResultDialog(context, false,
          message: "No consultation slot at the moment.");
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userID = prefs.getString('ec_user_token');

        final newConsultation = ConsultationModel(
          userId: userID!,
          slotId: _consultationForm["slotId"],
          mobile: _consultationForm["mobile"],
          date: _consultationForm["date"],
          time: _consultationForm["time"],
        );

        if (mounted) {
          await context
              .read<ConsultationViewModel>()
              .createConsultation(newConsultation);
        }

        if (mounted) {
          showResultDialog(context, true,
              message: "Consultation successfully added.", callback: () {
            context.go("/profile");
          });
        }
        resetForm();
      } catch (e) {
        if (mounted) showResultDialog(context, false, message: e.toString());
      }
    }
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _consultationForm["slotId"] = null;
    _consultationForm["date"] = null;
    _consultationForm["time"] = null;
    _dateCtrl.text = "";
    _timeCtrl.text = "";
  }

  List<ConsultationSlotModel> consultationSlots = [];

  @override
  void didChangeDependencies() {
    context.read<ConsultationViewModel>().fetchAvailableConsultationSlots();
    consultationSlots =
        context.watch<ConsultationViewModel>().consultationSlots;
    super.didChangeDependencies();
    autofill();
  }

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
    _fNameCtrl.dispose();
    _lNameCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    _dateCtrl.dispose();
    _timeCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(title: "Consultation", isAuth: true),
      bottomNavigationBar: const BottomNavbar(),
      body: StaticBackground(
        body: ScrollableContainer(
          children: [
            // CONSULTATION FORM
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        // first name
                        Expanded(
                          child: TextFormField(
                            controller: _fNameCtrl,
                            readOnly: true,
                            decoration:
                                getInputDecorator(context, "First Name"),
                            style: getInputStyle(context),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        // last name
                        Expanded(
                          child: TextFormField(
                            controller: _lNameCtrl,
                            readOnly: true,
                            decoration: getInputDecorator(context, "Last Name"),
                            style: getInputStyle(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // email
                    TextFormField(
                      controller: _emailCtrl,
                      readOnly: true,
                      decoration: getInputDecorator(context, "Email"),
                      style: getInputStyle(context),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // mobile
                    TextFormField(
                      controller: _mobileCtrl,
                      readOnly: true,
                      decoration: getInputDecorator(context, "Mobile"),
                      style: getInputStyle(context),
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    // CONSULTATION FORM
                    Container(
                      decoration: getElevatedContainerDecoration(
                        context,
                        bgColor: Theme.of(context).colorScheme.primary,
                        hasShadow: false,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 32, bottom: 32),
                        child: Column(
                          children: [
                            Text(
                              "SCHEDULE APPOINTMENT",
                              style: getTitleStyle(context, onBlue: true),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: 320,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: DropdownMenu(
                                textStyle: getInputStyle(context),
                                initialSelection: _consultationForm["slotId"],
                                label: const Text("Select a slot"),
                                expandedInsets: const EdgeInsets.all(0),
                                inputDecorationTheme:
                                    getInputDecoratorTheme(context),
                                dropdownMenuEntries: consultationSlots
                                    .map(
                                      (consultationSlot) => DropdownMenuEntry(
                                        value: consultationSlot.id,
                                        label:
                                            "${consultationSlot.date} - ${consultationSlot.time}",
                                      ),
                                    )
                                    .toList(),
                                onSelected: (value) {
                                  _selectSlot(value);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _dateCtrl,
                              readOnly: true,
                              decoration: getInputDecorator(
                                context,
                                "Date",
                                onBlue: true,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.calendar_month),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              style: getInputStyle(context),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _timeCtrl,
                              readOnly: true,
                              decoration: getInputDecorator(
                                context,
                                "Time",
                                onBlue: true,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.punch_clock),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              style: getInputStyle(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Button(
              backgroundColor: Colors.green,
              text: "SUBMIT",
              isPrimary: true,
              onPressed: () => addConsultation(),
            ),
          ],
        ),
      ),
    );
  }
}
