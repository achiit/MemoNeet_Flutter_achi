import 'package:flutter/material.dart';
import 'package:memo_neet/constants/images.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Image.asset(
                    AppImages.appIcon,
                    height: 60,
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 80,
                  width: 80,
                  child: const CircularProgressIndicator(),
                )),
          ],
        ),
      ),
    );
  }
}
