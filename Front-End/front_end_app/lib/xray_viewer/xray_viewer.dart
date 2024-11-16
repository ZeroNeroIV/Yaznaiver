import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class XrayViewerPage extends StatefulWidget {
  const XrayViewerPage({super.key});

  @override
  _XrayViewerPageState createState() => _XrayViewerPageState();
}

class _XrayViewerPageState extends State<XrayViewerPage> {
  double _rotation = 0;
  File? _image;
  final List<Annotation> _annotations = [];
  final TransformationController _transformationController = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('X-ray Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_right),
            onPressed: _rotateImage,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showImageInfo,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildImageViewer(),
          ),
          _buildAddAnnotationButton(),  // Keep only the "Add" icon button
        ],
      ),
    );
  }

  Widget _buildImageViewer() {
    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: 0.5,
      maxScale: 4.0,
      child: Stack(
        children: [
          Center(
            child: _image == null
                ? const Text('No image selected')
                : Transform.rotate(
                    angle: _rotation,
                    child: Image.file(_image!),
                  ),
          ),
          ..._annotations.map((annotation) => Positioned(
                left: annotation.offset.dx,
                top: annotation.offset.dy,
                child: GestureDetector(
                  onTap: () => _showAnnotationDetails(annotation),
                  child: const Icon(Icons.location_pin, color: Colors.red),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAddAnnotationButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: FloatingActionButton(
          onPressed: _addAnnotation,
          tooltip: 'Add Annotation',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _rotateImage() {
    setState(() {
      _rotation += 90 * (3.14159 / 180); // Rotate 90 degrees
    });
  }

  void _showImageInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('X-ray Image Info'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('File name: ${_image?.path.split('/').last ?? 'N/A'}'),
              Text('Date taken: ${DateTime.now().toString()}'),
              Text('Annotations: ${_annotations.length}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _annotations.clear();
      });
    }
  }

  void _addAnnotation() {
    if (_image == null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final center = Offset(size.width / 2, size.height / 2);

    setState(() {
      _annotations.add(Annotation(center, 'New annotation'));
    });
  }

  void _showAnnotationDetails(Annotation annotation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Annotation Details'),
          content: Text(annotation.description),
          actions: [
            TextButton(
              child: const Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop();
                _editAnnotation(annotation);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  _annotations.remove(annotation);
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _editAnnotation(Annotation annotation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newDescription = annotation.description;
        return AlertDialog(
          title: const Text('Edit Annotation'),
          content: TextField(
            onChanged: (value) => newDescription = value,
            decoration: const InputDecoration(hintText: 'Enter new description'),
            controller: TextEditingController(text: annotation.description),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  annotation.description = newDescription;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Annotation {
  Offset offset;
  String description;

  Annotation(this.offset, this.description);
}
