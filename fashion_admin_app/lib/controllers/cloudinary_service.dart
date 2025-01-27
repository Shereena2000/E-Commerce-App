// import 'dart:convert';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import "package:http/http.dart" as http;

// import 'package:image_picker/image_picker.dart';

// Future<String?> uploadToCloudinary(XFile? xFile) async {
//   if (xFile == null) {
//     print("No file selected!");
//     return null;
//   }
// print("********");
//   // Get the Cloudinary cloud name from environment variables
//  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
// print("--------");
// print("cloudname$cloudName");
//   // Create a MultipartRequest to upload the file
//   var uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
//   var request = http.MultipartRequest("POST", uri);

//   // Read the file content as bytes using xFile.bytes() if it's an XFile
//   var fileBytes = await xFile.readAsBytes();

//   var multipartFile = http.MultipartFile.fromBytes(
//     'file', // The form field name for the file
//     fileBytes,
//     filename: xFile.name, // Use the name of the XFile
//   );

//   // Add the file part to the request
//   request.files.add(multipartFile);

//   // Add other form fields like 'upload_preset' and 'resource_type'
//   request.fields['upload_preset'] = "preset-for-file-upload";
//   request.fields['resource_type'] = "image";
//   request.fields['folder'] = 'products';//specific folder

//   // Send the request and await the response
//   var response = await request.send();

//   // Get the response as text
//   var responseBody = await response.stream.bytesToString();

//   // Print the response
//   print(responseBody);

//   if (response.statusCode == 200) {
//     var jsonResponse = jsonDecode(responseBody);
//     // Print the secure URL of the uploaded file
//     print("Upload successful!");
//     return jsonResponse["secure_url"];
//   } else {
//     print("Upload failed with status: ${response.statusCode}");
//     return null;
//   }
// }
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:image_picker/image_picker.dart';

Future<String?> uploadToCloudinary(XFile? xFile) async {
  if (xFile == null) {
    print("No file selected!");
    return null;
  }

  // Get the Cloudinary cloud name from environment variables
  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  if (cloudName.isEmpty) {
    print("Cloudinary cloud name is not set in .env file!");
    return null;
  }

  print("Uploading image to Cloudinary...");
  print("Cloud Name: $cloudName");

  try {
    // Create a MultipartRequest to upload the file
    var uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
    var request = http.MultipartRequest("POST", uri);

    // Read the file content as bytes using xFile.bytes() if it's an XFile
    var fileBytes = await xFile.readAsBytes();
    print("File size: ${fileBytes.length} bytes");

    var multipartFile = http.MultipartFile.fromBytes(
      'file', // The form field name for the file
      fileBytes,
      filename: xFile.name, // Use the name of the XFile
    );

    // Add the file part to the request
    request.files.add(multipartFile);

    // Add other form fields like 'upload_preset' and 'resource_type'
    request.fields['upload_preset'] = "preset-for-file-upload";
    request.fields['resource_type'] = "image";
    request.fields['folder'] = 'products'; // Specific folder

    // Send the request and await the response
    var response = await request.send();
    print("Response status code: ${response.statusCode}");

    // Get the response as text
    var responseBody = await response.stream.bytesToString();
    print("Response body: $responseBody");

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(responseBody);
      // Print the secure URL of the uploaded file
      print("Upload successful!");
      print("Secure URL: ${jsonResponse["secure_url"]}");
      return jsonResponse["secure_url"];
    } else {
      print("Upload failed with status: ${response.statusCode}");
      print("Response body: $responseBody");
      return null;
    }
  } catch (e) {
    print("Error uploading image to Cloudinary: $e");
    return null;
  }
}