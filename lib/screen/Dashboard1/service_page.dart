// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:service/common/components/my_appbar_back_button.dart';
import 'package:service/common/components/my_headingtwo.dart';
import 'package:service/screen/Dashboard1/services.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD6F2F2),
      appBar: AppBar(
        leading: MyAppBarBackButton(),
        leadingWidth: 120,
        backgroundColor: Colors.transparent,
        title: MySecondHeading(
          text: 'Services',
          fontsize: MediaQuery.of(context).size.width < 400 ? 25 : 30,
        ),
      ),
      /*PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            MyAppBarBackButton(),
            MySecondHeading(
              text: 'Services',
              fontsize: MediaQuery.of(context).size.width < 400 ? 25 : 30,
            ),
          ],
        ),
      ),*/
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 120,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            offset: Offset(0, 1.5),
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Operating Hours Banner
                          Container(
                            padding: const EdgeInsets.all(14),
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.access_time_filled, color: Color(0xFF00A896), size: 22),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Operating Schedule",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          "09:00 AM – 07:00 PM (Mon-Sat)",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00A896).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Active",
                                    style: TextStyle(
                                      color: Color(0xFF00A896),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Services List
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Services(
                                  price: '₹400',
                                  service: 'Primary',
                                  serviceType: 'Electrician',
                                  serviceDesc: 'Electrical Diagnostic & Repairs',
                                  place: 'Patiala',
                                  duration: '2 hrs',
                                  distance: '0.2Km',
                                  active: true,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Services(
                                  price: '₹350',
                                  service: 'Secondary',
                                  serviceType: 'Plumber',
                                  serviceDesc: 'Pipe Fitting & Leak Repair',
                                  place: 'Patiala',
                                  duration: '1.5 hrs',
                                  distance: '0.2Km',
                                  active: true,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
