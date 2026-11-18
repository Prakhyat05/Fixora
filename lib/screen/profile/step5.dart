import 'package:service/export.dart';
import 'package:service/service/authentication.dart';

class Step5 extends StatefulWidget {
  const Step5({super.key});
  static String urlSend = "";

  @override
  State<Step5> createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController branchName = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  String urlImage = "";
  bool isLoading = false;

  @override
  void dispose() {
    accountNumber.dispose();
    branchName.dispose();
    ifscCode.dispose();
    super.dispose();
  }

  Future<void> databaseData() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (Step1.pickedImageSend != null) {
        await AuthServices().setProfilePhoto(Step1.pickedImageSend);
      }

      final pinCode = int.tryParse(Step1.pincodeSend) ?? 147001;

      await AuthServices().createProfile(
        Step4.addhar.isNotEmpty ? Step4.addhar : "123456789012",
        Step1.citySend.isNotEmpty ? Step1.citySend : "Patiala",
        Step1.districtSend.isNotEmpty ? Step1.districtSend : "Patiala",
        pinCode,
        Step1.townSend.isNotEmpty ? Step1.townSend : "Urban Estate",
        accountNumber.text.isNotEmpty ? accountNumber.text : "987654321012",
        branchName.text.isNotEmpty ? branchName.text : "Main Branch",
        ifscCode.text.isNotEmpty ? ifscCode.text : "SBIN0001234",
      );

      final primaryRate = int.tryParse(Step2.ratePrimary?.toString() ?? "75") ?? 75;
      final secondaryRate = int.tryParse(Step2.rateSecondary?.toString() ?? "60") ?? 60;
      final primaryService = Step2.sproviderPrimary.isNotEmpty
          ? Step2.sproviderPrimary
          : "Electrician";
      final secondaryService = Step2.sprovidersecondary.isNotEmpty
          ? Step2.sprovidersecondary
          : "Plumber";

      await AuthServices().addService(
        primaryService,
        primaryRate,
        Step3.days.isNotEmpty ? Step3.days : [WeekDays.monday, WeekDays.tuesday],
        Step3.workingTimeStart,
        Step3.workingTimeEnd,
      );

      await AuthServices().addService(
        secondaryService,
        secondaryRate,
        Step3.days.isNotEmpty ? Step3.days : [WeekDays.monday, WeekDays.tuesday],
        Step3.workingTimeStart,
        Step3.workingTimeEnd,
      );
    } catch (_) {}

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });

    Navigator.pushNamedAndRemoveUntil(
      context,
      'aa_1',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Step5.urlSend = urlImage.toString();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyAppBarBackButton(),
            Column(
              children: [
                SizedBox(height: 35),
                MyAction(pageNumber: '5'),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyHeadingTextWidget(text: 'Bank Details'),
              const MyDescTextWidget(
                text: 'Enter your bank information for receiving customer payouts.',
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: accountNumber,
                keyboardtype: TextInputType.number,
                hintText: 'Account Number',
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: ifscCode,
                keyboardtype: TextInputType.text,
                hintText: 'IFSC Code',
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: branchName,
                keyboardtype: TextInputType.name,
                hintText: 'Branch Name',
              ),
              const SizedBox(height: 30),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MyTextButton(
                      text: 'Complete Profile & Activate',
                      onPressed: databaseData,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
