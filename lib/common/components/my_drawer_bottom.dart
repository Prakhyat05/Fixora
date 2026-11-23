// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:service/export.dart';
import 'package:service/service/authentication.dart';

class MyDrawerBottom extends StatefulWidget {
  const MyDrawerBottom({super.key});

  @override
  State<MyDrawerBottom> createState() => _MyDrawerBottomState();
}

class _MyDrawerBottomState extends State<MyDrawerBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                await AuthServices().logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    'loginemail',
                    (route) => false,
                  );
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MySecondHeading(
                      text: 'Logout',
                      fontWeight: FontWeight.w500,
                      fontsize: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.logout,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            MyTextWidget(
              text: 'Fixora v1.0.0 (Production)',
              fontSize: 12,
              align: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
