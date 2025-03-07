import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ZoomPage extends StatefulWidget {
  const ZoomPage({super.key});

  @override
  ZoomPageState createState() => ZoomPageState();
}

class ZoomPageState extends State<ZoomPage> {

    CameraController? _controller;
  List<CameraDescription>? cameras;
   double _zoom = 2.5;
   double minZoom = 1.0; // Default minimum zoom level
double maxZoom = 5.0;
   @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _controller = CameraController(cameras![0], ResolutionPreset.high);
      await _controller!.initialize();
     maxZoom = await _controller!.getMaxZoomLevel();
     minZoom = await _controller!.getMinZoomLevel();
     _zoom = _zoom.clamp(minZoom, maxZoom); 
      setState(() {});
    }
  }
    @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _zoomIn() {
    if (_controller != null) {
      setState(() {
       
        _zoom = (_zoom + 0.5).clamp(minZoom,maxZoom); // Max zoom 4x
        _controller!.setZoomLevel(_zoom);
      });
    }
  }

  void _zoomOut() {
    if (_controller != null) {
      setState(() {
        _zoom = (_zoom - 0.5).clamp(minZoom,maxZoom); // Min zoom 1x
        _controller!.setZoomLevel(_zoom);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text("Zoom")),
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Positioned(
            bottom: 20,
            left: 50,
            right: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: Icon(Icons.zoom_out),
                ),
                FloatingActionButton(
                  onPressed: _zoomIn,
                  child: Icon(Icons.zoom_in),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
