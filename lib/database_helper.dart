import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/comment_model.dart';
import 'models/favorite_book.dart';
import 'models/user_model.dart';

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

  

         await db.execute('''
      CREATE TABLE komentar(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        comment TEXT NOT NULL
      )
      ''');

      await db.execute('''
      CREATE TABLE favorite(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        imagePath TEXT NOT NULL
      )
      ''');

      await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        social_media TEXT,
        foto_profil TEXT,
        points INTEGER DEFAULT 0
      )
      ''');

      await db.execute('''
      CREATE TABLE books(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      author TEXT NOT NULL,
      imagePath TEXT NOT NULL,
      premium_point INTEGER DEFAULT 0
      )
      ''');

      await db.execute('''
      CREATE TABLE premium_books(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      book_title TEXT NOT NULL
      )
      ''');
      await db.execute('''
      CREATE TABLE resume_buku(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul_buku TEXT,
        isi_resume TEXT,
        tanggal TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE riwayat_baca(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT,
        image TEXT,
        tanggal TEXT
      )
    ''');

      await db.execute('''
      CREATE TABLE book_contents(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL
      )
      ''');

      await db.execute('''
CREATE TABLE buku_user(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  judul TEXT,
  genre TEXT,
  isi TEXT,
  gambar TEXT
)
''');

      await db.insert('users',{
        'username':'Adzra',
        'password':'123',
        'social_media':'@adzraaditama',
        'foto_profil':'assets/pfp-adzra.jpeg',
        'points':500,
      });

      await db.insert('users',{
        'username':'Sharone',
        'password':'123',
        'social_media':'@sharonejpw',
        'foto_profil':'assets/sharone.jpeg',
        'points':600,
      });

      await db.insert('users',{
        'username':'Feby',
        'password':'123',
        'social_media':'@khansafby',
        'foto_profil':'assets/f1-picture.jpg',
        'points':200,
      });


      List<Map<String,dynamic>> books = [
        {
          'title':'Bumi',
          'author':'Tere Liye',
          'imagePath':'assets/cover/bumi.jpeg',
          'premium_point':100,
        },
        {
          'title':'Bendera Setengah Tiang',
          'author':'Annisa Lim',
          'imagePath':'assets/cover/BST.jpeg',
          'premium_point':150,
        },
        {
          'title':'Hujan',
          'author':'Tere Liye',
          'imagePath':'assets/cover/hujan.jpeg',
          'premium_point':120,
        },
        {
          'title':'Laut Bercerita',
          'author':'Leila S Chudori',
          'imagePath':'assets/cover/LB.jpeg',
          'premium_point':165,
        },
        {
          'title':'KKN di Desa Penari',
          'author':'Simpleman',
          'imagePath':'assets/cover/kkn.jpeg',
          'premium_point':200,
        },
        {
          'title':'Naruto',
          'author':'Masashi Kishimoto',
          'imagePath':'assets/cover/naruto.jpeg',
          'premium_point':250,
        },
      ];

      for(var book in books){
        await db.insert('books',book);
      }


      await db.insert('book_contents',{
        'title':'Bumi',
        'content':
       "BAB 1 \n\n"
                          "Raib, gadis istimewa keturunan Klan Bulan, memiliki kemampuan menghilang dan mewarisi Buku Kehidupan yang membuka portal ke dunia lain. Seli, sang penjinak api dari Klan Matahari, dikenal tekadnya yang kuat dan pantang menyerah."
                          "Sementara Ali, pemuda pemberani dari Klan Bumi, memiliki kemampuan unik berkomunikasi dengan hewan. Mereka saling menyadari memiliki kekuatan super ketika terjadi insiden tower listrik di sekolah jatuh menimpa mereka. "
                          "Alih-alih celaka, ketiganya mampu mengendalikan jatuhnya tiang listrik dan membuat Tamus mengetahui keberadaan mereka.",
      });

      await db.insert('book_contents',{
        'title':'Hujan',
        'content':
        "BAB 1 \n\n"
                          "Raib, gadis istimewa keturunan Klan Bulan, memiliki kemampuan menghilang dan mewarisi Buku Kehidupan yang membuka portal ke dunia lain. Seli, sang penjinak api dari Klan Matahari, dikenal tekadnya yang kuat dan pantang menyerah."
                          "Sementara Ali, pemuda pemberani dari Klan Bumi, memiliki kemampuan unik berkomunikasi dengan hewan. Mereka saling menyadari memiliki kekuatan super ketika terjadi insiden tower listrik di sekolah jatuh menimpa mereka. "
                          "Alih-alih celaka, ketiganya mampu mengendalikan jatuhnya tiang listrik dan membuat Tamus mengetahui keberadaan mereka.",
      });

      await db.insert('book_contents',{
        'title':'Laut Bercerita',
        'content':
        "BAB 1 \n\n"
                          "Raib, gadis istimewa keturunan Klan Bulan, memiliki kemampuan menghilang dan mewarisi Buku Kehidupan yang membuka portal ke dunia lain. Seli, sang penjinak api dari Klan Matahari, dikenal tekadnya yang kuat dan pantang menyerah."
                          "Sementara Ali, pemuda pemberani dari Klan Bumi, memiliki kemampuan unik berkomunikasi dengan hewan. Mereka saling menyadari memiliki kekuatan super ketika terjadi insiden tower listrik di sekolah jatuh menimpa mereka. "
                          "Alih-alih celaka, ketiganya mampu mengendalikan jatuhnya tiang listrik dan membuat Tamus mengetahui keberadaan mereka.",
      });

      await db.insert('book_contents',{
        'title':'KKN di Desa Penari',
        'content':
        "BAB 1 \n\n"
                          "Raib, gadis istimewa keturunan Klan Bulan, memiliki kemampuan menghilang dan mewarisi Buku Kehidupan yang membuka portal ke dunia lain. Seli, sang penjinak api dari Klan Matahari, dikenal tekadnya yang kuat dan pantang menyerah."
                          "Sementara Ali, pemuda pemberani dari Klan Bumi, memiliki kemampuan unik berkomunikasi dengan hewan. Mereka saling menyadari memiliki kekuatan super ketika terjadi insiden tower listrik di sekolah jatuh menimpa mereka. "
                          "Alih-alih celaka, ketiganya mampu mengendalikan jatuhnya tiang listrik dan membuat Tamus mengetahui keberadaan mereka.",
      });

      await db.insert('book_contents',{
        'title':'Naruto',
        'content':
        "BAB 1 \n\n"
                          "Raib, gadis istimewa keturunan Klan Bulan, memiliki kemampuan menghilang dan mewarisi Buku Kehidupan yang membuka portal ke dunia lain. Seli, sang penjinak api dari Klan Matahari, dikenal tekadnya yang kuat dan pantang menyerah."
                          "Sementara Ali, pemuda pemberani dari Klan Bumi, memiliki kemampuan unik berkomunikasi dengan hewan. Mereka saling menyadari memiliki kekuatan super ketika terjadi insiden tower listrik di sekolah jatuh menimpa mereka. "
                          "Alih-alih celaka, ketiganya mampu mengendalikan jatuhnya tiang listrik dan membuat Tamus mengetahui keberadaan mereka.",
      });

      await db.insert('book_contents',{
        'title':'Bendera Setengah Tiang',
        'content':
        "BAB 1 \n\n"
                          "Raib, gadis istimewa keturunan Klan Bulan, memiliki kemampuan menghilang dan mewarisi Buku Kehidupan yang membuka portal ke dunia lain. Seli, sang penjinak api dari Klan Matahari, dikenal tekadnya yang kuat dan pantang menyerah."
                          "Sementara Ali, pemuda pemberani dari Klan Bumi, memiliki kemampuan unik berkomunikasi dengan hewan. Mereka saling menyadari memiliki kekuatan super ketika terjadi insiden tower listrik di sekolah jatuh menimpa mereka. "
                          "Alih-alih celaka, ketiganya mampu mengendalikan jatuhnya tiang listrik dan membuat Tamus mengetahui keberadaan mereka.",
      });


        // =====================
        // DATA PROMOSI
        // =====================
        await db.execute('''
CREATE TABLE promosi(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  judul TEXT,
  isi TEXT,
  gambar TEXT,
  tanggal TEXT
)
''');
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


await db.execute('''
CREATE TABLE forum_komentar(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  forum_id INTEGER,
  pesan TEXT
)
''');
        // =====================
        // DATA KELOLA ULASAN
        // =====================
        await db.execute('''
CREATE TABLE ulasan(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  judul_buku TEXT,
  rating REAL,
  komentar TEXT
)
''');
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

  static Future<UserModel?> getUser(
  int id,
) async {

  final data =
      await getUserById(id);

  return UserModel.fromMap(data);
}

static Future<List<UserModel>>
getLeaderboard() async {

  final db =
      await getDatabase();

  final result = await db.query(
    'users',
    orderBy: 'points DESC',
  );

  return result
      .map(
        (e) => UserModel.fromMap(e),
      )
      .toList();
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

  // =====================
// PROMOSI
// =====================

  static Future<int> tambahPromosi(
      String judul,
      String isi,
      String gambar,
      String tanggal,
      ) async {

    final db = await getDatabase();

    return await db.insert(
      'promosi',
      {
        'judul': judul,
        'isi': isi,
        'gambar': gambar,
        'tanggal': tanggal,
      },
    );
  }

  static Future<List<Map<String, dynamic>>>
  getPromosi() async {

    final db = await getDatabase();

    return await db.query(
      'promosi',
      orderBy: 'id DESC',
    );
  }

  static Future<int> updatePromosi(
      int id,
      String judul,
      String isi,
      String gambar,
      String tanggal,
      ) async {

    final db = await getDatabase();

    return await db.update(
      'promosi',
      {
        'judul': judul,
        'isi': isi,
        'gambar': gambar,
        'tanggal': tanggal,
      },
      where: 'id=?',
      whereArgs: [id],
    );
  }

  static Future<int> deletePromosi(
      int id,
      ) async {

    final db = await getDatabase();

    return await db.delete(
      'promosi',
      where: 'id=?',
      whereArgs: [id],
    );
  }
  // =====================
// ULASAN
// =====================

  static Future<List<Map<String, dynamic>>>
  getUlasan() async {

    final db = await getDatabase();

    return await db.query(
      'ulasan',
      orderBy: 'id DESC',
    );
  }

  static Future<int> deleteUlasan(
      int id,
      ) async {

    final db = await getDatabase();

    return await db.delete(
      'ulasan',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  static Future<int> updateUlasan(
      int id,
      double rating,
      String komentar,
      ) async {

    final db = await getDatabase();

    return await db.update(
      'ulasan',
      {
        'rating': rating,
        'komentar': komentar,
      },
      where: 'id=?',
      whereArgs: [id],
    );
  }
  // =====================
// BOOKS
// =====================

static Future<List<Map<String, dynamic>>> getBooks() async {

  final db = await getDatabase();

  return await db.query(
    'books',
  );
}

static Future<String> getBookContent(
    String title) async {

  final db = await getDatabase();

  final result = await db.query(
    'book_contents',
    where: 'title=?',
    whereArgs: [title],
  );

  if (result.isNotEmpty) {
    return result.first['content']
        .toString();
  }

  return "Isi buku belum tersedia";
}

// =====================
// FAVORITE
// =====================

static Future<int> tambahFavorite(
    FavoriteBook book,
) async {

  final db = await getDatabase();

  return await db.insert(
    'favorite',
    book.toMap(),
  );
}

static Future<List<FavoriteBook>>
ambilSemuaFavorite() async {

  final db = await getDatabase();

  final result =
      await db.query('favorite');

  return result
      .map(
        (e) => FavoriteBook.fromMap(e),
      )
      .toList();
}

static Future<int> hapusFavorite(
    int id,
) async {

  final db = await getDatabase();

  return await db.delete(
    'favorite',
    where: 'id=?',
    whereArgs: [id],
  );
}

static Future<bool> cekFavorite(
    String title,
) async {

  final db = await getDatabase();

  final result = await db.query(
    'favorite',
    where: 'title=?',
    whereArgs: [title],
  );

  return result.isNotEmpty;
}

static Future<bool> cekPremium(
  int userId,
  String title,
) async {

  final db = await getDatabase();

  final result = await db.query(
    'premium_books',
    where: 'user_id = ? AND book_title = ?',
    whereArgs: [userId, title],
  );

  print(result);

  return result.isNotEmpty;
}

static Future<bool> tukarPremium(
  int userId,
  String title,
  int harga,
) async {

  final db = await getDatabase();

  final user = await db.query(
    'users',
    where: 'id=?',
    whereArgs: [userId],
  );

  if (user.isEmpty) return false;

  int point = user.first['points'] as int;

  if (point < harga) {
    return false;
  }

  await db.update(
    'users',
    {
      'points': point - harga,
    },
    where: 'id=?',
    whereArgs: [userId],
  );

  await db.insert(
    'premium_books',
    {
      'user_id': userId,
      'book_title': title,
    },
    
  );

  return true;
}

// =====================
// RESUME
// =====================

static Future<int> tambahResume(
  String judulBuku,
  String isiResume,
) async {

  final db = await getDatabase();

  return await db.insert(
    'resume_buku',
    {
      'judul_buku': judulBuku,
      'isi_resume': isiResume,
      'tanggal': DateTime.now().toString(),
    },
  );
}

static Future<List<Map<String, dynamic>>> ambilResume() async {

  final db = await getDatabase();

  return await db.query(
    'resume_buku',
    orderBy: 'id DESC',
  );
}

static Future<int> deleteResume(
  int id,
) async {

  final db = await getDatabase();

  return await db.delete(
    'resume_buku',
    where: 'id=?',
    whereArgs: [id],
  );
}

static Future<int> tambahRiwayatBaca(
  String judul,
) async {

  final db = await getDatabase();

  return await db.insert(
    'riwayat_baca',
    {
      'judul': judul,
      'image': '',
      'tanggal': DateTime.now().toString(),
    },
  );
}

static Future<List<Map<String,dynamic>>> ambilRiwayatBaca() async {

  final db = await getDatabase();

  return await db.query(
    'riwayat_baca',
    orderBy: 'id DESC',
  );
}

static Future<int> hapusRiwayatBaca(
  int id,
) async {

  final db = await getDatabase();

  return await db.delete(
    'riwayat_baca',
    where: 'id=?',
    whereArgs: [id],
  );
}

static Future<int> updateRiwayatBaca(
  int id,
  String judul,
  String image,
  String tanggal,
) async {

  final db = await getDatabase();

  return await db.update(
    'riwayat_baca',
    {
      'judul': judul,
      'image': image,
      'tanggal': tanggal,
    },
    where: 'id=?',
    whereArgs: [id],
  );
}

static Future<int> tambahBukuUser(
  String judul,
  String genre,
  String isi,
  String gambar,
) async {

  final db = await getDatabase();

  return await db.insert(
    'buku_user',
    {
      'judul': judul,
      'genre': genre,
      'isi': isi,
      'gambar': gambar,
    },
  );
}

static Future<List<Map<String, dynamic>>> ambilBukuUser() async {

  final db = await getDatabase();

  return await db.query(
    'buku_user',
    orderBy: 'id DESC',
  );
}

static Future<List<Map<String, dynamic>>> ambilBukuByGenre(
  String genre,
) async {

  final db = await getDatabase();

  return await db.query(
    'buku_user',
    where: 'genre=?',
    whereArgs: [genre],
  );
}

static Future<int> hapusBukuUser(
  int id,
) async {

  final db = await getDatabase();

  return await db.delete(
    'buku_user',
    where: 'id=?',
    whereArgs: [id],
  );
}

static Future<int> updateBukuUser(
  int id,
  String judul,
  String genre,
  String isi,
  String gambar,
) async {

  final db = await getDatabase();

  return await db.update(
    'buku_user',
    {
      'judul': judul,
      'genre': genre,
      'isi': isi,
      'gambar': gambar,
    },
    where: 'id=?',
    whereArgs: [id],
  );
}
  }


