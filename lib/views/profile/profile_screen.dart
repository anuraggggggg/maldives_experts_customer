import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _bookingUpdates = true;
  bool _offers = true;

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: Scaffold(
      backgroundColor: _ProfileColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: _Header()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 115),
              sliver: SliverList.list(
                children: [
                  const _ProfileCard(),
                  const SizedBox(height: 14),
                  const _TravelStats(),
                  const SizedBox(height: 22),
                  const _SectionTitle('Personal Information'),
                  const SizedBox(height: 9),
                  const _SettingsCard(
                    children: [
                      _SettingsTile(
                        icon: Icons.person_outline_rounded,
                        title: 'Personal Details',
                        subtitle: 'Name, email and phone number',
                      ),
                      _SettingsTile(
                        icon: Icons.location_on_outlined,
                        title: 'Saved Addresses',
                        subtitle: 'Manage your billing addresses',
                      ),
                      _SettingsTile(
                        icon: Icons.badge_outlined,
                        title: 'Traveller Details',
                        subtitle: 'Passport and guest information',
                        showDivider: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const _SectionTitle('Preferences'),
                  const SizedBox(height: 9),
                  _SettingsCard(
                    children: [
                      const _SettingsTile(
                        icon: Icons.language_rounded,
                        title: 'Language',
                        trailingText: 'English',
                      ),
                      const _SettingsTile(
                        icon: Icons.payments_outlined,
                        title: 'Currency',
                        trailingText: 'USD',
                      ),
                      _SwitchTile(
                        icon: Icons.notifications_none_rounded,
                        title: 'Booking Updates',
                        value: _bookingUpdates,
                        onChanged: (value) =>
                            setState(() => _bookingUpdates = value),
                      ),
                      _SwitchTile(
                        icon: Icons.local_offer_outlined,
                        title: 'Offers & Promotions',
                        value: _offers,
                        showDivider: false,
                        onChanged: (value) => setState(() => _offers = value),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const _SectionTitle('Support & Information'),
                  const SizedBox(height: 9),
                  const _SettingsCard(
                    children: [
                      _SettingsTile(
                        icon: Icons.support_agent_rounded,
                        title: 'Help & Support',
                      ),
                      _SettingsTile(
                        icon: Icons.chat_bubble_outline_rounded,
                        title: 'Contact Maldives Expert',
                      ),
                      _SettingsTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy & Security',
                      ),
                      _SettingsTile(
                        icon: Icons.info_outline_rounded,
                        title: 'About Maldives Experts',
                        trailingText: 'v1.0.0',
                        showDivider: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _SignOutButton(onPressed: () => _confirmSignOut(context)),
                  const SizedBox(height: 16),
                  const Text(
                    'Made with love for unforgettable Maldives holidays',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _ProfileColors.muted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Future<void> _confirmSignOut(BuildContext context) async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text(
          'You will need to sign in again to access your trips and wishlist.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (shouldSignOut == true && context.mounted) {
      context.read<AuthProvider>().logout();
    }
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(18, 22, 10, 18),
    child: Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Profile', style: _ProfileText.pageTitle),
              SizedBox(height: 7),
              Text(
                'Manage your account and preferences',
                style: _ProfileText.subtitle,
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded, size: 29),
              color: _ProfileColors.navy,
            ),
            Positioned(
              right: 1,
              top: 0,
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5262B),
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined),
          color: _ProfileColors.navy,
        ),
      ],
    ),
  );
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF073B8D), Color(0xFF0879CC)],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x260754E8),
          blurRadius: 20,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 76,
              height: 76,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .18),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
              ),
              child: const Text(
                'JD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: 0,
              child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: _ProfileColors.blue,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 15),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'user@gmail.com',
                style: TextStyle(color: Color(0xFFDCEBFF), fontSize: 12.5),
              ),
              SizedBox(height: 9),
              _MemberBadge(),
            ],
          ),
        ),
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.edit_outlined, color: Colors.white, size: 21),
        ),
      ],
    ),
  );
}

class _MemberBadge extends StatelessWidget {
  const _MemberBadge();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .16),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.workspace_premium_outlined,
          color: Color(0xFFFFD66B),
          size: 15,
        ),
        SizedBox(width: 4),
        Text(
          'Gold Member',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _TravelStats extends StatelessWidget {
  const _TravelStats();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: _ProfileDecor.card,
    child: const Row(
      children: [
        _StatItem(
          value: '6',
          label: 'Trips',
          icon: Icons.flight_takeoff_rounded,
        ),
        _VerticalDivider(),
        _StatItem(
          value: '24',
          label: 'Wishlist',
          icon: Icons.favorite_border_rounded,
        ),
        _VerticalDivider(),
        _StatItem(value: '1,250', label: 'Points', icon: Icons.stars_outlined),
      ],
    ),
  );
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });
  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Icon(icon, color: _ProfileColors.blue, size: 21),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: _ProfileColors.navy,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(label, style: _ProfileText.caption),
      ],
    ),
  );
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 44,
    child: VerticalDivider(color: _ProfileColors.border),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) =>
      Text(title, style: _ProfileText.sectionTitle);
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
    decoration: _ProfileDecor.card,
    child: Column(children: children),
  );
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingText,
    this.showDivider = true,
  });
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailingText;
  final bool showDivider;

  @override
  Widget build(BuildContext context) => _TileShell(
    icon: icon,
    showDivider: showDivider,
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: _ProfileText.tileTitle),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(subtitle!, style: _ProfileText.caption),
                  ],
                ],
              ),
            ),
            if (trailingText != null)
              Text(trailingText!, style: _ProfileText.trailing),
            const SizedBox(width: 5),
            const Icon(
              Icons.chevron_right_rounded,
              color: _ProfileColors.muted,
              size: 21,
            ),
          ],
        ),
      ),
    ),
  );
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  });
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) => _TileShell(
    icon: icon,
    showDivider: showDivider,
    child: Row(
      children: [
        Expanded(child: Text(title, style: _ProfileText.tileTitle)),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: _ProfileColors.blue,
        ),
      ],
    ),
  );
}

class _TileShell extends StatelessWidget {
  const _TileShell({
    required this.icon,
    required this.showDivider,
    required this.child,
  });
  final IconData icon;
  final bool showDivider;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 13),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: _ProfileColors.iconSurface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _ProfileColors.blue, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(right: 11),
            decoration: BoxDecoration(
              border: showDivider
                  ? const Border(
                      bottom: BorderSide(color: _ProfileColors.border),
                    )
                  : null,
            ),
            child: child,
          ),
        ),
      ],
    ),
  );
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: const Icon(Icons.logout_rounded, size: 20),
    label: const Text('Sign Out'),
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.error,
      minimumSize: const Size.fromHeight(52),
      side: const BorderSide(color: Color(0xFFF2C9C9)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    ),
  );
}

abstract final class _ProfileColors {
  static const navy = Color(0xFF071445);
  static const blue = AppColors.dashboardBlue;
  static const muted = Color(0xFF667085);
  static const border = Color(0xFFE6E9F0);
  static const background = Color(0xFFFCFDFE);
  static const iconSurface = Color(0xFFEDF4FF);
}

abstract final class _ProfileText {
  static const pageTitle = TextStyle(
    color: _ProfileColors.navy,
    fontSize: 30,
    height: 1.1,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
  );
  static const subtitle = TextStyle(color: _ProfileColors.muted, fontSize: 14);
  static const sectionTitle = TextStyle(
    color: _ProfileColors.navy,
    fontSize: 15.5,
    fontWeight: FontWeight.w800,
  );
  static const tileTitle = TextStyle(
    color: _ProfileColors.navy,
    fontSize: 13.5,
    fontWeight: FontWeight.w700,
  );
  static const caption = TextStyle(color: _ProfileColors.muted, fontSize: 11);
  static const trailing = TextStyle(
    color: _ProfileColors.muted,
    fontSize: 11.5,
    fontWeight: FontWeight.w600,
  );
}

abstract final class _ProfileDecor {
  static final card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: _ProfileColors.border),
    boxShadow: const [
      BoxShadow(color: Color(0x0A071445), blurRadius: 12, offset: Offset(0, 4)),
    ],
  );
}
