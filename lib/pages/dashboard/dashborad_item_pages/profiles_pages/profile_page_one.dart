import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../widgets/share_button_option_bottomshade.dart';

class ProfilePageOne extends StatelessWidget {
  const ProfilePageOne({super.key});

  @override
  Widget build(BuildContext context) {

    final imageUrl = "https://gorurghash.com/wp-content/uploads/2022/02/Mushak-2.3-BIN-Certificate-On-25.OCT_.2021-768x1086.jpg";
    final logoImageUrl = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: CustomScrollView(
        slivers: [
          /// >>> ================ APPBAR WITH GRADIENT HEADER =================
          SliverAppBar(
            expandedHeight: 270,
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                children: [
                  /// >>> Gradient Background ==================================
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF42A5F5),], begin: Alignment.topLeft, end: Alignment.bottomRight,),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40),),
                    ),
                  ),

                  /// >>> Vendor Info ==========================================
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: CachedNetworkImageProvider(logoImageUrl),
                          ),
                          const SizedBox(height: 10),
                          const Text("ABC Super Shop", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 0.5,),),
                          const SizedBox(height: 4),
                          Text("Premium Grocery Vendor", style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 14,),),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(30),),
                            child: const Text("⭐ 4.8 / 5.0", style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /// <<< ================ APPBAR WITH GRADIENT HEADER =================


          /// >>>> ================= MAIN PROFILE BODY =========================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("Vendor Information"),
                  const SizedBox(height: 12),
                  _buildInfoCard(LucideIcons.user, "Vendor Name", "Prothes Barai"),
                  _buildInfoCard(LucideIcons.mail, "Email", "vendor@email.com"),
                  _buildInfoCard(LucideIcons.phone, "Phone", "+880 1765 123 456"),
                  _buildInfoCard(LucideIcons.mapPin, "Delivery Range", "Within 5 km"),
                  _buildInfoCard(LucideIcons.truck, "Delivery Type", "Free Delivery"),
                  _buildInfoCard(LucideIcons.creditCard, "Subscription Type", "Premium"),
                  _buildInfoCard(LucideIcons.fileBadge, "Trade License No.", "TL-2025-0098"),
                  const SizedBox(height: 25),
                  _sectionTitle("About Vendor"),
                  const SizedBox(height: 8),
                  _aboutCard("We are a trusted premium grocery shop providing fresh and quality products with same-day delivery service across your area.",),

                  const SizedBox(height: 25),
                  _sectionTitle("Trade License Photo"),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      httpHeaders: {"User-Agent": "Mozilla/5.0"},
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),

                  const SizedBox(height: 35),
                  _sectionTitle("Quick Actions"),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildActionButton(icon: LucideIcons.edit3, label: "Edit Profile", color: const Color(0xFF6C63FF), onTap: () {},),),
                      const SizedBox(width: 15),
                      Expanded(child: _buildActionButton(icon: LucideIcons.share2, label: "Share", color: Colors.black87, onTap: () {showShareOptions(context,'Asp','Notes','developerprothes16@gmail.com','01317818826');}, outlined: true,),),
                    ],
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          /// <<<< ================= MAIN PROFILE BODY =========================
        ],
      ),
    );
  }


  /// >>> ====================== Custom Widgets ================================

  // >>> Every Section title
  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black87,),);
  }



  // >>> Vendor Information Card
  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 3),)],),
      child: ListTile(
        leading: CircleAvatar(radius: 22, backgroundColor: const Color(0xFF6C63FF).withValues(alpha: 0.08), child: Icon(icon, color: const Color(0xFF6C63FF), size: 20),),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5,),),
        subtitle: Text(value, style: const TextStyle(fontSize: 13.5, color: Colors.black87,),),
      ),
    );
  }


  // >>> About Section
  Widget _aboutCard(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 6, offset: const Offset(0, 3),)],
      ),
      padding: const EdgeInsets.all(16),
      child: Text(text, style: const TextStyle(fontSize: 14.5, color: Colors.black87, height: 1.5),),
    );
  }



  // >>> Action Button Section
  Widget _buildActionButton({required IconData icon, required String label, required Color color, required VoidCallback onTap, bool outlined = false,}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: outlined ? Colors.transparent : color, border: outlined ? Border.all(color: Colors.black26) : null, borderRadius: BorderRadius.circular(30),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: outlined ? Colors.black87 : Colors.white),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: outlined ? Colors.black87 : Colors.white, fontWeight: FontWeight.bold, fontSize: 14,),),
          ],
        ),
      ),
    );
  }

}
