import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(23.79348696073093, 90.40612976653253),
          zoom: 16,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        onCameraMove: (CameraPosition cameraPosition) {
          // print(cameraPosition);
        },
        onCameraIdle: () {
          print('Fetching data');
        },
        onTap: (LatLng latLng) {
          print(latLng);
        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        mapToolbarEnabled: true,
        markers: <Marker>{
          Marker(
            markerId: MarkerId('my-office'),
            position: LatLng(23.79387450015791, 90.40334499572938),
            draggable: true,
            flat: false,
            onTap: () {
              print('Tapped on my office marker');
            },
            onDrag: (LatLng latLng) {
              // print(latLng);
            },
            onDragEnd: (LatLng latLng) {
              print(latLng);
            },
            onDragStart: (LatLng latLng) {
              print(latLng);
            },
            infoWindow: InfoWindow(
              title: 'My office',
              onTap: () {
                print('Tapped on info window');
              },
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
          ),
          Marker(
            markerId: MarkerId('abc'),
            position: LatLng(23.79684464759991, 90.40387496352196),
          ),
          Marker(
            markerId: MarkerId('abcd'),
            position: LatLng(23.79499602888209, 90.40309477597475),
          ),
        },
        circles: <Circle>{
          Circle(
            circleId: CircleId('redZone'),
            center: LatLng(23.792768202843146, 90.40476445108652),
            radius: 300,
            onTap: () {
              print('Tapped on my circle');
            },
            fillColor: Colors.red.shade50,
            strokeColor: Colors.red,
            strokeWidth: 3,
            consumeTapEvents: true,
            visible: true,
          ),
          Circle(
            circleId: CircleId('redZone2'),
            center: LatLng(23.80456861969784, 90.40649212896824),
            radius: 100,
            onTap: () {
              print('Tapped on my circle');
            },
            fillColor: Colors.red.shade50,
            strokeColor: Colors.red,
            strokeWidth: 3,
            consumeTapEvents: true,
            visible: true,
          ),
        },
        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('myRoad'),
            points: [
              LatLng(23.799414447746496, 90.4016088321805),
              LatLng(23.80788151356167, 90.40310718119144),
              LatLng(23.801541849182904, 90.40652431547642),
            ],
            width: 6,
            jointType: JointType.round,
            endCap: Cap.roundCap,
          ),
        },
        polygons: <Polygon>{
          Polygon(
            polygonId: PolygonId('sample-polygon'),
            points: [
              LatLng(23.763716458116864, 90.42221926152706),
              LatLng(23.73743304429425, 90.46579040586948),
              LatLng(23.779027052978922, 90.47789622098207),
              LatLng(23.791015856765696, 90.44456675648689),
              LatLng(23.766116001058332, 90.41822377592325),
              LatLng(23.743719978714953, 90.42721454054117),
            ],
            fillColor: Colors.blue.shade50,
            strokeWidth: 2,
            strokeColor: Colors.blue,
            onTap: () {},
            consumeTapEvents: true,
          ),
        },
        onLongPress: (LatLng latLng) {},
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              // _mapController.moveCamera(
              //   CameraUpdate.newCameraPosition(
              //     CameraPosition(
              //       target: LatLng(23.79348696073093, 90.40612976653253),
              //       zoom: 16,
              //     ),
              //   ),
              // );
              _mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(23.79348696073093, 90.40612976653253),
                    zoom: 16,
                  ),
                ),
              );
            },
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
