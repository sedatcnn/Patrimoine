import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:patrimonie/page/add_task_page.dart';
import 'package:patrimonie/model/category_model.dart';
import 'package:patrimonie/core/service/category_service.dart';

class Harita extends StatefulWidget {
  const Harita({Key? key}) : super(key: key);

  @override
  State<Harita> createState() => _HaritaState();
}

class _HaritaState extends State<Harita> {
  final Location _locationController = Location();
  LatLng? _currentP;
  static const LatLng _pGooglePlex = LatLng(37.7669751, 30.5498804);
  bool _showMyWidget = false;
  final CategoryService _categoryService = CategoryService();
  Future<List<Category>>? _categoryFuture;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _categoryFuture = _categoryService.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _pGooglePlex,
              zoom: 13,
            ),
            markers: {
              const Marker(
                markerId: MarkerId("_sourceLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: _pGooglePlex,
              ),
            },
          ),
          Positioned(
            bottom: 150,
            left: 20,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  _showMyWidget = !_showMyWidget;
                });
                if (!_showMyWidget && _categoryFuture == null) {
                  await _fetchData(); // Fetch categories if needed
                }
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          if (_showMyWidget)
            FutureBuilder<List<Category>>(
              future: _categoryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return Center(
                    child: MyWidget(
                      categories: snapshot.data!,
                      onClose: () {
                        setState(() {
                          _showMyWidget = false;
                        });
                      },
                    ),
                  );
                }
              },
            ),
        ],
      ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
    }
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          print(_currentP);
        });
      }
    });
  }
}

class MyWidget extends StatefulWidget {
  final List<Category> categories;
  final VoidCallback onClose;

  const MyWidget({
    Key? key,
    required this.categories,
    required this.onClose,
  }) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<bool> _selected = [];

  @override
  void initState() {
    super.initState();
    _selected = List.filled(widget.categories.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    _getIconForCategory(widget.categories[index].name),
                    color: Color.fromARGB(
                        255, 194, 65, 0), // Optional: Set icon color
                    size: 35.0, // Optional: Set icon size
                  ),
                  title: Text(widget.categories[index].name),
                  trailing: Checkbox(
                    value: _selected[index],
                    onChanged: (value) {
                      setState(() => _selected[index] = value!);
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              List<Category> selectedCategories = [];
              for (int i = 0; i < _selected.length; i++) {
                if (_selected[i]) {
                  selectedCategories.add(widget.categories[i]);
                }
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskPage(
                    selectedCategories: selectedCategories,
                  ),
                ),
              );
            },
            child: Text('Oluştur'),
          ),
        ],
      ),
    );
  }

  IconData _getIconForCategory(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'müze':
        return Icons.museum;
      case 'spor':
        return Icons.sports;
      case 'mesire alanı':
        return Icons.park;
      case 'sinema':
        return Icons.movie;
      default:
        return Icons.category; // Default icon
    }
  }
}
