import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A view an operator can act in, offered next to the figure that would send
/// them there.
///
/// The analytics pages report; they never change anything. Until now a reader
/// who saw a stalled refresh queue, a thin city, or a place the room kept
/// rejecting had to know for themselves which of the eleven destinations owns
/// that problem, and search it again by hand. Each link names the destination
/// and what can be done there, and carries the figure's own subject with it
/// where the destination can filter by one.
///
/// A link states where the responsible controls are. It does not assert that
/// the figure is a defect, because the dashboard cannot tell product friction
/// from weak supply on its own — that judgement stays with the operator.
class AdminNextAction {
  const AdminNextAction({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
    required this.location,
  });

  /// Stable identifier, also the suffix of the link's widget key.
  final String id;

  /// The destination, named as the navigation names it.
  final String label;

  /// What an operator can do there, shown as the link's tooltip.
  final String description;

  final IconData icon;

  /// Router location, including any filter the figure supplies.
  final String location;

  /// Catalog refreshes: the queue behind cache freshness and source success.
  static const refreshJobs = AdminNextAction(
    id: 'refresh-jobs',
    label: 'Refresh jobs',
    description: 'Queue, retry, or cancel catalog refresh jobs.',
    icon: Icons.sync_rounded,
    location: '/jobs',
  );

  /// The catalog itself: what a place holds, and whether it stays in decks.
  static const catalog = AdminNextAction(
    id: 'catalog',
    label: 'POI catalog',
    description: 'Inspect places, and quarantine or restore one.',
    icon: Icons.place_outlined,
    location: '/catalog',
  );

  /// Demand against usable supply, which is what a busy city with thin decks
  /// needs looked at.
  static const coverage = AdminNextAction(
    id: 'coverage',
    label: 'Coverage',
    description: 'Compare demand against usable supply by area.',
    icon: Icons.map_outlined,
    location: '/coverage',
  );

  /// Category, cuisine, and type mapping — what selection labels resolve to.
  static const taxonomy = AdminNextAction(
    id: 'taxonomy',
    label: 'Taxonomy',
    description: 'Review how categories, cuisines, and types are mapped.',
    icon: Icons.account_tree_outlined,
    location: '/taxonomy',
  );

  /// The moderation queue for reported factual problems.
  static const reports = AdminNextAction(
    id: 'reports',
    label: 'POI issue reports',
    description: 'Claim, confirm, or dismiss reported data problems.',
    icon: Icons.outlined_flag_rounded,
    location: '/reports',
  );

  /// The catalog, searched for [name].
  ///
  /// The catalog search matches the place name only, so a place is carried
  /// there by name rather than by id.
  factory AdminNextAction.catalogForPlace(String name) => AdminNextAction(
    id: 'catalog-place',
    label: 'Open in POI catalog',
    description: 'Inspect “$name”, and quarantine or restore it.',
    icon: catalog.icon,
    location: _locate(catalog.location, name),
  );

  /// The issue queue, searched for [placeId].
  ///
  /// The report search matches report id, place id, or place name; the id is
  /// used because two places can share a name.
  factory AdminNextAction.reportsForPlace(String placeId, String name) =>
      AdminNextAction(
        id: 'reports-place',
        label: 'Open POI issue reports',
        description: 'Review reports filed against “$name”.',
        icon: reports.icon,
        location: _locate(reports.location, placeId),
      );

  /// Navigates to this action's view, carrying its filter.
  void navigate(BuildContext context) => context.go(location);

  static String _locate(String path, String query) =>
      Uri(path: path, queryParameters: {'q': query}).toString();
}

/// A link to where [action] can be carried out.
class NextActionLink extends StatelessWidget {
  const NextActionLink(this.action, {super.key});

  final AdminNextAction action;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: action.description,
    child: TextButton.icon(
      key: Key('next-action-${action.id}'),
      onPressed: () => action.navigate(context),
      icon: Icon(action.icon, size: 18),
      label: Text(action.label),
    ),
  );
}

/// The footer of a reporting card: where to act on what it just showed.
///
/// A [Wrap] rather than a row, so the links stack instead of overflowing when
/// the viewer has scaled text up.
class NextActionBar extends StatelessWidget {
  const NextActionBar({super.key, required this.actions});

  final List<AdminNextAction> actions;

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 1, color: scheme.outlineVariant),
          const SizedBox(height: 6),
          Wrap(
            spacing: 4,
            runSpacing: 2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  'Act on this in',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
              for (final action in actions) NextActionLink(action),
            ],
          ),
        ],
      ),
    );
  }
}
