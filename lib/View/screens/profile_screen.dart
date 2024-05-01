import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/logout_model.dart';
import 'package:flutter_application_1/Model/profile_name.dart';
import 'package:flutter_application_1/View/screens/edit_profile_screen.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/View/screens/wallet_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_profile.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
} 

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false)
        .getprofileData(context)
        
        .catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
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
                    color: gridHomeColor,
                    borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.redAccent[700],
                    )),
              ),
            ),
            body: !widget.isLoggedIn
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
                              backgroundImage:
                                  AssetImage('assets/images/moaz.jpeg'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Edit Profile'),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfileScreen(),
                                      ));
                                },
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
                        Expanded(
                          child: TabBarView(children: [
                            RequesterContent(
                              user: profileProvider.userData,
                            ),
                            ParentContent(
                              user: profileProvider.userData,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )
                : const UnregisteredProfile(
                    text: 'Login to see your profile',
                  ),
          ),
        );
      },
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
  const RequesterContent({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (user != null) ...[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.person_outline),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Name: ${user!.fName} ${user!.lName}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.person_outline),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'NickName:  ${user!.nickname}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.email_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Email: ${user!.email}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.mobile_screen_share_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Mobile: ${user!.phone}',
                      style: const TextStyle(fontSize: 18),
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WalletScreen()),
                      );
                    },
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
              // Other fields...
            ] else
              const Text('User data not available'),
          ],
        ),
      ),
    );
  }
}

class ParentContent extends StatelessWidget {
  const ParentContent({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (user != null) ...[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.person_outline),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Name: ${user!.lName}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.email_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Email: ${user!.parentEmail}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.mobile_screen_share_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Mobile: ${user!.parentPhone}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.email_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Extra Email: ${user!.extraemail}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),

              // Other fields...
            ] else
              const Text('User data not available'),
          ],
        ),
      ),
    );
  }
}
