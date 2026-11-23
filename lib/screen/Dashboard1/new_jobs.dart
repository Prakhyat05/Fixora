import 'package:flutter/material.dart';
import 'package:service/screen/Dashboard1/my_service_request.dart';

class NewJobs extends StatefulWidget {
  const NewJobs({super.key});

  @override
  State<NewJobs> createState() => _NewJobsState();
}

class _NewJobsState extends State<NewJobs> {
  bool isAccepted = false;
  bool isRejected = false;

  @override
  Widget build(BuildContext context) {
    if (isRejected) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            "No new requests at the moment.",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ),
      );
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 250,
        ),
        child: MyServiceRequest(
          date: '12/06/2024',
          time: '09:00 AM',
          customerName: 'Prakhyat Prakhar',
          serviceType: 'Electrician',
          place: 'Patiala, Urban Estate',
          duration: '2 hrs',
          distance: '0.2 Km',
          price: '75',
          leftButtonText: 'Decline',
          rightButtonText: 'Accept',
          leftButtonOnTap: () {
            setState(() {
              isRejected = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Job request declined')),
            );
          },
          rightButtonOnTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Job Accepted! Opening job details...')),
            );
            Navigator.pushNamed(context, 'clientOnGoingJob');
          },
        ),
      ),
    );
  }
}
