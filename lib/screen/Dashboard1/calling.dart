import 'package:service/export.dart';

class Calling extends StatefulWidget {
  const Calling({super.key});

  @override
  State<Calling> createState() => _CallingState();
}

class _CallingState extends State<Calling> {
  bool isMuted = false;
  bool isSpeaker = false;
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 253, 253),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width < 400 ? 100 : 125,
              ),
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                radius: MediaQuery.of(context).size.width < 400 ? 50 : 60,
                child: Image.asset(
                  profileImage,
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 5),
              MyHeadingTextWidget(text: providersName),
              SizedBox(
                height: MediaQuery.of(context).size.width < 400 ? 10 : 15,
              ),
              MyDescTextWidget(
                text: isPaused ? 'Call On Hold...' : calling,
                fontSize: 14,
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(0, 5),
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 15,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(
                                  isSpeaker
                                      ? Icons.volume_up_rounded
                                      : Icons.volume_down_alt,
                                  size: 40,
                                  color: isSpeaker ? Colors.blue : Colors.black87,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isSpeaker = !isSpeaker;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.pause_rounded,
                                  size: 40,
                                  color: isPaused ? Colors.orange : Colors.black87,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPaused = !isPaused;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  isMuted ? Icons.mic_off : Icons.mic,
                                  size: 40,
                                  color: isMuted ? Colors.red : Colors.black87,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isMuted = !isMuted;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width < 400 ? 25 : 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: const CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.call_end_rounded,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width < 400 ? 12 : 34,
                        )
                      ],
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
