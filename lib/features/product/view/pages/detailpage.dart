import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/productentity/product.dart';
import '../widget/gradientbackground.dart';

class DetailPage extends StatefulWidget {
  final Watch product;
  final String image;
  final Color color;

  const DetailPage({
    super.key,
    required this.product,
    required this.image,
    required this.color,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with TickerProviderStateMixin {

  // ── entry animation (scale in on open) ──────────────────────────────────
  late AnimationController _entryCtrl;
  late Animation<double> _entryScale;

  // ── drag rotation ────────────────────────────────────────────────────────
  double _rotation = 0;

  // ── reveal: triggered by "Show Details" ─────────────────────────────────
  bool _revealed = false;

  late AnimationController _imageCtrl;   // image moves to top + shrinks
  late AnimationController _titleCtrl;   // title slides from left
  late AnimationController _descCtrl;    // description slides from left
  late AnimationController _ratingCtrl;  // rating slides from left
  late AnimationController _priceCtrl;   // price slides from right
  late AnimationController _cardCtrl;    // info card from right
  late AnimationController _btnCtrl;     // order button scales up

  // image position/size
  late Animation<Alignment> _imageAlign;
  late Animation<double>    _imageSize;

  // slide animations
  late Animation<Offset> _titleSlide;
  late Animation<Offset> _descSlide;
  late Animation<Offset> _ratingSlide;
  late Animation<Offset> _priceSlide;
  late Animation<Offset> _cardSlide;
  late Animation<double>  _orderScale;

  // fade animations
  late Animation<double> _titleFade;
  late Animation<double> _descFade;
  late Animation<double> _ratingFade;
  late Animation<double> _priceFade;
  late Animation<double> _cardFade;
  late Animation<double> _orderFade;

  AnimationController _makeCtrl(int ms) => AnimationController(
    vsync: this,
    duration: Duration(milliseconds: ms),
  );

  @override
  void initState() {
    super.initState();

    // ── entry ────────────────────────────────────────────────────────────
    _entryCtrl = _makeCtrl(700);
    _entryScale = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutBack);
    _entryCtrl.forward();

    // ── image ────────────────────────────────────────────────────────────
    _imageCtrl = _makeCtrl(600);
    _imageAlign = AlignmentTween(
      begin: Alignment.center,
      end: const Alignment(0, -0.72), // sits a touch lower so gap looks natural
    ).animate(CurvedAnimation(parent: _imageCtrl, curve: Curves.easeInOut));
    _imageSize = Tween<double>(begin: 0.42, end: 0.26).animate( // slightly bigger
      CurvedAnimation(parent: _imageCtrl, curve: Curves.easeInOut),
    );

    // ── title ────────────────────────────────────────────────────────────
    _titleCtrl = _makeCtrl(500);
    _titleSlide = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _titleCtrl, curve: Curves.easeOut));
    _titleFade = CurvedAnimation(parent: _titleCtrl, curve: Curves.easeIn);

    // ── description ──────────────────────────────────────────────────────
    _descCtrl = _makeCtrl(500);
    _descSlide = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _descCtrl, curve: Curves.easeOut));
    _descFade = CurvedAnimation(parent: _descCtrl, curve: Curves.easeIn);

    // ── rating ───────────────────────────────────────────────────────────
    _ratingCtrl = _makeCtrl(500);
    _ratingSlide = Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ratingCtrl, curve: Curves.easeOut));
    _ratingFade = CurvedAnimation(parent: _ratingCtrl, curve: Curves.easeIn);

    // ── price ────────────────────────────────────────────────────────────
    _priceCtrl = _makeCtrl(500);
    _priceSlide = Tween<Offset>(begin: const Offset(1.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _priceCtrl, curve: Curves.easeOut));
    _priceFade = CurvedAnimation(parent: _priceCtrl, curve: Curves.easeIn);

    // ── info card ────────────────────────────────────────────────────────
    _cardCtrl = _makeCtrl(550);
    _cardSlide = Tween<Offset>(begin: const Offset(1.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOut));
    _cardFade = CurvedAnimation(parent: _cardCtrl, curve: Curves.easeIn);

    // ── order button ─────────────────────────────────────────────────────
    _btnCtrl = _makeCtrl(900); // slower, more satisfying scale
    _orderScale = CurvedAnimation(parent: _btnCtrl, curve: Curves.easeOutBack);
    _orderFade  = CurvedAnimation(parent: _btnCtrl, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _imageCtrl.dispose();
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _ratingCtrl.dispose();
    _priceCtrl.dispose();
    _cardCtrl.dispose();
    _btnCtrl.dispose();
    super.dispose();
  }

  Future<void> _startReveal() async {
    if (_revealed) return;
    setState(() => _revealed = true);

    await _imageCtrl.forward();            // image moves up
    await Future.delayed(const Duration(milliseconds: 80));

    _titleCtrl.forward();                  // title from left
    await Future.delayed(const Duration(milliseconds: 350));

    _descCtrl.forward();                   // description from left
    await Future.delayed(const Duration(milliseconds: 400));

    // rating (left) + price (right) fire together → same row
    _ratingCtrl.forward();
    _priceCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 450));

    _cardCtrl.forward();                   // card from right
    await Future.delayed(const Duration(milliseconds: 350));

    _btnCtrl.forward();                    // button scales up (slow)
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  Widget _floatingImage(
      String url,
      double top,
      double? left,
      double? right,
      double opacity,
      double rotation,
      ) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: rotation,
          child: Image.network(url, height: 60),
        ),
      ),
    );
  }

  Widget _starRow(double rating) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(full, (_) => const Icon(Icons.star, color: Colors.amber, size: 18)),
        if (half) const Icon(Icons.star_half, color: Colors.amber, size: 18),
        const SizedBox(width: 6),
        Text(
          '$rating',
          style: GoogleFonts.aldrich(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final top = MediaQuery.of(context).padding.top;
    final product = widget.product;

    return Stack(
      children: [

        // BACKGROUND
        Positioned.fill(
          child: GradientBackground(color: widget.color),
        ),

        // FLOATING IMAGES (hidden after reveal)
        if (!_revealed) ...[
          _floatingImage(product.images[1], 80,  45,  null, .08, 2.5),
          _floatingImage(product.images[2], 200, null, 45,  .05, 0),
          _floatingImage(product.images[3], 600, 25,  null, .08, 6.5),
          _floatingImage(product.images[4], 450, null, 35,  .035, 0.3),
          _floatingImage(product.images[4], 300, 40,  null, .05, 0.45),
          _floatingImage(product.images[4], 700, null, 45,  .1, 7),
        ],

        // ── PRE-REVEAL: title + draggable centred image + show-details btn ──
        if (!_revealed) ...[

          Positioned(
            top: 100, left: 50, right: 50,
            child: Text(
              product.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.aldrich(
                fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white,
              ),
            ),
          ),

          Center(
            child: GestureDetector(
              onPanUpdate: (d) => setState(() => _rotation += d.delta.dx * .01),
              child: ScaleTransition(
                scale: _entryScale,
                child: Transform.rotate(
                  angle: _rotation,
                  child: Image.network(widget.image, height: size.height * .42),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 100, left: 100, right: 100,
            child: GestureDetector(
              onTap: _startReveal,
              child: _showDetailsButton(widget.color),
            ),
          ),
        ],

        // ── POST-REVEAL: animated image + content ────────────────────────
        if (_revealed) ...[

          //BackButton and Cart Button
          Positioned(
            top: top,
              left: 15,
              right: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
              [
                //BackButton-------------------------------------------------
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _revealed=false;
                    });
                  },
                    child: Image.asset('assets/images/back.png',height: 30,)
                ),
                //CartIcon------------------------------------------------------
                GestureDetector(
                    child: Image.asset('assets/images/btn_2.png',height: 32,)
                ),

              ]
              )),

          // IMAGE – slides to top and shrinks
          AnimatedBuilder(
            animation: _imageCtrl,
            builder: (_, __) {
              return Align(
                alignment: _imageAlign.value,
                child: Transform.rotate(
                  angle: _rotation,
                  child: Image.network(
                    widget.image,
                    height: size.height * _imageSize.value,
                  ),
                ),
              );
            },
          ),

          // CONTENT COLUMN — positioned below image with ~80px gap
          AnimatedBuilder(
            animation: _imageCtrl,
            builder: (_, __) {
              // image bottom = top of screen + alignment offset + half image height
              // We derive it from the animated size so the gap is always 80px
              final imgHeight = size.height * _imageSize.value;
              // Alignment(-0.72) maps to: center + (-0.72 * (screenH - imgH) / 2)
              final imgCenterY = size.height / 2 +
                  (_imageAlign.value.y * (size.height - imgHeight) / 2);
              final imgBottom = imgCenterY + imgHeight / 2;
              final contentTop = imgBottom + 65; // ← exactly 80px gap

              return Positioned(
                top: contentTop,
                left: 28,
                right: 28,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    // TITLE – from left, text centred
                    SlideTransition(
                      position: _titleSlide,
                      child: FadeTransition(
                        opacity: _titleFade,
                        child: Text(
                          product.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aldrich(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // DESCRIPTION – from left
                    SlideTransition(
                      position: _descSlide,
                      child: FadeTransition(
                        opacity: _descFade,
                        child: Text(
                          product.description ?? 'A premium timepiece engineered for precision and style. Crafted with the finest materials for the modern wearer.',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: GoogleFonts.aldrich(
                            fontSize: 13,
                            color: Colors.grey.shade400,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // RATING (left) + PRICE (right) — same row, same time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SlideTransition(
                          position: _ratingSlide,
                          child: FadeTransition(
                            opacity: _ratingFade,
                            child: _starRow( 4.5),
                          ),
                        ),
                        SlideTransition(
                          position: _priceSlide,
                          child: FadeTransition(
                            opacity: _priceFade,
                            child: Text(
                              '\$${product.price}',
                              style: GoogleFonts.aldrich(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // INFO CARD – from right
                    SlideTransition(
                      position: _cardSlide,
                      child: FadeTransition(
                        opacity: _cardFade,
                        child: _infoCard(widget.color, product),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ORDER NOW BUTTON – scales up slowly
                    Center(
                      child: ScaleTransition(
                        scale: _orderScale,
                        child: FadeTransition(
                          opacity: _orderFade,
                          child: _orderNowButton(widget.color),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}

// ── Widgets ──────────────────────────────────────────────────────────────────

Widget _showDetailsButton(Color color) {
  return Container(
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white70, width: 1.5),
      gradient: LinearGradient(
        colors: [color.withOpacity(.25), color.withOpacity(.9)],
      ),
    ),
    child: const Center(
      child: Text(
        "Show Details",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),
  );
}

Widget _infoCard(Color color, Watch product) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white30, width: 1),
      gradient: LinearGradient(
        colors: [Colors.white.withOpacity(.12), color.withOpacity(.25)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Card title ──────────────────────────────────────────────────
        Text(
          'Specifications',
          style: GoogleFonts.aldrich(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Divider(color: Colors.white30, thickness: 1),
        const SizedBox(height: 10),

        // ── Tiles ────────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _infoTile(Icons.battery_full_rounded, "Battery",  "48 hrs"),
            _vDivider(),
            _infoTile(Icons.bolt_rounded,          "Charging", "Fast"),
            _vDivider(),
            _infoTile(Icons.water_drop_outlined,   "Water",    "5 ATM"),
          ],
        ),
      ],
    ),
  );
}

Widget _infoTile(IconData icon, String label, String value) {
  return Column(
    children: [
      Icon(icon, color: Colors.white, size: 26),
      const SizedBox(height: 6),
      Text(
        value,
        style: GoogleFonts.aldrich(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white70,   // was white54 — now clearly readable
          fontSize: 11,
        ),
      ),
    ],
  );
}

Widget _vDivider() => Container(
  width: 1, height: 48,
  color: Colors.white24,
);

Widget _orderNowButton(Color color) {
  return Container(
    width: 220,
    height: 58,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: LinearGradient(
        colors: [color.withOpacity(.7), color],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(.5),
          blurRadius: 20,
          offset: const Offset(0, 8),
        )
      ],
    ),
    child: Center(
      child: Text(
        "Order Now",
        style: GoogleFonts.aldrich(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );
}