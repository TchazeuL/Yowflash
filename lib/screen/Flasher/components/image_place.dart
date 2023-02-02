import "package:flutter/material.dart";
import "dart:io";
import "package:image_picker/image_picker.dart";

class ImagePlace extends StatefulWidget {
  const ImagePlace({super.key});

  @override
  State<StatefulWidget> createState() => _ImagePlace();
}

class _ImagePlace extends State<ImagePlace> {
  File? _imageFile;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ButtonBar(
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () async => _pickImageFromCamera(),
                icon: const Icon(
                  Icons.photo_camera,
                )),
            IconButton(
                onPressed: () async => _pickImageFromGallery(),
                icon: const Icon(
                  Icons.photo,
                )),
          ],
        ),
        if (_imageFile == null)
          Container(
              width: 350.0,
              height: 200.0,
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Placeholder(
                  fallbackHeight: 250.0,
                  fallbackWidth: 350.0,
                  strokeWidth: 0.0,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("Inserez l'image de votre produit"),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  )))
        else
          Image.file(_imageFile!)
      ],
    );
  }

  Future<void> _pickImageFromGallery() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() => _imageFile = File(pickedFile!.path));
  }

  Future<void> _pickImageFromCamera() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    setState(() => _imageFile = File(pickedFile!.path));
  }
}
