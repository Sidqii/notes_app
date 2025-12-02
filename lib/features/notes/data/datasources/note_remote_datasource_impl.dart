import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_pad/features/notes/data/datasources/note_remote_datasource.dart';
import 'package:note_pad/features/notes/data/models/note_model.dart';

class NoteRemoteDatasourceImpl implements NoteRemoteDatasource {
  final collection = FirebaseFirestore.instance.collection('notes');

  @override
  Future<void> createNote(NoteModel note) async {
    await collection.doc(note.id).set(note.toMap());
  }

  @override
  Stream<List<NoteModel>> getNotes() {
    return collection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((docs) => NoteModel.fromMap(docs.data()))
              .toList(),
        );
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await collection.doc(note.id).update(note.toMap());
  }

  @override
  Future<void> deleteNote(String id) async {
    await collection.doc(id).delete();
  }
}
