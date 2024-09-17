import 'package:eyecare_mobile/model/policy.model.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/view_model/policy.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  void initState() {
    context.read<PolicyViewModel>().fetchPolicies();
    super.initState();
  }

  String termsAndConditions = "";

  @override
  void didChangeDependencies() {
    List<Policy> policies = context.watch<PolicyViewModel>().policies;
    if (policies.isNotEmpty) termsAndConditions = policies[0].content;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(
        title: "Terms and Conditions",
      ),
      body: StaticBackground(
        body: ScrollableContainer(children: [HtmlWidget(termsAndConditions)]),
      ),
    );
  }
}
