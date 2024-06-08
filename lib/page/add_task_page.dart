import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patrimonie/core/service/grup_service.dart';
import 'package:patrimonie/core/service/task_controller.dart';
import 'package:patrimonie/model/grup.dart';
import 'package:patrimonie/model/task.dart';
import 'package:patrimonie/model/widgets/theme.dart';
import 'package:patrimonie/model/widgets/button.dart';
import 'package:patrimonie/model/widgets/input_field.dart';
import 'package:patrimonie/page/anasayfa.dart';
import 'package:patrimonie/model/category_model.dart';
import 'package:patrimonie/page/navbar/nav_controller.dart';

class AddTaskPage extends StatefulWidget {
  final List<Category> selectedCategories;

  const AddTaskPage({
    super.key,
    required this.selectedCategories,
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final GrupsService _grupsService = Get.put(GrupsService());

  final TextEditingController _titleController = TextEditingController();

  final DateTime _selectedDateTime = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedUlasim = "Otobüs";
  List<String> ulasimList = ["Otobüs", "Araba", "Yürüme"];
  int _selectedColor = 0;
  String? _selectedGroup;

  List<String> _allGroups = [];

  @override
  void initState() {
    super.initState();
    _getGroups();
  }

  Future<void> _getGroups() async {
    Stream<List<Grups>> groupsStream = _grupsService.getGrups();
    List<String> groupNames = [];

    await for (List<Grups> groups in groupsStream) {
      groupNames.addAll(groups.map((group) => group.name).toList());
      setState(() {
        _allGroups = groupNames;
      });
    }
  }

  List<DropdownMenuItem<String>> _buildGroupsDropdown() {
    // Eğer _selectedGroup null ise varsayılan olarak "Kişisel" değerini ekleyelim
    List<DropdownMenuItem<String>> items = _allGroups.map((group) {
      return DropdownMenuItem<String>(
        value: group,
        child: Text(group),
      );
    }).toList();

    // _selectedGroup null ise "Kişisel" değerini ekle
    if (_selectedGroup == null) {
      items.insert(
          0,
          DropdownMenuItem<String>(
            value: "Kişisel",
            child: Text("Kişisel"),
          ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Etkinlik Oluştur",
                style: headingStyle,
              ),
              MyInputField(
                title: "Açıklama",
                hint: "...",
                controller: _titleController,
              ),
              DateInput(
                title: "Tarih",
                controller: TextEditingController(
                  text: DateFormat('dd.MM.yyyy').format(_selectedDateTime),
                ),
              ),
              MyInputField(
                title: "Kategori",
                hint: "Seçilen Kategoriler",
                widget: Text(
                    widget.selectedCategories.map((e) => e.name).join(", ")),
              ),
              MyInputField(
                title: "Grup",
                hint: "Seçin",
                widget: DropdownButton<String>(
                  value: _selectedGroup ??
                      "Kişisel", // Eğer _selectedGroup null ise "Kişisel" olarak ayarla
                  items: _buildGroupsDropdown(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGroup = newValue;
                    });
                  },
                ),
              ),
              MyInputField(
                title: "Ulaşım",
                hint: "Ulaşım seçin",
                widget: DropdownButton<String>(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  iconSize: 32,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUlasim = newValue!;
                    });
                  },
                  value: _selectedUlasim,
                  items:
                      ulasimList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Saat",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
              MyInputField(
                title: "Hatırlatma",
                hint: "$_selectedRemind dakika da bir",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  elevation: 4,
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallete(),
                  MyButton(label: "Oluştur", onTap: () => _validateData()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty) {
      _addTaskToDb();
      Get.to(() => const MyBottomNavBar());
    } else {
      Get.snackbar(
        "Gerekli",
        "Tüm alanlar zorunludur.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
        colorText: pinkClr,
      );
    }
  }

  _addTaskToDb() async {
    _taskController.addTask(
      task: Task(
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDateTime),
        startTime: _startTime,
        ulasim: _selectedUlasim,
        remind: _selectedRemind,
        color: _selectedColor,
        group: _selectedGroup,
        category: widget.selectedCategories.map((e) => e.name).toList(),
      ),
    );
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List.generate(
            3,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : yellowClr,
                    child: _selectedColor == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
    } else if (isStartTime == true) {
      setState(() {
        _startTime = formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: Get.isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
