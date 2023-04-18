import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_verification/celebrate.dart';
import 'package:otp_verification/main.dart';

String? newOtp;

class VerifytheOtp extends StatefulWidget {
  const VerifytheOtp({super.key, required this.otp, required this.phNumber});

  final String otp;
  final String phNumber;

  @override
  State<VerifytheOtp> createState() => _VerifytheOtpState();
}

class _VerifytheOtpState extends State<VerifytheOtp> {
  final otp1 = TextEditingController();
  final otp2 = TextEditingController();
  final otp3 = TextEditingController();
  final otp4 = TextEditingController();
  @override
  void dispose() {
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: TextFormField(
                    showCursor: false,
                    controller: otp1,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) FocusScope.of(context).nextFocus();
                      if (value.isEmpty) FocusScope.of(context).previousFocus();
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "*",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: TextFormField(
                    showCursor: false,
                    controller: otp2,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) FocusScope.of(context).nextFocus();
                      if (value.isEmpty) FocusScope.of(context).previousFocus();
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "*",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: TextFormField(
                    showCursor: false,
                    controller: otp3,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 1) FocusScope.of(context).nextFocus();
                      if (value.isEmpty) FocusScope.of(context).previousFocus();
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "*",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: TextFormField(
                    showCursor: false,
                    controller: otp4,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      } else {
                        String userOtp = '';
                        userOtp = otp1.text.toString() +
                            otp2.text.toString() +
                            otp3.text.toString() +
                            otp4.text.toString();
                        debugPrint(userOtp.toString());
                        if (newOtp != null) {
                          if (newOtp == userOtp) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const Celebrate()));
                          } else {
                            clear();
                          }
                        } else {
                          if (widget.otp == userOtp) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const Celebrate()));
                          } else {
                            clear();
                          }
                        }
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "*",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(" Didn't get the otp?"),
                TextButton(
                    onPressed: () {
                      newOtp = sendSMS("+977 ${widget.phNumber}");
                    },
                    child: const Text("Resend",
                        style: TextStyle(color: Colors.red)))
              ],
            ),
          ],
        ),
      ),
    );
  }

  clear() {
    otp1.clear();
    otp2.clear();
    otp3.clear();
    otp4.clear();
    FocusScope.of(context).unfocus();
  }
}
