import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/logout_model.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_profile.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          leading: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.redAccent[700],
                )),
          ),
        ),
        body: !isLoggedIn
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                              'assets/images/moaz.jpeg'), // Your image path here
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Edit Profile'),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 21,
                            ))
                      ],
                    ),
                    TabBar(
                      labelPadding: EdgeInsets
                          .zero, // No padding between label and indicator
                      indicator: BoxDecoration(
                        color: Colors.redAccent[700],
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.redAccent[700],
                      tabs: const [
                        _CustomTabProfile(text: 'Requester'),
                        _CustomTabProfile(text: 'Parent'),
                      ],
                    ),
                    const Expanded(
                      child: TabBarView(children: [
                        RequesterContent(),
                        ParentContent(),
                      ]),
                    ),
                  ],
                ),
              )
            : const UnregisteredProfile(text: 'Login to see your ptofile',),
      ),
    );
  }
}

class _CustomTabProfile extends StatelessWidget {
  final String text;

  const _CustomTabProfile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class RequesterContent extends StatelessWidget {
  const RequesterContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.person_outline),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Name: Youssef',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.person_outline),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Second Name: Tamer',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.email_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Email: YoussefTamer@gmail.com',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.mobile_screen_share_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Mobile: 01005019348',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.black,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wallet),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Wallet',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await LogoutModel().logout(context);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => const TabsScreen(
                          isLoggedIn: true,
                        )));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 4,
                shadowColor: Colors.black,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                  side: const BorderSide(
                    color: faceBookColor,
                  ),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: faceBookColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ParentContent extends StatelessWidget {
  const ParentContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.person_outline),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Name: Youssef',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          Divider(),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.email_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Email: YoussefTamer@gmail.com',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.mobile_screen_share_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Mobile: 01005019348',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
