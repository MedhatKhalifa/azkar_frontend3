import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sebha_controller.dart';
import 'sebha_homePage.dart';

class TasbihListPage extends StatefulWidget {
  final String? subCategory; // Subcategory name (optional)
  final bool isSearchResult; // True if this is a search result

  const TasbihListPage({
    super.key,
    this.subCategory,
    this.isSearchResult = false,
  });

  @override
  _TasbihListPageState createState() => _TasbihListPageState();
}

class _TasbihListPageState extends State<TasbihListPage> {
  final SebhaController sebhaController = Get.put(SebhaController());
  double _textSize = 18.0; // Default text size for Azkar content

  void _onTileClick(int id) {
    final selectedZekr =
        sebhaController.azkar.firstWhere((zekr) => zekr['id'] == id);
    sebhaController.selectZekr(selectedZekr);
    Get.to(SebhaHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 43, 22),
        title: Text(
          'select_tasbih'.tr,
          style: const TextStyle(
            fontFamily: 'sebhafont',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFDAA520),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            tooltip: 'Increase Text Size',
            onPressed: () {
              setState(() {
                _textSize = _textSize < 30.0 ? _textSize + 2.0 : _textSize;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            tooltip: 'Decrease Text Size',
            onPressed: () {
              setState(() {
                _textSize = _textSize > 12.0 ? _textSize - 2.0 : _textSize;
              });
            },
          ),
        ],
      ),
      body: Obx(() {
        if (sebhaController.azkar.isEmpty) {
          return Center(
            child: Text(
              'No Azkar Available',
              style: const TextStyle(
                fontFamily: 'myarabic',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFDAA520),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: sebhaController.azkar.length,
          itemBuilder: (context, index) {
            final zekr = sebhaController.azkar[index];
            return GestureDetector(
              onTap: () => _onTileClick(zekr['id']),
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                color: const Color.fromARGB(255, 22, 43, 22),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  title: Text(
                    zekr['name'] ?? '',
                    style: TextStyle(
                      fontFamily: 'myarabic',
                      fontSize: _textSize,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 241, 241, 238),
                    ),
                  ),
                  subtitle: zekr['fadl'] != null && zekr['fadl'] != 'nan'
                      ? Text(
                          'Reward: ${zekr['fadl']}',
                          style: TextStyle(
                            fontFamily: 'myarabic',
                            fontSize: 16,
                            color: Colors.grey[300],
                          ),
                        )
                      : null,
                  trailing: Text(
                    'التراكمي ${zekr['accumulativeCount']}',
                    style: TextStyle(
                      fontFamily: 'myarabic',
                      fontSize: 12,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
