import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/comment_model.dart';

class DatabaseHelper {

  static Database? _db;

  static Future<Database> getDatabase() async {

    if (_db != null) {
      return _db!;
    }

    await deleteDatabase(
      join(
        await getDatabasesPath(),
        'forum.db',
      ),
    );

    _db = await openDatabase(

      join(
        await getDatabasesPath(),
        'forum.db',
      ),

      version: 1,

      onCreate: (db, version) async {

        // =====================
        // TABEL FORUM
        // =====================
        await db.execute('''
        CREATE TABLE forum(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          judul TEXT,
          isi TEXT,
          genre TEXT,
          status TEXT
        )
        ''');

        // =====================
        // TABEL KOMENTAR
        // =====================
        await db.execute('''
        CREATE TABLE komentar(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          forum_id INTEGER,
          username TEXT,
          pesan TEXT
        )
        ''');

        // =====================
        // TABEL USER
        // =====================
        await db.execute('''
        CREATE TABLE users(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT,
  password TEXT,
  social_media TEXT,
  foto_profil TEXT
)
        ''');

        // =====================
        // DATA AWAL USER
        // =====================
        await db.insert('users', {
          'username': 'Adzra',
          'password': '123',
          'social_media': '@adzraaditama',
          'foto_profil': 'assets/pfp-adzra.jpeg',
        });

        await db.insert('users', {
          'username': 'Sharone',
          'password': '123',
          'social_media': '@sharonejpw',
          'foto_profil': 'assets/sharone.jpeg',
        });

        await db.insert('users', {
          'username': 'Feby',
          'password': '123',
          'social_media': '@khansafby',
          'foto_profil': 'assets/f1-picture.jpg',
        });
      },
    );

    return _db!;
  }

  // =====================
  // USER
  // =====================

  static Future<List<Map<String, dynamic>>>
  getUsers() async {

    final db = await getDatabase();

    return await db.query(
      'users',
      orderBy: 'id DESC',
    );
  }

  static Future<Map<String, dynamic>>
  getUserById(int id) async {

    final db = await getDatabase();

    final result = await db.query(
      'users',
      where: 'id=?',
      whereArgs: [id],
    );

    return result.first;
  }

  static Future<int> updateUser(
      int id,
      String username,
      String socialMedia,
      String fotoProfil,
      ) async {

    final db = await getDatabase();

    return await db.update(
      'users',
      {
        'username': username,
        'social_media': socialMedia,
        'foto_profil': fotoProfil,
      },
      where: 'id=?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteUser(
      int id,
      ) async {

    final db = await getDatabase();

    return await db.delete(
      'users',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  // =====================
  // login
  // =====================

  static Future<Map<String, dynamic>?>
  loginUser(
      String username,
      String password,
      ) async {

    final db =
    await getDatabase();

    final result = await db.query(
      'users',
      where:
      'username=? AND password=?',
      whereArgs: [
        username,
        password,
      ],
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }
  // =====================
  // KOMENTAR FORUM
  // =====================

  static Future<int> tambahKomentar(
      int forumId,
      String username,
      String pesan,
      ) async {

    final db = await getDatabase();

    return await db.insert(
      'komentar',
      {
        'forum_id': forumId,
        'username': username,
        'pesan': pesan,
      },
    );
  }

  static Future<List<Map<String, dynamic>>>
  getKomentarByForum(
      int forumId) async {

    final db = await getDatabase();

    return await db.query(
      'komentar',
      where: 'forum_id=?',
      whereArgs: [forumId],
      orderBy: 'id DESC',
    );
  }

  // =====================
  // KOMENTAR buku
  // ====================='
  static Future<int> hapusKomentarfeby(int id) async {

    final db = await getDatabase();

    return await db.delete(
      'komentar',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>>
  ambilSemuaKomentarfeby() async {

    final db = await getDatabase();

    return await db.query(
      'komentar',
      orderBy: 'id DESC',
    );
  }

  static Future<int> tambahKomentarFeby(
      CommentModel comment,
      ) async {

    final db = await getDatabase();

    return await db.insert(
      'komentar',
      comment.toMap(),
    );
  }
}

