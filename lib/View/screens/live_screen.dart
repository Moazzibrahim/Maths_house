import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/diagnostic_exams/diagnostic_filteration.dart';
import 'package:flutter_application_1/Model/live/live_filteration_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/all_sessions_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Add this import for JSON encoding

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<LiveFilterationProvider>(context, listen: false)
        .fetchDiagData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Live Sessions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          color: Colors.redAccent[700],
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<LiveFilterationProvider>(
          builder: (context, liveFilterationProvider, _) {
            if (liveFilterationProvider.courseData.isEmpty ||
                liveFilterationProvider.categoryData.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return DefaultTabController(
              initialIndex: 0,
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: Colors.redAccent[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.redAccent[700],
                    tabs: const [
                      _CustomTab(text: 'Upcoming Sessions'),
                      _CustomTab(text: 'History Sessions'),
                      _CustomTab(text: 'All Sessions'),
                      _CustomTab(text: 'Private Sessions'),
                    ],
                    padding: EdgeInsets.zero,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildSessionsList(
                          liveFilterationProvider,
                          liveFilterationProvider.courseData,
                          isUpcoming: true,
                        ),
                        _buildSessionsList(
                          liveFilterationProvider,
                          liveFilterationProvider.courseData,
                          isUpcoming: false,
                        ),
                        _DropdownsAndButton(
                          onPressed: ({
                            DiagnosticCategory? selectedCategory,
                            DiagnosticCourse? selectedCourse,
                            String? selectedStartDate,
                            String? selectedEndDate,
                          }) {
                            _onPressedAllSessions(
                              selectedCategory: selectedCategory,
                              selectedCourse: selectedCourse,
                              selectedStartDate: selectedStartDate,
                              selectedEndDate: selectedEndDate,
                            );
                          },
                        ),
                        _DropdownsAndButton(
                          onPressed: _onPressedAllSessions,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onPressedAllSessions({
    DiagnosticCategory? selectedCategory,
    DiagnosticCourse? selectedCourse,
    String? selectedStartDate,
    String? selectedEndDate,
  }) async {
    final categoryID = selectedCategory?.id;
    final courseID = selectedCourse?.id;

    print('Selected Category ID: $categoryID');
    print('Selected Course ID: $courseID');
    print('Selected Start Date: $selectedStartDate');
    print('Selected End Date: $selectedEndDate');
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;

      final url = Uri.parse(
          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/session_live');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          // Add any additional headers if required
        },
        body: jsonEncode({
          'category_id': categoryID,
          'course_id': courseID,
          'start_date': selectedStartDate,
          'end_date': selectedEndDate,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print('Request successful: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllSessionsScreen(),
          ),
        );
        // Process the response if needed
      } else {
        print(response.body);
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occur during the HTTP request
      print('Error sending filters: $error');
    }
  }

  void _onPressedPrivateSessions() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Private Sessions button pressed'),
      ),
    );
  }

  Widget _buildSessionsList(LiveFilterationProvider liveFilterationProvider,
      List<DiagnosticCourse> sessions,
      {required bool isUpcoming}) {
    final dateFormat = DateFormat('dd MMMM yyyy');
    final currentTime = DateTime.now();

    if (liveFilterationProvider.mustBuyNewPackage && isUpcoming) {
      return Center(
        child: Text(
          'Sorry: You Must Buy New Package',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      );
    }

    if (sessions.isEmpty) {
      return Center(
        child: Text(
          isUpcoming ? 'No upcoming sessions' : 'No past sessions',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        final sessionTime = session.createdAt;
        final isBeforeStart =
            currentTime.isBefore(sessionTime.subtract(Duration(minutes: 10)));
        final isDuringSession = currentTime.isAfter(sessionTime) &&
            currentTime.isBefore(sessionTime.add(Duration(hours: 1)));

        return ListTile(
          title: Text(
            session.courseName,
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date: ${dateFormat.format(sessionTime)}",
                style: TextStyle(),
              ),
              Text("From: ${session.createdAt}"),
              Text("To: ${session.updatedAt}"),
            ],
          ),
          trailing: isUpcoming
              ? ElevatedButton(
                  onPressed: isBeforeStart
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.redAccent[700],
                              content:
                                  Text("It's too early to attend the session!"),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      : isDuringSession
                          ? () => _launchURL(session.courseUrl)
                          : null,
                  child: Text(
                    "Attend",
                    style: TextStyle(
                        color: Colors.redAccent[700],
                        fontWeight: FontWeight.bold),
                  ),
                )
              : null,
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class _CustomTab extends StatelessWidget {
  final String text;

  const _CustomTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class _DropdownsAndButton extends StatefulWidget {
  final void Function({
    DiagnosticCategory? selectedCategory,
    DiagnosticCourse? selectedCourse,
    String? selectedStartDate,
    String? selectedEndDate,
  }) onPressed;

  const _DropdownsAndButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  __DropdownsAndButtonState createState() => __DropdownsAndButtonState();
}

class __DropdownsAndButtonState extends State<_DropdownsAndButton> {
  DiagnosticCategory? _selectedCategory;
  DiagnosticCourse? _selectedCourse;
  List<String> _dates = [];
  String? _selectedStartDate;
  String? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  void _initializeDates() {
    final today = DateTime.now();
    final oneYearFromNow = today.add(const Duration(days: 365));
    final dateList = <DateTime>[];

    for (var date = today;
        date.isBefore(oneYearFromNow);
        date = date.add(const Duration(days: 1))) {
      dateList.add(date);
    }

    setState(() {
      _dates = dateList
          .map((date) => DateFormat('yyyy-MM-dd').format(date))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Diagnostic Category'),
          Consumer<LiveFilterationProvider>(
            builder: (context, liveFilterationProvider, _) {
              return DropdownButton<DiagnosticCategory>(
                value: _selectedCategory,
                hint: const Text('Select Category'),
                items: liveFilterationProvider.categoryData.map((category) {
                  return DropdownMenuItem<DiagnosticCategory>(
                    value: category,
                    child: Text(category.categoryName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const Text('Diagnostic Course'),
          Consumer<LiveFilterationProvider>(
            builder: (context, liveFilterationProvider, _) {
              return DropdownButton<DiagnosticCourse>(
                value: _selectedCourse,
                hint: const Text('Select Course'),
                items: liveFilterationProvider.courseData.map((course) {
                  return DropdownMenuItem<DiagnosticCourse>(
                    value: course,
                    child: Text(course.courseName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCourse = value;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const Text('Start Date'),
          DropdownButton<String>(
            value: _selectedStartDate,
            hint: const Text('Select Start Date'),
            items: _dates.map((date) {
              return DropdownMenuItem<String>(
                value: date,
                child: Text(date),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedStartDate = value;
              });
            },
          ),
          const SizedBox(height: 10),
          const Text('End Date'),
          DropdownButton<String>(
            value: _selectedEndDate,
            hint: const Text('Select End Date'),
            items: _dates.map((date) {
              return DropdownMenuItem<String>(
                value: date,
                child: Text(date),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedEndDate = value;
              });
            },
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                widget.onPressed(
                  selectedCategory: _selectedCategory,
                  selectedCourse: _selectedCourse,
                  selectedStartDate: _selectedStartDate,
                  selectedEndDate: _selectedEndDate,
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent[700]!),
              ),
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
