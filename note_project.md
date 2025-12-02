*Micro - steps project notes*

# Langkah 1: Membangun *Entities*
`lib/features/notes/domain/entities/note_entity.dart`  

**Tujuan**: Data murni, immutable, tanpa logic penyimpanan.

# Langkah 2: Menentukan *Usecase* dan Membangun *Usecase*
`lib/features/notes/usecases/...`  

**Tujuan**: Pengatur fungsi aplikasi (fitur apa saja dalam apps note), semisal ada fitur baru tambahkan dalam **usecase**.  

**Komponennya**:
- `get`
- `create`
- `update`
- `delete`
> Buat dalam file terpisah, satu aksi bisnis → satu class → satu file.

# Langkah 3: Membangun *Abstract Repository*
`lib/features/notes/domain/repositories/note_repository.dart`  

**Tujuan**: Usecase bisa manggil **repository** tanpa tau bagaimana data disimpan.

# Langkah 4: Membangun Model (*NoteModel*)
`lib/features/notes/data/models/note_model.dart`  

Model merupakan **versi data yang siap disimpan**.  
- `note_entity.dart` = Bentuk murni.  
- `note_model.dart` = Bentuk untuk penyimpanan.

> `NoteModel()` extends `NoteEntity()`. Model boleh punya fungsi tambahan yang tidak dimiliki `NoteEntity()`.

# Langkah 5: Menambahkan `ToMap()` dan `FromMap()` kedalam `NoteModel()`
`lib/features/notes/data/models/note_model.dart`  

`ToMap()` untuk menyimpan data dan `FromMap()` untuk membaca data dari storage dan merubahnya jadi **NoteModel**.  

>Tidak perlu `ToEntity()` atau `FromEntity()` karna sudah extends **NoteEntity**.

# Langkah 6: Membangun *Abstract Local Data Source*
`lib/features/notes/data/datasources/note_local_datasources.dart`  

`NoteLocalDatasource()` bentuknya mirip `NoteRepository()`, namun diperuntukan untuk `NoteModel()`, bukan `NoteEntity()`. Nantinya `NoteRepositoryImpl()` akan menggabungkan **domain** + **datasource**.

**datasource** = Tempat kerja kotornya (storage, file, sharedprefs, hive, dll).  
**domain** = Yang mengatur perintahnya.

# Langkah 7: Membangun *Repository Impl* (Penghubung domain ↔ datasource)

`RepositoryImpl()` adalah jembatan antara **usecase** (dalam domain) dan **datasource** (dalam data).  

Alurnya: 
- `RepositoryImpl()` menerima `NoteEntity()` dari **usecase**.
- `RepositoryImpl()` memanggil **datasource** yang bekerja dengan `NoteModel()`.
- `RepositoryImpl()` mengkonversi `NoteEntity()` → `NoteModel()`
- `return` **data** ke **domain**