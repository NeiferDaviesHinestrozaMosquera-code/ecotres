import 'package:latlong2/latlong.dart';

class MapMarker {
  const MapMarker({
    required this.image,
    required this.title,
    required this.address,
    required this.location,
  });
  final String image;
  final String title;
  final String address;
  final LatLng location;
}

final _locations = [
  LatLng(5.3186537614408, -72.40686580598808), //agrowplast
  LatLng(5.331516373101113, -72.39146001001332), //Recco Recycling SAS ESP
  LatLng(5.329267640543232, -72.3902294654887), //GREEN ENERGY CB SAS ESP
  LatLng(5.329655834849736, -72.40851202060053), //PEPSAR RECICLAMOS SAS
  LatLng(5.329378734846213, -72.39584599405488), //Asociación de Recuperadores de Yopal
 // LatLng(5.19077232, -72.24317952), //Ong
 
];

const _path = 'assets/';

final mapMarkers = [
  MapMarker(
    image: '${_path}agrowdos.png',
    title: 'Agrowplast',
    address: 'Calle 40 No. 4-10',
    location: _locations[0],
  ),

  MapMarker(
    image: '${_path}recco.png',
    title: 'Recco Recycling Sas',
    address: 'Carrera 20 No. 29-41',
    location: _locations[1],
  ),

  MapMarker(
    image: '${_path}green.png',
    title: 'GREEN ENERGY CB SAS',
    address: 'Carrera 20 No. 35-25',
    location: _locations[2],
  ),

   MapMarker(
    image: '${_path}PEPSAR.png',
    title: 'PEPSAR RECICLAMOS SAS',
    address: 'Carrera 5a con calle 25',
    location: _locations[3],
  ),

    MapMarker(
    image: '${_path}ary.jpg',
    title: 'Asociación de Recuperadores de Yopal',
    address: 'Calle 29b No. 16a-2',
    location: _locations[4],
  ),
];