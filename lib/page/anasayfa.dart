import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patrimonie/core/service/grup_service.dart';
import 'package:patrimonie/core/service/task_controller.dart';
import 'package:patrimonie/model/grup.dart';
import 'package:patrimonie/model/task.dart';
import 'package:patrimonie/model/widgets/theme.dart';
import 'package:patrimonie/model/widgets/task_tile.dart';
import 'package:patrimonie/page/add_grup.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String todayDateIs = DateTime.now().toString().substring(0, 10);
  final DateTime _selectedDateTime = DateTime.now();
  final _taskController = Get.put(TaskController());
  String? _selectedGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(255, 236, 243, 0.8)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "asset/images/P.png",
                      height: 58,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sedat ÇANDIR",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 21),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Hoşgeldin ! Keşfetmeye başla.",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      "asset/images/P.png",
                      height: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _addDateBar(),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Align vertically
                  children: [
                    const Expanded(
                      child: Text(
                        "Gruplar",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddGrupPage()),
                        );
                      },
                      icon: const Icon(FontAwesomeIcons.plus),
                      color: Colors.white,
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 228, 76, 34))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                _buildGroupsList(),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Planlar",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
                _showTask(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showTask() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];

              bool isDateMatch =
                  task.date == DateFormat.yMd().format(_selectedDateTime);
              bool isGroupMatch =
                  _selectedGroup == null || task.group == _selectedGroup;

              if (isDateMatch && isGroupMatch) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task, null),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(60),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(10),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Get.isDarkMode ? darkGreyClr : Colors.white,
        ),
        child: Column(
          children: [
            Container(
              width: 90,
              height: 5, // Added height to make it visible
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task.id!);
                _taskController.getTasks();
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context,
            ),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              isClose: true,
              clr: Colors.red[300]!,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupsList() {
    final grupsService = GrupsService();
    return StreamBuilder<List<Grups>>(
      stream: grupsService.getGrups(), // Stream from GrupsService
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final groups = snapshot.data!; // Get the list of groups

        return SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal, // Set scroll direction
            itemCount: groups.length,
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemBuilder: (context, index) {
              final group = groups[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGroup = group.name; // Grubu seç
                  });
                },
                child: GroupTile(group: group), // Use GroupTile widget
              );
            },
          ),
        );
      },
    );
  }

  _addDateBar() {
    DateTime _selectedDateTime = DateTime.now();
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        inactiveDates: [
          for (DateTime date = DateTime.now().add(const Duration(days: 1));
              date.isBefore(DateTime.now().add(const Duration(days: 365)));
              date = date.add(const Duration(days: 1)))
            date
        ],
        daysCount: 7,
        locale: "tr_TR",
        onDateChange: (date) {
          setState(() {
            _selectedDateTime = date;
            _selectedGroup = null;
          });
        },
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  final Grups group;

  const GroupTile({required this.group, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 72, 37, 37),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              group.name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
