import 'package:flutter/material.dart';
import 'package:service/screen/Dashboard1/location_map.dart';
import 'package:service/screen/Dashboard1/my_service_request.dart';

class OnGoingJobs extends StatefulWidget {
  const OnGoingJobs({super.key});

  @override
  State<OnGoingJobs> createState() => _OnGoingJobsState();
}

class _OnGoingJobsState extends State<OnGoingJobs> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 250,
        ),
        child: MyServiceRequest(
          date: '12/06/2024',
          time: '09:00 AM',
          customerName: 'Ratn Govindam',
          serviceType: 'Electrician',
          place: 'Patiala, Urban Estate',
          duration: '2 hrs',
          distance: '0.2 Km',
          price: '75',
          leftButtonText: 'Cancel',
          rightButtonText: 'Direction',
          leftbuttonColor: const Color.fromARGB(255, 243, 243, 243),
          leftbuttontextColor: const Color.fromARGB(255, 131, 145, 161),
          rightbuttonColor: const Color(0xFF00A896),
          rightbuttontextColor: Colors.white,
          buttondivider: true,
          leftButtonOnTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Job cancellation requested')),
            );
          },
          rightButtonOnTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapScreen()),
            );
          },
        ),
      ),
    );
  }
}
