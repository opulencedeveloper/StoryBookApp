import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({Key? key}) : super(key: key);
  final List<String> values1 = [
    'Comedy',
    'Adventure',
    'Action',
    'Magic',
  ];
  final List<String> values2 = [
    'Godly',
    'Inspirational',
  ];
  Widget myRow(List<String> myValue, bool val) {
    return Row(
        mainAxisAlignment:
            val ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: myValue
            .map((item) => Container(
                decoration: BoxDecoration(
                  color: const Color(0xffEAFAED),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 35,
                margin: EdgeInsets.only(right: val ? 20 : 0),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text(item,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ))))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
        height: (mediaQuery.size.height -
            mediaQuery.padding.top -
            kBottomNavigationBarHeight),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 30),
          const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 20),
          Badge(
            animationType: BadgeAnimationType.fade,
            padding: const EdgeInsets.all(4),
            //toAnimate: false,
            badgeContent: const Icon(Icons.add_a_photo),
            badgeColor: const Color(0xffEAFAED),
            position: BadgePosition.bottomEnd(bottom: 3, end: 10),
            child: const CircleAvatar(
              radius: 52,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'App. Developer:\nAmobi Victor (Opulence)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 40),
          const SizedBox(
              height: 90,
              child: TextField(
                keyboardType: TextInputType.multiline,
                //minLines: 1, //Normal textInputField will be displayed
                maxLines: 5,
                //enabled: false,
                //focusNode: new AlwaysDisabledFocusNode(),
                //autofocus: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14.0),
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffD9D9D9)),
                  hintText: 'Enter a short description about yourself here',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xffD9D9D9)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  //filled: true,
                  // fillColor: Colors.grey[200],
                ),

                // onChanged: (val) => amountInput = val,
              )),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: const [
              Text('Like',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Icon(Icons.edit, size: 15)
            ],
          ),
          const SizedBox(height: 10),
          myRow(values1, false),
          const SizedBox(height: 10),
          myRow(values2, true),
          const SizedBox(height: 50),
        ])));
  }
}
