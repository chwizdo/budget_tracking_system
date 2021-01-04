import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

/*
  Add ✅
  Update ✅
  Delete
  View
*/

class Category {
  // private variable
  String _uid;
  String _id;
  String _name;
  String _type;
  static List<Category> _list = [];

  // constructor to create new category
  // all fields are mandatory
  Category({
    @required String uid,
    String id = '',
    @required String name,
    @required String type,
    bool save = false,
  })  : _uid = uid,
        _id = id,
        _name = name,
        _type = type {
    if (save) {
      Firestore.instance
          .collection('users')
          .document(_uid)
          .collection('categories')
          .add(
        {
          'id': '',
          'name': _name,
          'type': _type,
        },
      ).then(
        (value) => {
          _id = value.documentID,
          Firestore.instance
              .collection('users')
              .document(_uid)
              .collection('categories')
              .document(value.documentID)
              .updateData({'id': value.documentID})
        },
      );
    }
  }

  // retrieve category id
  String get id {
    return _id;
  }

  // retrieve category name
  String get name {
    return _name;
  }

  // retrieve category type
  String get type {
    return _type;
  }

  static List<Category> get list {
    return _list;
  }

  // Update category properties
  void setProperties({String name, String type}) {
    _name = name;
    _type = type;
  }

  static List<Category> add(Category category) {
    _list.add(category);
    return _list;
  }

  // TODO delete category
  void rmCategory() {}

  // retrieve all categories in database
  static Future<void> getCategories({@required String uid}) async {
    _list = [];
    await Firestore.instance
        .collection('users')
        .document(uid)
        .collection('categories')
        .getDocuments()
        .then((querySnapshot) => {
              querySnapshot.documents.forEach((element) {
                Category.add(
                  Category(
                    uid: uid,
                    id: element.data['id'],
                    name: element.data['name'],
                    type: element.data['type'],
                  ),
                );
              }),
              print('Category retrieved: $_list')
            });
    return null;
  }
}
