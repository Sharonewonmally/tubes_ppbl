import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'database_helper.dart';
import 'dashboard_page.dart';
import 'full_bacaan_page.dart';

class BukuPremiumPage extends StatefulWidget {
  final int userId;
  const BukuPremiumPage({super.key, required this.userId});

  @override
  State<BukuPremiumPage> createState() => _BukuPremiumPageState();
}

class _BukuPremiumPageState extends State<BukuPremiumPage> {
 final db = DatabaseHelper();

  List<Map<String, dynamic>> books = [];
  int points = 0;

  bool showConfetti = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
  final data = await DatabaseHelper.getBooks();

  final user =
      await DatabaseHelper.getUserById(widget.userId);

  setState(() {
    books = data;
    points = user['points'] ?? 0;
  });
}

  void playConfetti() {
    setState(() => showConfetti = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => showConfetti = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardPage()),
            );
          },
        ),
        title: const Text("Buku Premium",
            style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xffFAEEDA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("⭐ $points Poin",
                      style: const TextStyle(color: Color(0xff633806))),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: books.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: .48,
                    ),
                    itemBuilder: (context, index) {
                      return PremiumBookCard(
                        book: books[index],
                        userId: widget.userId,
                        onSuccess: playConfetti,
                        onRead: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullBacaanPage(
                                title: books[index]['title'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          if (showConfetti)
            Center(
              child: Lottie.asset(
                'assets/lottie/confetti.json',
                repeat: false,
              ),
            ),
        ],
      ),
    );
  }
}

class PremiumBookCard extends StatefulWidget {
  final Map<String, dynamic> book;
  final int userId;
  final VoidCallback onRead;
  final VoidCallback onSuccess;

  const PremiumBookCard({
    super.key,
    required this.book,
    required this.userId,
    required this.onRead,
    required this.onSuccess,
  });

  @override
  State<PremiumBookCard> createState() => _PremiumBookCardState();
}

class _PremiumBookCardState extends State<PremiumBookCard> {
  final db = DatabaseHelper();
  bool owned = false;

  int get harga => widget.book['premium_point'] ?? 0;

  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    final result = await DatabaseHelper.cekPremium(
      widget.userId,
      widget.book['title'],
    );
    setState(() => owned = result);
  }

  Future<void> tukar() async {
    final result = await DatabaseHelper.tukarPremium(
      widget.userId,
      widget.book['title'],
      harga,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result
            ? "Berhasil menukar buku premium"
            : "Poin tidak cukup"),
      ),
    );

    if (result) {
      setState(() => owned = true);
      widget.onSuccess(); // 👈 trigger confetti
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffe2e8f0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              widget.book['imagePath'],
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.book['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(widget.book['author'],
                    style:
                        const TextStyle(color: Colors.grey, fontSize: 11)),
                const SizedBox(height: 8),
                Text("⭐ $harga Poin",
                    style: const TextStyle(color: Color(0xff854F0B))),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: owned ? widget.onRead : tukar,
                  child: CustomPremiumButton(
                    text: owned ? "Baca Buku" : "Tukarkan Poin",
                    owned: owned,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPremiumButton extends StatelessWidget {
  final String text;
  final bool owned;

  const CustomPremiumButton({
    super.key,
    required this.text,
    required this.owned,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PremiumButtonPainter(owned),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: owned ? const Color(0xff27500A) : Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class PremiumButtonPainter extends CustomPainter {
  final bool owned;
  PremiumButtonPainter(this.owned);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = owned ? const Color(0xffEAF3DE) : const Color(0xff185FA5);

    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}