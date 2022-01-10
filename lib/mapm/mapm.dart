import 'package:ecoresiduos/mapm/map_marker.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ecoresiduos/mapm/map_marker.dart';
import 'package:flutter_image/flutter_image.dart';


const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoiZm94aG9tZXJvMiIsImEiOiJja3doYTcyOXAwd2lkMnZuc2w5MGYybWd2In0.GeICrih1_ekYlnJHpQZ3iA';
const MAPBOX_STYLE = 'mapbox/streets-v11'; /// la informacion que va aca en que parte del mapbox esta 
const MARKER_COLOR = Color(0xFF3DC5A7);
const MARKER_SIZE_EXPANDED = 45.0;
const MARKER_SIZE_SHRINKED = 25.0;

double latitud = 5.337849371359686;
double longitud = -72.39068750324083;   
LatLng _myLocation = LatLng(latitud, longitud);
bool isVisible = false;



class Mapmscreen extends StatefulWidget {
  const Mapmscreen({ Key? key, required this.title}) : super(key: key);
 final String title;

  @override
  _MapmscreenState createState() => _MapmscreenState();
}

class _MapmscreenState extends State<Mapmscreen>  with SingleTickerProviderStateMixin{
  obtenerUbi() async{
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      double latitud2 = geoposition.latitude;
      double longitud2 = geoposition.longitude;
      _myLocation = LatLng(latitud2, longitud2);
    });
  }

////////////
///
///


 final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = -1;
  List<Marker> _buildMarkers(){
    final _markerList = <Marker>[];
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];  
      _markerList.add(
        Marker(
          height: MARKER_SIZE_EXPANDED,
          width: MARKER_SIZE_EXPANDED,
          point: mapItem.location, 
          builder: (_){
            return GestureDetector(
              onTap: (){
                _selectedIndex =i;
                setState(() {
                  isVisible = true;
                  _pageController.animateToPage(i, duration: const Duration(milliseconds: 500), curve: Curves.elasticOut);
                  print('Selected: ${mapItem.title}');
                });
              },
              child: _LocationMarker(
                selected: _selectedIndex==i,
              ),
            );
          },
        ),
      );
      
    }
    return _markerList;
  }

///
 @override
  void initState() {
    obtenerUbi();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animationController.repeat(reverse: true);
    super.initState();
  }
  //obtener ubicacion
   @override

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 14,
              center: _myLocation, 
              ///0.0
            ),
            nonRotatedLayers: [
              TileLayerOptions(
                urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': MAPBOX_STYLE, 
                },
              ),
              MarkerLayerOptions(
                markers: _markers,),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    height: 50,
                    width: 50,
                    point: _myLocation, //null null 
                    builder: (_){
                      return _MyLocationMarker(_animationController);
                    }),
                ],
              ),
            ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              height: MediaQuery.of(context).size.height * 0.3,
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mapMarkers.length,
                itemBuilder: (context, index){
                  final item = mapMarkers[index];
                  return _MapItemDetails(
                    mapMarker: item,
                  );
              },
              ),
            ),
        ]
      ),
    );
  }
}
class _LocationMarker extends StatelessWidget {
  const _LocationMarker({Key? key, this.selected = false}) : super(key: key);
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final size = selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: Image.asset('assets/marker.png'),
      ),
    );
  }
}

class _MyLocationMarker extends AnimatedWidget {
  const _MyLocationMarker(Animation<double> animation, {Key? key}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(0.5, 1.0, value)!;
    final size = 50.0;
    return Center(
      child: Stack (
        children: [
          Center(
            child: Container(
              height: size * newValue,
              width: size * newValue,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MARKER_COLOR.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: MARKER_COLOR,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      )
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({
    Key? key, 
    required this.mapMarker,
    }) : super(key: key);

  final MapMarker mapMarker;
  
  @override
  Widget build(BuildContext context) {
    final _styleTitle = TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold );
    final _styleAddress = TextStyle(color: Colors.grey[800], fontSize: 14);
    return Visibility(
      visible: isVisible,
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          margin: EdgeInsets.zero,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset(mapMarker.image),
                      ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Text(latitud.toString(), style: _styleTitle,),
                          Text(mapMarker.title, style: _styleTitle,),
                          const SizedBox(height: 10),
                          Text(mapMarker.address, style: _styleAddress,),
                        ],
                      ),
                    ),  
                  ],
                ),
              ),
              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () => null, 
                color: MARKER_COLOR,
                elevation: 6,
                child: Text(
                  'LLAMAR', 
                  style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}