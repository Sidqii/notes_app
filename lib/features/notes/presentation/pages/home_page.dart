import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/features/notes/presentation/pages/page_add_notes.dart';
import 'package:note_pad/features/notes/presentation/pages/page_edit_note.dart';
import 'package:note_pad/features/notes/presentation/widgets/card_note_tiles.dart';
import '../bloc/crud/notes_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Note list',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotesLoadedState) {
            final notes = state.note;

            if (notes.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('📦', style: TextStyle(fontSize: 50)),
                    Text("Note's empty"),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<NotesBloc>().add(LoadNotesEvent());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final item = notes[index];

                    return CardNoteTiles(
                      key: ValueKey(item.id),
                      note: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageEditNote(note: item),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          }

          if (state is NotesErrorState) {
            return Center(child: Text(state.message));
          }

          return const Center(
            child: Text(
              '404 Error not found.',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageAddNotes()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
