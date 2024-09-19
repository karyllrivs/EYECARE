import 'package:eyecare_mobile/model/consultation.model.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/view_model/consultation.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultationHistory extends StatefulWidget {
  const ConsultationHistory({super.key});

  @override
  State<ConsultationHistory> createState() => _ConsultationHistory();
}

class _ConsultationHistory extends State<ConsultationHistory> {
  List<ConsultationModel> consultations = [];

  @override
  void didChangeDependencies() {
    consultations = context.watch<ConsultationViewModel>().consultations;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(title: "Consultation History", isAuth: true),
      bottomNavigationBar: const BottomNavbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListView.builder(
          padding: const EdgeInsets.all(5),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: consultations.length,
          itemBuilder: (context, index) {
            ConsultationModel consultation = consultations[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                decoration:
                    getElevatedContainerDecoration(context, hasShadow: true),
                child: ListTile(
                  leading: const Icon(Icons.bookmark_added_outlined),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        consultation.date,
                        style: getLTSubitleStyle(context),
                      ),
                      Text(
                        consultation.time,
                        style: getLTSubitleStyle(context),
                      ),
                    ],
                  ),
                  trailing: ConsultationStatus(
                    status: consultation.status!,
                  ),
                  onTap: () {},
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ConsultationStatus extends StatelessWidget {
  final String status;

  const ConsultationStatus({super.key, required this.status});

  Color getStatusColor(BuildContext context, String status) {
    switch (status) {
      case "COMPLETED":
        return Colors.green;
      case "APPROVED":
        return Theme.of(context).colorScheme.primary;
      default:
        return Theme.of(context).colorScheme.onSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = getStatusColor(context, status);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: statusColor,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        status,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
