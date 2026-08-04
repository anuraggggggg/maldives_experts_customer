import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  int _selectedTab = 0;

  static const _tabs = [
    ('Upcoming', 2),
    ('Ongoing', 1),
    ('Completed', 3),
    ('Cancelled', 1),
  ];

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: Scaffold(
      backgroundColor: const Color(0xFFFCFDFE),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _Header()),
            SliverToBoxAdapter(
              child: _TripsTabs(
                selectedIndex: _selectedTab,
                onSelected: (index) => setState(() => _selectedTab = index),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
              sliver: SliverList.list(
                children: const [
                  _NextTripCard(),
                  SizedBox(height: 10),
                  _PageIndicator(),
                  SizedBox(height: 18),
                  _QuickActions(),
                  SizedBox(height: 22),
                  _SectionTitle(title: 'Upcoming Trips (2)'),
                  SizedBox(height: 10),
                  _TripCard(
                    image: 'assets/images/maldives3.png',
                    title: 'Sun Siyam Iru Veli',
                    location: 'Noonu Atoll, Maldives',
                    dates: '22 Jun – 28 Jun 2025',
                    guests: '2 Adults  •  2 Children',
                    bookingId: 'ME12025052201',
                    nights: '6 Nights',
                    amount: '₹ 2,45,000',
                    balance: '₹ 25,000',
                    balanceDue: true,
                  ),
                  SizedBox(height: 12),
                  _TripCard(
                    image: 'assets/images/maldives5.png',
                    title: 'Kuda Villingili Resort Maldives',
                    location: 'North Malé Atoll, Maldives',
                    dates: '05 Jul – 09 Jul 2025',
                    guests: '2 Adults',
                    bookingId: 'ME12025060101',
                    nights: '4 Nights',
                    amount: '₹ 1,20,000',
                    balance: '₹ 0',
                  ),
                  SizedBox(height: 24),
                  _SectionTitle(title: 'Ongoing Trip (1)'),
                  SizedBox(height: 10),
                  _OngoingTripCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Trips',
                style: TextStyle(
                  color: _TripColors.navy,
                  fontSize: 30,
                  height: 1.1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'All your bookings in one place',
                style: TextStyle(color: _TripColors.muted, fontSize: 16),
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
              color: _TripColors.navy,
              tooltip: 'Notifications',
            ),
            Positioned(
              right: 2,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _TripsTabs extends StatelessWidget {
  const _TripsTabs({required this.selectedIndex, required this.onSelected});

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => Container(
    height: 64,
    decoration: const BoxDecoration(
      color: Color(0xFFFCFDFE),
      border: Border.symmetric(
        horizontal: BorderSide(color: Color(0xFFE6E9EF)),
      ),
    ),
    child: Row(
      children: List.generate(_MyTripsScreenState._tabs.length, (index) {
        final tab = _MyTripsScreenState._tabs[index];
        final selected = selectedIndex == index;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => onSelected(index),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 9),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tab.$1,
                            maxLines: 1,
                            style: TextStyle(
                              color: selected
                                  ? _TripColors.blue
                                  : _TripColors.muted,
                              fontSize: 12,
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              letterSpacing: -0.15,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 19,
                            height: 19,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selected
                                  ? _TripColors.blue
                                  : const Color(0xFF8CB1F7),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${tab.$2}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (selected)
                    const Positioned(
                      bottom: 0,
                      left: 14,
                      right: 14,
                      child: SizedBox(
                        height: 3,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: _TripColors.blue,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    ),
  );
}

class _NextTripCard extends StatelessWidget {
  const _NextTripCard();

  @override
  Widget build(BuildContext context) => _Surface(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Text('Next Trip', style: _TripText.smallTitle),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '12 Days to go',
                            style: TextStyle(
                              color: _TripColors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.timer_outlined,
                            color: _TripColors.green,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/dashboard_hero.png',
                      width: 112,
                      height: 78,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 13),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Conrad Maldives Rangali Island',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: _TripText.cardTitle,
                        ),
                        SizedBox(height: 8),
                        _InfoLine(
                          icon: Icons.calendar_month_outlined,
                          text: '15 Jun – 20 Jun 2025 (5 Nights)',
                        ),
                        SizedBox(height: 6),
                        _InfoLine(
                          icon: Icons.group_outlined,
                          text: '2 Adults  •  1 Child',
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: _TripColors.muted,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              Expanded(
                child: _StatusCell(label: 'Booking ID', value: 'ME12025051501'),
              ),
              _VerticalDivider(),
              Expanded(
                child: _StatusCell(
                  label: 'Booking Status',
                  value: 'Confirmed',
                  type: _StatusType.success,
                ),
              ),
              _VerticalDivider(),
              Expanded(
                child: _StatusCell(
                  label: 'Payment Status',
                  value: 'Paid',
                  type: _StatusType.info,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

enum _StatusType { plain, success, info }

class _StatusCell extends StatelessWidget {
  const _StatusCell({
    required this.label,
    required this.value,
    this.type = _StatusType.plain,
  });

  final String label;
  final String value;
  final _StatusType type;

  @override
  Widget build(BuildContext context) {
    final background = type == _StatusType.success
        ? const Color(0xFFE0F8DE)
        : type == _StatusType.info
        ? const Color(0xFFE2ECFF)
        : Colors.transparent;
    final foreground = type == _StatusType.success
        ? _TripColors.green
        : type == _StatusType.info
        ? _TripColors.blue
        : _TripColors.navy;
    return Column(
      children: [
        Text(label, style: _TripText.caption, textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: type == _StatusType.plain ? 0 : 11,
            vertical: type == _StatusType.plain ? 0 : 4,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: foreground,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator();

  @override
  Widget build(BuildContext context) => const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _Dot(color: _TripColors.blue),
      SizedBox(width: 7),
      _Dot(color: Color(0xFFD8DCE5)),
    ],
  );
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 8,
    height: 8,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  static const actions = [
    (Icons.confirmation_number_outlined, 'View All\nBookings'),
    (Icons.description_outlined, 'Documents\n& Vouchers'),
    (Icons.credit_card_outlined, 'Payment\nHistory'),
    (Icons.headset_mic_outlined, 'Contact\nSupport'),
    (Icons.edit_note_rounded, 'Modify\nBooking'),
  ];

  @override
  Widget build(BuildContext context) => _Surface(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: actions
            .map(
              (action) => Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        width: 43,
                        height: 43,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F5FF),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Icon(
                          action.$1,
                          color: _TripColors.blue,
                          size: 25,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action.$2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: _TripColors.navy,
                          fontSize: 12,
                          height: 1.35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            color: _TripColors.navy,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      TextButton.icon(
        onPressed: () {},
        iconAlignment: IconAlignment.end,
        icon: const Icon(Icons.chevron_right_rounded, size: 19),
        label: const Text('View All'),
        style: TextButton.styleFrom(
          foregroundColor: _TripColors.blue,
          padding: const EdgeInsets.only(left: 10),
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}

class _TripCard extends StatelessWidget {
  const _TripCard({
    required this.image,
    required this.title,
    required this.location,
    required this.dates,
    required this.guests,
    required this.bookingId,
    required this.nights,
    required this.amount,
    required this.balance,
    this.balanceDue = false,
  });

  final String image;
  final String title;
  final String location;
  final String dates;
  final String guests;
  final String bookingId;
  final String nights;
  final String amount;
  final String balance;
  final bool balanceDue;

  @override
  Widget build(BuildContext context) => _Surface(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      image,
                      width: 108,
                      height: 91,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _TripColors.navy,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'UPCOMING',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _TripText.cardTitle,
                    ),
                    const SizedBox(height: 6),
                    _InfoLine(icon: Icons.location_on_outlined, text: location),
                    const SizedBox(height: 5),
                    _InfoLine(icon: Icons.calendar_month_outlined, text: dates),
                    const SizedBox(height: 5),
                    _InfoLine(icon: Icons.group_outlined, text: guests),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.more_vert_rounded,
                  color: _TripColors.navy,
                  size: 21,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: _Detail(label: 'Booking ID', value: bookingId),
              ),
              const _VerticalDivider(),
              Expanded(
                child: _Detail(label: 'Nights', value: nights),
              ),
              const _VerticalDivider(),
              Expanded(
                child: _Detail(label: 'Total Amount', value: amount),
              ),
              const _VerticalDivider(),
              Expanded(
                child: _Detail(
                  label: 'Balance',
                  value: balance,
                  valueColor: balanceDue
                      ? const Color(0xFFF04438)
                      : _TripColors.green,
                ),
              ),
              const SizedBox(width: 4),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: _TripColors.blue,
                  side: const BorderSide(color: _TripColors.blue),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 37),
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: const Text(
                  'View Trip',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _OngoingTripCard extends StatelessWidget {
  const _OngoingTripCard();

  @override
  Widget build(BuildContext context) => _Surface(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      'assets/images/dashboard_hero.png',
                      width: 110,
                      height: 91,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _TripColors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'ONGOING',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Niyama Private Islands', style: _TripText.cardTitle),
                    SizedBox(height: 6),
                    _InfoLine(
                      icon: Icons.location_on_outlined,
                      text: 'Dhaalu Atoll, Maldives',
                    ),
                    SizedBox(height: 5),
                    _InfoLine(
                      icon: Icons.calendar_month_outlined,
                      text: '10 Jun – 14 Jun 2025',
                    ),
                    SizedBox(height: 5),
                    _InfoLine(icon: Icons.group_outlined, text: '2 Adults'),
                  ],
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 88),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F8E6),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Day 3 / 5',
                      style: TextStyle(
                        color: _TripColors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Enjoy your trip!',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: _TripColors.navy, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: const Color(0xFFF1FAF3),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(
            children: [
              _OngoingAction(Icons.today_outlined, "Today's Plan"),
              _OngoingAction(Icons.headset_mic_outlined, 'Live Support'),
              _OngoingAction(Icons.phone_outlined, 'Resort Contact'),
              _OngoingAction(Icons.emergency_outlined, 'Emergency'),
              _OngoingAction(Icons.map_outlined, 'View Itinerary'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _OngoingAction extends StatelessWidget {
  const _OngoingAction(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Icon(icon, color: _TripColors.navy, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: _TripColors.navy,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: _TripColors.muted, size: 17),
      const SizedBox(width: 6),
      Expanded(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: _TripColors.muted, fontSize: 12),
        ),
      ),
    ],
  );
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value, this.valueColor});
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(label, maxLines: 1, style: _TripText.caption),
      const SizedBox(height: 4),
      Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: valueColor ?? _TripColors.navy,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: 35,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    color: const Color(0xFFDDE1E8),
  );
}

class _Surface extends StatelessWidget {
  const _Surface({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: const Color(0xFFE6E9EF)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0C0F2540),
          blurRadius: 14,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

abstract final class _TripColors {
  static const navy = Color(0xFF0A174D);
  static const blue = AppColors.dashboardBlue;
  static const muted = Color(0xFF5F6681);
  static const green = Color(0xFF159447);
}

abstract final class _TripText {
  static const smallTitle = TextStyle(
    color: _TripColors.navy,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static const cardTitle = TextStyle(
    color: _TripColors.navy,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  static const caption = TextStyle(
    color: _TripColors.muted,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
