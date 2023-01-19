import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';
import 'package:time_tracking_demo/models/task_model.dart';

class FirebaseConstant {
  static final FirebaseFirestore _fireStoreData = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static setCollection(
      {required String collectionName,required Map<String, dynamic> value}) {
    return _fireStoreData
        .collection(collectionName ?? '').add(value);
  }

  static fetchCollection({String? collectionName, String? docId}) {
    return _fireStoreData
        .collection(collectionName ?? '')
        .doc(docId ?? '')
        .get();
  }

  static fetchCollections({required String collectionName}) {
    return _fireStoreData
        .collection(collectionName ?? '')
        .get();
  }

  /// Get task from [Collection]
  Future<List<TaskModel>> get task async {
    try {
      QuerySnapshot<Map<String, dynamic>> task = await _fireStoreData
          .collection(StringConstant.taskCollection)
          .get();
      List<TaskModel> task1 = task.docs.toList().map((e) => TaskModel.fromMap(e.id ,e.data())).toList();
      return task1;
    } catch (e) {
      return [];
    }
  }

  Future<String> get userId async {
    try {
      UserCredential users = await _auth.signInAnonymously();
      if(users.user != null){
        return users.user?.uid.toString() ?? '';
      }else{
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  static fetchDocumentSnapShot({String? collectionName, String? docId}) {
    return _fireStoreData
        .collection(collectionName ?? '')
        .doc(docId ?? '')
        .snapshots()
        .asBroadcastStream();
  }

  static updateCollection(
      {String? collectionName, String? docId, Map<String, dynamic>? value}) {
    return _fireStoreData
        .collection(collectionName ?? '')
        .doc(docId ?? '')
        .update(value ?? {});
  }

  static fetchWhereSnapShot({String? collectionName, List<dynamic>? docId}) {
    return _fireStoreData
        .collection(collectionName ?? '')
        .where('doc_id', whereIn: docId)
        .snapshots();
  }

  static fetchSnapShot({String? collectionName}) {
    return _fireStoreData.collection(collectionName ?? '').snapshots();
  }

  static uploadStorage({String? child, File? file}) {
    return _firebaseStorage.ref().child(child ?? '').putFile(file ?? File(''));
  }
}
