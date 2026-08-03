import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  RangeValues _price = const RangeValues(900, 4200);
  String _accommodation = 'All';
  String _meal = 'All';
  String _resort = 'All';
  String _duration = 'All';
  String _rating = 'All';
  String _sort = 'Recommended';
  final Set<String> _amenities = {};

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: _FilterColors.navy,
            size: 27,
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: TextStyle(
                color: _FilterColors.navy,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Refine your search to find the perfect holiday',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _FilterColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Image.asset('assets/images/maldives_logo.png', width: 82),
          const SizedBox(width: 10),
        ],
        toolbarHeight: 74,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 110),
        children: [
          const _SearchSummary(),
          const SizedBox(height: 12),
          _FilterSection(
            title: 'Price Range',
            titleSuffix: '(per person)',
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(r'$100', style: _FilterText.label),
                    Expanded(
                      child: RangeSlider(
                        values: _price,
                        min: 100,
                        max: 5000,
                        onChanged: (value) => setState(() => _price = value),
                      ),
                    ),
                    const Text(r'$5,000+', style: _FilterText.label),
                  ],
                ),
                _ChoiceWrap(
                  items: const [
                    r'Under $500',
                    r'$500 - $1,000',
                    r'$1,000 - $2,000',
                    r'$2,000 - $3,000',
                    r'$5,000+',
                  ],
                  selected: r'$1,000 - $2,000',
                  onSelected: (_) {},
                ),
              ],
            ),
          ),
          _FilterSection(
            title: 'Accommodation Type',
            child: _TileChoices(
              items: const [
                ('All', Icons.holiday_village_outlined),
                ('Overwater Villas', Icons.cottage_outlined),
                ('Beach Villas', Icons.beach_access_outlined),
                ('Water Villas', Icons.water_outlined),
                ('Pool Villas', Icons.pool_outlined),
                ('Guest Houses', Icons.house_outlined),
              ],
              selected: _accommodation,
              onSelected: (value) => setState(() => _accommodation = value),
            ),
          ),
          _FilterSection(
            title: 'Meal Plan',
            child: _TileChoices(
              items: const [
                ('All', Icons.restaurant_outlined),
                ('All Inclusive', Icons.local_drink_outlined),
                ('Breakfast', Icons.free_breakfast_outlined),
                ('Half Board', Icons.rice_bowl_outlined),
                ('Full Board', Icons.lunch_dining_outlined),
                ('Room Only', Icons.room_service_outlined),
              ],
              selected: _meal,
              onSelected: (value) => setState(() => _meal = value),
            ),
          ),
          _FilterSection(
            title: 'Resort Type',
            child: _TileChoices(
              items: const [
                ('All', Icons.beach_access_outlined),
                ('Luxury', Icons.workspace_premium_outlined),
                ('Premium', Icons.auto_awesome_outlined),
                ('Budget', Icons.account_balance_wallet_outlined),
                ('Boutique', Icons.storefront_outlined),
                ('Family Friendly', Icons.family_restroom_outlined),
              ],
              selected: _resort,
              onSelected: (value) => setState(() => _resort = value),
            ),
          ),
          _FilterSection(
            title: 'Duration (Nights)',
            child: _TileChoices(
              items: const [
                ('All', Icons.calendar_month_outlined),
                ('3 Nights or less', Icons.event_outlined),
                ('4 - 6 Nights', Icons.event_outlined),
                ('7 - 10 Nights', Icons.event_outlined),
                ('10+ Nights', Icons.event_outlined),
                ('Custom', Icons.more_horiz_rounded),
              ],
              selected: _duration,
              onSelected: (value) => setState(() => _duration = value),
            ),
          ),
          _FilterSection(
            title: 'Star Rating',
            child: _ChoiceWrap(
              items: const [
                'All',
                '★★★★★  5 Star',
                '★★★★  4 Star & above',
                '★★★  3 Star & above',
                '★★  2 Star & above',
              ],
              selected: _rating,
              onSelected: (value) => setState(() => _rating = value),
            ),
          ),
          _FilterSection(
            title: 'Facilities & Amenities',
            trailing: TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  [
                        'Free WiFi',
                        'Swimming Pool',
                        'Spa',
                        'Gym',
                        'Kids Club',
                        'Water Sports',
                        'Diving Center',
                        'Private Beach',
                        'Butler Service',
                        'Seaplane Transfer',
                      ]
                      .map(
                        (item) => FilterChip(
                          label: Text(
                            item,
                            style: const TextStyle(fontSize: 12),
                          ),
                          selected: _amenities.contains(item),
                          onSelected: (selected) => setState(
                            () => selected
                                ? _amenities.add(item)
                                : _amenities.remove(item),
                          ),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: _FilterColors.border),
                        ),
                      )
                      .toList(),
            ),
          ),
          _FilterSection(
            title: 'Atoll / Location',
            child: DropdownButtonFormField<String>(
              initialValue: 'Any Atoll',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
              ),
              items:
                  const ['Any Atoll', 'Malé Atoll', 'Baa Atoll', 'Dhaalu Atoll']
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (_) {},
            ),
          ),
          _FilterSection(
            title: 'Sort By',
            child: Wrap(
              spacing: 16,
              runSpacing: 10,
              children:
                  [
                        'Recommended',
                        'Price: Low to High',
                        'Price: High to Low',
                        'Top Rated',
                        'Newest First',
                      ]
                      .map(
                        (item) => InkWell(
                          onTap: () => setState(() => _sort = item),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _sort == item
                                      ? Icons.radio_button_checked_rounded
                                      : Icons.radio_button_unchecked_rounded,
                                  color: _sort == item
                                      ? _FilterColors.blue
                                      : _FilterColors.muted,
                                  size: 24,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
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
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x160A174D),
                blurRadius: 16,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: _BottomActions(
            onReset: _reset,
            onApply: () => Navigator.pop(context),
          ),
        ),
      ),
    ),
  );

  void _reset() => setState(() {
    _price = const RangeValues(100, 5000);
    _accommodation = _meal = _resort = _duration = _rating = 'All';
    _sort = 'Recommended';
    _amenities.clear();
  });
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.onReset, required this.onApply});

  final VoidCallback onReset;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final reset = OutlinedButton.icon(
      onPressed: onReset,
      icon: const Icon(Icons.refresh_rounded, size: 22),
      label: const Text('Reset All'),
      style: OutlinedButton.styleFrom(
        foregroundColor: _FilterColors.blue,
        minimumSize: const Size(0, 50),
        side: const BorderSide(color: _FilterColors.blue),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      ),
    );
    final apply = FilledButton.icon(
      onPressed: onApply,
      icon: const Icon(Icons.tune_rounded, size: 22),
      label: const Text('Apply Filters  (342 Results)'),
      style: FilledButton.styleFrom(
        backgroundColor: _FilterColors.blue,
        minimumSize: const Size(0, 50),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 345) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [apply, const SizedBox(height: 8), reset],
          );
        }
        return Row(
          children: [
            Expanded(flex: 2, child: reset),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: apply),
          ],
        );
      },
    );
  }
}

class _SearchSummary extends StatelessWidget {
  const _SearchSummary();
  @override
  Widget build(BuildContext context) => _FilterSection(
    title: 'Your Search',
    trailing: TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.edit_outlined, size: 17),
      label: const Text('Edit Search'),
    ),
    child: const Column(
      children: [
        Row(
          children: [
            _SummaryItem(
              Icons.location_on_outlined,
              'Malé Atoll',
              'Destination',
            ),
            _SummaryItem(
              Icons.calendar_month_outlined,
              '20 May - 24 May 2025',
              'Dates',
            ),
            _SummaryItem(
              Icons.person_outline_rounded,
              '2 Adults, 0 Children',
              'Guests',
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            _SummaryItem(Icons.paid_outlined, 'Any Budget', 'Budget'),
            _SummaryItem(
              Icons.bed_outlined,
              '1 Room, All Meals',
              'Room & Meal Plan',
            ),
          ],
        ),
      ],
    ),
  );
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem(this.icon, this.value, this.label);
  final IconData icon;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Row(
      children: [
        Icon(icon, color: _FilterColors.navy, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _FilterColors.navy,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: _FilterColors.muted,
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.title,
    required this.child,
    this.titleSuffix,
    this.trailing,
  });
  final String title;
  final String? titleSuffix;
  final Widget? trailing;
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFEBEDF2)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x080A174D),
          blurRadius: 12,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(child: Text(title, style: _FilterText.section)),
                  if (titleSuffix != null) ...[
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        titleSuffix!,
                        style: const TextStyle(
                          color: _FilterColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              Flexible(
                child: FittedBox(fit: BoxFit.scaleDown, child: trailing!),
              ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

class _TileChoices extends StatelessWidget {
  const _TileChoices({
    required this.items,
    required this.selected,
    required this.onSelected,
  });
  final List<(String, IconData)> items;
  final String selected;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final tileHeight = (100 + ((textScale - 1).clamp(0, 1) * 24)).toDouble();

    Widget choice((String, IconData) item) {
      final active = selected == item.$1;
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            onTap: () => onSelected(item.$1),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: tileHeight,
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 9),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFF6F9FF) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: active ? _FilterColors.blue : _FilterColors.border,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.$2,
                    color: active ? _FilterColors.blue : _FilterColors.navy,
                    size: 30,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    item.$1,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: active ? _FilterColors.blue : _FilterColors.navy,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(children: items.take(3).map(choice).toList()),
        const SizedBox(height: 8),
        Row(children: items.skip(3).take(3).map(choice).toList()),
      ],
    );
  }
}

class _ChoiceWrap extends StatelessWidget {
  const _ChoiceWrap({
    required this.items,
    required this.selected,
    required this.onSelected,
  });
  final List<String> items;
  final String selected;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: items.map((item) {
      final active = selected == item;
      return ChoiceChip(
        label: Text(item, style: const TextStyle(fontSize: 12)),
        selected: active,
        onSelected: (_) => onSelected(item),
        selectedColor: const Color(0xFFEFF4FF),
        side: BorderSide(
          color: active ? _FilterColors.blue : _FilterColors.border,
        ),
        showCheckmark: false,
      );
    }).toList(),
  );
}

abstract final class _FilterColors {
  static const navy = Color(0xFF0A174D);
  static const blue = Color(0xFF0754E8);
  static const muted = Color(0xFF626980);
  static const border = Color(0xFFDDE2EB);
}

abstract final class _FilterText {
  static const section = TextStyle(
    color: _FilterColors.navy,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  static const label = TextStyle(
    color: _FilterColors.navy,
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );
}
