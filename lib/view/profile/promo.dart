import 'package:flutter/material.dart';
// import 'package:tubes_ui/view/profile/profile.dart';

class PromoPage extends StatefulWidget {
  @override
  _PromoPageState createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    'Promo',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40.0),
                ],
              ),
              const SizedBox(height: 20.0),
              buildPromoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPromoCard() {
    return const Card(
      elevation: 2.0,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_offer,
              size: 30.0,
            ),
            VerticalDivider(
              width: 10,
              color: Colors.grey,
            ),
          ],
        ),
        title: Text(
          'Halo, CARRENT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HALOCARRENT25',
              style: TextStyle(
                color: Colors.purpleAccent,
              ),
            ),
            Text(
              'Expiry on 31 Dec 2023',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Selamat datang di CARRENT dan selamat menikmati perjalanan pertamamu dengan lebih hemat 25% hingga 200 RIBU!',
            ),
          ],
        ),
      ),
    );
  }
}
