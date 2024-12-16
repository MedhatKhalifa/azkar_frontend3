import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SebhaDatabaseHelper {
  static final SebhaDatabaseHelper _instance = SebhaDatabaseHelper._();
  static Database? _database;

  SebhaDatabaseHelper._();

  factory SebhaDatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sebha.db');

    return await openDatabase(
      path,
      version: 1, // Increment version for changes
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE zekr (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          fadl TEXT NOT NULL,
          accumulativeCount INTEGER NOT NULL
        )
      ''');
        await _insertPredefinedAzkar(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Add predefined Azkar if missing
          await _insertPredefinedAzkar(db);
        }
      },
    );
  }

  Future<void> _insertPredefinedAzkar(Database db) async {
    final predefinedAzkar = [
      {
        "name": "سُبْحَانَ اللَّهِ",
        "fadl": "يكتب له ألف حسنة أو يحط عنه ألف خطيئة.",
        "accumulativeCount": 0
      },
      {
        "name": "الْحَمْدُ لِلَّهِ",
        "fadl": "تملأ الميزان.",
        "accumulativeCount": 0
      },
      {
        "name": "اللَّهُ أَكْبَرُ",
        "fadl": "أحب الكلام إلى الله.",
        "accumulativeCount": 0
      },
      {
        "name": "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
        "fadl":
            "حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ.",
        "accumulativeCount": 0
      },
      {
        "name": "سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ",
        "fadl": "تَمْلَآَنِ مَا بَيْنَ السَّمَاوَاتِ وَالْأَرْضِ.",
        "accumulativeCount": 0
      },
      {
        "name": "سُبْحَانَ اللهِ العَظِيمِ وَبِحَمْدِهِ",
        "fadl": "غرست له نخلة في الجنة (أى عدد).",
        "accumulativeCount": 0
      },
      {
        "name": "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ",
        "fadl": "ثقيلتان في الميزان حبيبتان إلى الرحمن (أى عدد).",
        "accumulativeCount": 0
      },
      {
        "name":
            "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلُّ شَيْءِ قَدِيرِ.",
        "fadl":
            "كانت له عدل عشر رقاب، وكتبت له مئة حسنة، ومحيت عنه مئة سيئة، وكانت له حرزا من الشيطان.",
        "accumulativeCount": 0
      },
      {
        "name": "الْحَمْدُ للّهِ رَبِّ الْعَالَمِينَ",
        "fadl": "تملأ ميزان العبد بالحسنات.",
        "accumulativeCount": 0
      },
      {
        "name": "لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ",
        "fadl": "كنز من كنوز الجنة (أى عدد).",
        "accumulativeCount": 0
      },
      {
        "name": "اللَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد",
        "fadl": "من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة.",
        "accumulativeCount": 0
      },
      {
        "name": "أستغفر الله",
        "fadl": "لفعل الرسول صلى الله عليه وسلم.",
        "accumulativeCount": 0
      },
      {
        "name":
            "سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَرُ",
        "fadl":
            "أنهن أحب الكلام الى الله، ومكفرات للذنوب، وغرس الجنة، وجنة لقائلهن من النار، وأحب الى النبي عليه السلام مما طلعت عليه الشمس، والْبَاقِيَاتُ الْصَّالِحَات.",
        "accumulativeCount": 0
      },
      {
        "name": "لَا إِلَهَ إِلَّا اللَّهُ",
        "fadl": "أفضل الذكر لا إله إلاّ الله.",
        "accumulativeCount": 0
      },
      {
        "name": "اللَّهُ أَكْبَرُ",
        "fadl":
            "من قال الله أكبر كتبت له عشرون حسنة وحطت عنه عشرون سيئة. الله أكبر من كل شيء.",
        "accumulativeCount": 0
      },
      {
        "name":
            "سُبْحَانَ اللَّهِ ، وَالْحَمْدُ لِلَّهِ ، وَلا إِلَهَ إِلا اللَّهُ ، وَاللَّهُ أَكْبَرُ ، اللَّهُمَّ اغْفِرْ لِي ، اللَّهُمَّ ارْحَمْنِي ، اللَّهُمَّ ارْزُقْنِي.",
        "fadl": "خير الدنيا والآخرة.",
        "accumulativeCount": 0
      },
      {
        "name": "الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ.",
        "fadl":
            "قَالَ النَّبِيُّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ  رَأَيْتُ اثْنَيْ عَشَرَ مَلَكًا يَبْتَدِرُونَهَا، أَيُّهُمْ يَرْفَعُهَا.",
        "accumulativeCount": 0
      },
      {
        "name":
            "اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً.",
        "fadl":
            "قَالَ النَّبِيُّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ عَجِبْتُ لَهَا ، فُتِحَتْ لَهَا أَبْوَابُ السَّمَاءِ.",
        "accumulativeCount": 0
      },
      {
        "name":
            "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ.",
        "fadl":
            "في كل مره تحط عنه عشر خطايا ويرفع له عشر درجات ويصلي الله عليه عشرا وتعرض على الرسول صلى الله عليه وسلم (أى عدد).",
        "accumulativeCount": 0
      }
    ];
    for (var zekr in predefinedAzkar) {
      await db.insert('zekr', zekr);
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllAzkar() async {
    final db = await database;
    return await db.query('zekr');
  }

  Future<int> insertZekr(String name, String fadl) async {
    final db = await database;
    return await db.insert('zekr', {
      'name': name,
      'fadl': fadl,
      'accumulativeCount': 0,
    });
  }

  Future<int> updateAccumulativeCount(int id, int accumulativeCount) async {
    final db = await database;
    return await db.update(
      'zekr',
      {'accumulativeCount': accumulativeCount},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> fetchZekrById(int id) async {
    final db = await database;
    final result = await db.query(
      'zekr',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }
}
