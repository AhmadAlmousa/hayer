import 'package:flutter/material.dart';

/// One page of the dashboard, as the navigation and the router both see it.
class AdminDestination {
  const AdminDestination({
    required this.route,
    required this.label,
    required this.icon,
  });

  final String route;
  final String label;
  final IconData icon;
}

/// Destinations that answer the same kind of question.
class AdminNavigationGroup {
  const AdminNavigationGroup({required this.title, required this.destinations});

  final String title;
  final List<AdminDestination> destinations;
}

/// The dashboard's navigation, declared once.
///
/// Route, label, icon, and group membership used to live in three parallel
/// lists plus hardcoded index ranges — `for (var i = 5; i < 9; i++)` was what
/// made a page part of Operations. Adding or reordering a page meant editing
/// four places in agreement, and getting it wrong filed the new page silently
/// under the wrong heading. The groups below are the single source: the router
/// takes its paths from them, and both navigation layouts render them.
const adminNavigationGroups = <AdminNavigationGroup>[
  AdminNavigationGroup(
    title: 'Insights',
    destinations: [
      AdminDestination(
        route: '/overview',
        label: 'Overview',
        icon: Icons.dashboard_outlined,
      ),
      AdminDestination(
        route: '/usage',
        label: 'Usage',
        icon: Icons.insights_outlined,
      ),
      AdminDestination(
        route: '/places',
        label: 'Places',
        icon: Icons.favorite_outline_rounded,
      ),
    ],
  ),
  AdminNavigationGroup(
    title: 'Content',
    destinations: [
      AdminDestination(
        route: '/taxonomy',
        label: 'Taxonomy',
        icon: Icons.account_tree_outlined,
      ),
      AdminDestination(
        route: '/catalog',
        label: 'POI catalog',
        icon: Icons.place_outlined,
      ),
    ],
  ),
  AdminNavigationGroup(
    title: 'Operations',
    destinations: [
      AdminDestination(
        route: '/reports',
        label: 'Reports',
        icon: Icons.outlined_flag_rounded,
      ),
      AdminDestination(
        route: '/coverage',
        label: 'Coverage',
        icon: Icons.map_outlined,
      ),
      AdminDestination(
        route: '/jobs',
        label: 'Refresh jobs',
        icon: Icons.sync_rounded,
      ),
      AdminDestination(
        route: '/settings',
        label: 'System policy',
        icon: Icons.tune_rounded,
      ),
    ],
  ),
  AdminNavigationGroup(
    title: 'Governance',
    destinations: [
      AdminDestination(
        route: '/calibration',
        label: 'Calibration',
        icon: Icons.science_outlined,
      ),
      AdminDestination(
        route: '/audit',
        label: 'Audit log',
        icon: Icons.history_rounded,
      ),
    ],
  ),
];

/// Every destination, in the order both layouts render them.
final List<AdminDestination> adminDestinations = [
  for (final group in adminNavigationGroups) ...group.destinations,
];

/// Destination routes, positionally aligned with [adminDestinations] — which is
/// what makes a selected index mean the same thing to the router and to the
/// navigation.
final List<String> adminRoutes = [
  for (final destination in adminDestinations) destination.route,
];

/// A heading over a run of destinations.
class AdminNavigationGroupLabel extends StatelessWidget {
  const AdminNavigationGroupLabel(
    this.label, {
    super.key,
    this.compact = false,
  });

  final String label;

  /// Tighter padding for the wide-layout side navigation, whose column is
  /// narrower than a drawer's.
  final bool compact;

  @override
  Widget build(BuildContext context) => Padding(
    padding: compact
        ? const EdgeInsets.fromLTRB(14, 14, 10, 4)
        : const EdgeInsets.fromLTRB(28, 18, 16, 6),
    child: Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.1,
      ),
    ),
  );
}

/// The wide-layout navigation: the same destinations under the same group
/// headings the narrow drawer shows.
///
/// This replaced a Material `NavigationRail`, which takes a flat
/// `List<NavigationRailDestination>` and has nowhere to put a heading: eleven
/// destinations arrived as one undifferentiated column whose only hint of
/// structure was a tooltip on the rail's leading icon. Labels sit beside their
/// icons rather than under them, because four headings plus stacked labels ran
/// the last group off the bottom of a 900-pixel window — the height a 1080p
/// screen leaves a browser.
class AdminSideNavigation extends StatelessWidget {
  const AdminSideNavigation({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // The column has to grow with the viewer's text scale rather than squeeze
    // scaled labels into a fixed width.
    final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
    var index = 0;
    final children = <Widget>[];
    for (final group in adminNavigationGroups) {
      children.add(AdminNavigationGroupLabel(group.title, compact: true));
      for (final destination in group.destinations) {
        children.add(
          _SideDestination(
            destination: destination,
            selected: index == selectedIndex,
            onSelect: onSelect,
            index: index,
          ),
        );
        index++;
      }
    }
    return Material(
      color: scheme.surface,
      child: SizedBox(
        width: 168 * (scale > 1 ? scale : 1),
        // Scaled text, or a page added later, can outrun a short window, and a
        // column that cannot scroll simply hides its last group.
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class _SideDestination extends StatelessWidget {
  const _SideDestination({
    required this.destination,
    required this.selected,
    required this.onSelect,
    required this.index,
  });

  final AdminDestination destination;
  final bool selected;
  final ValueChanged<int> onSelect;
  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = selected
        ? scheme.onSecondaryContainer
        : scheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      // One node per destination, so a screen reader announces "Overview,
      // selected" as a single stop rather than an unlabelled button followed
      // by loose text.
      child: MergeSemantics(
        key: Key('admin-rail-${destination.route}'),
        child: Semantics(
          button: true,
          selected: selected,
          child: InkWell(
            onTap: () => onSelect(index),
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              decoration: BoxDecoration(
                color: selected ? scheme.secondaryContainer : null,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              child: Row(
                children: [
                  Icon(destination.icon, color: foreground, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      destination.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: foreground,
                        fontWeight: selected
                            ? FontWeight.w900
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
