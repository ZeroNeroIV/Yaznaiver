import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'dart:io';

import 'package:yaznaiver/xray_viewer/xray_viewer_annotation.dart';

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
        title: Text(AppLocalizations.of(context)!.xray_viewer),
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
          _buildAddAnnotationButton(), // Keep only the "Add" icon button
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
                ? Text(AppLocalizations.of(context)!.under_maintainence)
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
          tooltip: AppLocalizations.of(context)!.add_annotation,
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
          title: Text(AppLocalizations.of(context)!.xray_image_info),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${AppLocalizations.of(context)!.file_name}: ${_image?.path.split('/').last ?? 'N/A'}'),
              Text('${AppLocalizations.of(context)!.date_taken}: ${DateTime.now().toString()}'),
              Text('${AppLocalizations.of(context)!.annotations}: ${_annotations.length}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.close),
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
      _annotations.add(Annotation(center, AppLocalizations.of(context)!.new_annotation));
    });
  }

  void _showAnnotationDetails(Annotation annotation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.annotation_details),
          content: Text(annotation.description),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.edit),
              onPressed: () {
                Navigator.of(context).pop();
                _editAnnotation(annotation);
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.delete),
              onPressed: () {
                setState(() {
                  _annotations.remove(annotation);
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.close),
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
          title: Text(AppLocalizations.of(context)!.edit_annotation),
          content: TextField(
            onChanged: (value) => newDescription = value,
            decoration: InputDecoration(hintText: AppLocalizations.of(context)!.enter_new_description),
            controller: TextEditingController(text: annotation.description),
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.save),
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
